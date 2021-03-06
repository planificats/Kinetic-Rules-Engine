#!/usr/bin/perl -w
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
use lib qw(/web/lib/perl);
use strict;
use warnings;

use Test::More;
use Test::LongString;

# most Kyentx modules require this
use Log::Log4perl qw(get_logger :levels);
Log::Log4perl->easy_init($INFO);
#Log::Log4perl->easy_init($DEBUG);

use Apache2::Const;
use APR::URI;
use APR::Pool;

use Apache::Session::Memcached;
use DateTime;
use APR::URI;
use APR::Pool ();
use Cache::Memcached;

use Kynetx::Test qw/:all/;
use Kynetx::Environments qw/:all/;
use Kynetx::Session qw/:all/;
use Kynetx::Configure qw/:all/;
use Kynetx::Modules::Twilio qw/:all/;
use Kynetx::JavaScript qw(mk_js_str gen_js_var);
use Kynetx::Rids qw(:all);
use Kynetx::Rules qw(:all);
use Kynetx::Actions qw(:all);
use Kynetx::Expressions qw(:all);
use Kynetx::Response qw(:all);

use Kynetx::FakeReq qw/:all/;


use Data::Dumper;
$Data::Dumper::Indent = 1;


my $preds = Kynetx::Modules::Twilio::get_predicates();
my @pnames = keys (%{ $preds } );

my $r = Kynetx::Test::configure();

my $rid = 'cs_test';

# test choose_action and args

my $my_req_info = Kynetx::Test::gen_req_info($rid);

my $rule_env = Kynetx::Test::gen_rule_env();

#diag Dumper $my_req_info;


my $twilio_number = '4155992671';
my $pin = "2519-4073";

$my_req_info->{"$rid:ruleset_name"} = "cs_test";
$my_req_info->{"$rid:name"} = "cs_test";
$my_req_info->{"$rid:author"} = "Phil Windley";
$my_req_info->{"$rid:description"} = "This is a test rule";

my $rule_name = 'foo';

my $session = Kynetx::Test::gen_session($r, $rid);

my $logger = get_logger();

my($js);

# these are KRE generic consumer tokens
my $keys = {'account_sid' => 'AC906568eb40ef29e45c53920fb9ae60e6',
	    'auth_token' => 'c4b151c3ee6b306530f1fb2e287343f2'
	   };

($js, $rule_env) = 
 Kynetx::Keys::insert_key(
  $my_req_info,
  $rule_env,
  'twilio',
  $keys);

my $test_count = 1;

my $creds = Kynetx::OAuth::OAuthHelper::get_consumer_tokens($my_req_info,$rule_env,$session,'twilio');

$logger->debug("twilio creds: ", sub {Dumper($creds)});
ok(1);

my $krl_src;
my $krl;
my $config;
my $result;

my $dd = Kynetx::Response->create_directive_doc($my_req_info->{'eid'});

$config = mk_config_string(
  [
   {"rule_name" => 'twi_test_rule'},
   {"rid" => 't_test'},
   {"txn_id" => '1234'},
]);

$krl_src = <<_KRL_;
twilio:say("Hey there") setting (r)
    with
        voice = "snooty" and
        language = "potty";

_KRL_

$krl = Kynetx::Parser::parse_action($krl_src)->{'actions'}->[0];

$js = Kynetx::Actions::build_one_action(
        $krl,
        $my_req_info,
	$dd,
        $rule_env,
        $session,
        'callback23',
        'stinky_cheese');

$result = lookup_rule_env('r',$rule_env);

#$logger->debug("AST: ", sub {Dumper($krl)});
#$logger->debug("JS: ", sub {Dumper($js)});
#$logger->debug("Result: ", sub {Dumper($result)});
$krl_src = <<_KRL_;
twilio:place_call("8015551212", "8015551234","www.example.com") setting (r);
_KRL_

$krl = Kynetx::Parser::parse_action($krl_src)->{'actions'}->[0];

$js = Kynetx::Actions::build_one_action(
        $krl,
        $my_req_info,
	$dd,
        $rule_env,
        $session,
        'callback23',
        'stinky_cheese');

$result = lookup_rule_env('r',$rule_env);



done_testing($test_count + int(@pnames));

session_cleanup($session);

1;


