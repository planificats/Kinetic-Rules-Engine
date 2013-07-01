package Kynetx::OAuth::OAuth20;

# file: Kynetx/OAuth/OAuth20.pm
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

use Kynetx::Util;

use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

use Apache2::Const qw(FORBIDDEN OK :http);

no warnings 'redefine';

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

# put exported names inside the "qw"
our %EXPORT_TAGS = (
    all => [
        qw(
        query_param
          )
    ]
);
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );


sub handler {
    my $r = shift;
    Kynetx::Util::config_logging($r);
    Log::Log4perl::MDC->put('site', 'OAuth2.0');
    Log::Log4perl::MDC->put('rule', '[OAuth Main]');
    my $logger=get_logger('Kynetx');

    $logger->debug("OAuth2.0 Main");
    $logger->debug("Args: ",$r->args);
    $logger->debug("URI: ",$r->unparsed_uri());
    
    # We shouldn't ever get here because the user
    # should be redirected before the PerlRequestHandler is ever called
    return Apache2::Const::HTTP_BAD_REQUEST;
}

sub config_logging {
  my ($r) = @_;
  my $appender = Log::Log4perl::Appender->new();
}

sub query_param {
  my ($qstring,$key) = @_;
  $qstring = URI::Escape::uri_unescape($qstring);
  my $params;
  my @pairs = split(/\&/,$qstring);
  $params = Kynetx::Util::from_pairs(\@pairs);
  return $params->{$key};
}

sub post_param {
  my ($r,$key) = @_;
  my $logger= get_logger();
  my $req = Apache2::Request->new($r);
  return $req->param($key);  
}
1;