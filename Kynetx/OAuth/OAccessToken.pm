package Kynetx::OAuth::OAccessToken;

# file: Kynetx/OAuth/Authorize.pm
#
# This file is part of the Kinetic Rules Engine (KRE)
# Copyright (C) 2007-2011 Kynetx, Inc. 
#
# KRE is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public
# License along with this program; if not, write to the Free
# Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
# MA 02111-1307 USA
#
use strict;
use lib qw(/web/lib/perl);
use utf8;
use warnings;

use Log::Log4perl qw(get_logger :levels);

use Data::Dumper;
$Data::Dumper::Indent = 1;

use HTML::Template;
use JSON::XS;
use Cache::Memcached;
use DateTime::Format::ISO8601;
use Benchmark ':hireswallclock';
use Encode qw(from_to);
use Digest::MD5 qw(md5_base64);

use Kynetx::Util;
use Kynetx::Persistence::KEN qw(
  ken_lookup_by_username
);
use Kynetx::Modules::PCI qw(
  auth_ken
);

use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

use Apache2::Const qw(FORBIDDEN OK :http :common);

no warnings 'redefine';

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

# put exported names inside the "qw"
our %EXPORT_TAGS = (
    all => [
        qw(
          )
    ]
);
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our $TEN_MINUTES = 600;


sub handler {
  my $r = shift;
  Kynetx::Memcached->init();
  Kynetx::Util::config_logging($r);
  Log::Log4perl::MDC->put('site', 'OAuth2.0');
  Log::Log4perl::MDC->put('rule', '[OAccessToken]');
  
  my $logger = get_logger();
  eval {
     $logger->remove_appender('ConsoleLogger');
  };
  # get the client-supplied credentials
  $logger->debug("Access Token Request handler");
  
  my $user = $r->user;
  my $req = Apache2::Request->new($r);
  my $cid = $req->param('client_id');
  my $code = $req->param('code');
  my $grant = $req->param('grant_type');
  my $redirect_uri = $req->param('redirect_uri');
  
  if ($user ne $cid) {
    $logger->debug("Client Id/Developer mis-match");
    return Apache2::Const::HTTP_UNAUTHORIZED;
  }
  $logger->debug("Developer: $user");
  $logger->debug("Code: $code");
  $logger->debug("Grant: $grant");
  $logger->debug("Redirect: $redirect_uri");
  
  
  my $md5_sig = md5_base64($code);
  $logger->debug("Check cache for $md5_sig");
  my $code_exists = Kynetx::Memcached::check_cache($md5_sig);
  if ($code_exists) {
    $logger->debug("Fail on duplicate code");
    return return_error($r,$redirect_uri,'invalid_request','Duplicate request codes not allowed');
  }
  my $decon = Kynetx::Modules::PCI::deconstruct_oauth_code($user,$code);
  my $time = $decon->[0];
  my $eci = $decon->[1];
  my $secret = $decon->[2];
  my $oauth_user = $decon->[3];
  if ($eci ne $cid) {
    $logger->debug("Client Id/Developer code mis-match");
    return Apache2::Const::HTTP_BAD_REQUEST;
  }
  
  $logger->debug("Time: $time");
  $logger->debug("ECI: $eci");
  $logger->debug("secret: $secret");
  $logger->debug("oauth user: ", sub {Dumper($oauth_user)});
  my $now = time();
  my $elapsed = $now - $time;
  return return_error($r,$redirect_uri,'invalid_request',"Request token code is stale") unless ($elapsed < $TEN_MINUTES);
  
  
  my $ken = Kynetx::Persistence::KEN::ken_lookup_by_token($oauth_user);
  my ($token,$oauth_eci);
  my $otoken = check_token($ken,$user);
  if ($otoken && ref $otoken eq "HASH") {
    $token = $otoken->{'token_name'};
    $oauth_eci = $otoken->{'ktoken'};
  } else {
    # so far so good, now create the encrypted token name
    $token = Kynetx::Modules::PCI::create_oauth_token($cid,$oauth_user,$secret);
    $oauth_eci = Kynetx::Modules::PCI::create_oauth_indexed_eci($ken,$token,$eci);
  }
  
  $logger->debug("Token: $token");    
  $logger->debug("OECI: $oauth_eci");
  
  # store the code in memcached so it can't be used again
  
  Kynetx::Memcached::mset_cache($md5_sig,1,6060);
  
  # Server response
  $r->content_type('application/json;charset=UTF-8');
  $r->headers_out->set('Cache-Control' => 'no-store');
  $r->headers_out->set('Pragma' => 'no-cache');
  $r->status(Apache2::Const::HTTP_OK);
  $r->print( "{\n \"access_token\":\"$token\",\n \"OAUTH_ECI\":\"$oauth_eci\"\n}");
  return Apache2::Const::OK;
}

sub return_error {
  my ($r,$uri,$code,$description) = @_;
  $r->content_type('application/json;charset=UTF-8');
  $r->headers_out->set('Cache-Control' => 'no-store');
  $r->headers_out->set('Pragma' => 'no-cache');
  $r->status(Apache2::Const::HTTP_BAD_REQUEST);
  $r->print( "{\n \"error\":\"$code\",\n \"error_description\":\"$description\"\n}");
  return Apache2::Const::HTTP_BAD_REQUEST;
}

sub check_token {
  my ($ken,$developer_eci) = @_;
  my $logger = get_logger();
  my $etype = "OAUTH-$developer_eci";
  my $var = {
    'endpoint_type' => $etype,
    'ken' => $ken
  };
  $logger->debug("Key: ", sub {Dumper($var)});
  my $token = Kynetx::Persistence::KToken::token_query($var);
  $logger->debug("token: ", sub {Dumper($token)});
}

1;
