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

use Test::More;
use Test::LongString max => 100;
use Test::Deep;
use Data::Dumper;
use LWP::UserAgent;
use LWP::Simple;
use JSON::XS;
use Apache::Session::Memcached;

use APR::URI;
use Cache::Memcached;
use APR::Pool ();


# most Kyentx modules require this
use Log::Log4perl qw(get_logger :levels);
Log::Log4perl->easy_init($INFO);
#Log::Log4perl->easy_init($DEBUG);
#Log::Log4perl->easy_init($TRACE);
my $logger = get_logger();

use Kynetx::Test qw/:all/;
use Kynetx::Datasets qw/:all/;
use Kynetx::JavaScript qw/:all/;
use Kynetx::Parser qw/:all/;
use Kynetx::Configure;
use Kynetx::FakeReq qw/:all/;
use Kynetx::Environments qw/:all/;
use Kynetx::Rules qw/:all/;
use Kynetx::Predicates::RSS qw/:all/;
use Kynetx::Session qw/:all/;

Kynetx::Configure::configure();

my $krl_full = <<_KRL_;
ruleset txml {
    meta {
        name "xml test"
        description <<
Dataset manipulation             >>
        logging on    }
    global {
        dataset feed_data:RSS <- "http://feeds.finance.yahoo.com/rss/2.0/category-stocks?region=US&lang=en-US" cachable for 30 minutes;
     }
    rule txml_rule is active {
        select using ".*" setting ()

        pre {
            rss_item = rss:last(feed_data);
            title = rss:item(rss_item,"title");
         }
        every {
            notify("RSS feed: ", title)
                with
                    sticky = true and
                    opacity = 1;            
        }
    }
}
_KRL_

sub get_rss_dataset {
    my ($krl,$req_info,$rule_env) = @_;
    my $ds = get_dataset($krl,$req_info);
    my($this_js, $val, $var) = mk_dataset_js($krl, $req_info, $rule_env);

    return ($ds,$var);    
    
}


my ($krl_src, $krl);

my $expected = {
    'version' => '2.0',
    'items' => 'ARRAY',
    'first' => 'HASH',  
    'last' => 'HASH',  
    'index' => 'HASH', 
    'random' => 'HASH', 
};

my $e_channel = {
  'title' => 'Liftoff News',
  'link' => 'http://liftoff.msfc.nasa.gov/',
  'description' => 'Liftoff to Space Exploration.',
  'language' => 'en-us',
  'copyright' => undef,
  'managingEditor' => 'editor@example.com',
  'webMaster' => 'webmaster@example.com',
  'pubDate' => 'Tue, 10 Jun 2003 04:00:00 GMT',
  'lastBuildDate' => 'Tue, 10 Jun 2003 09:41:01 GMT',
  'category' => undef,
  'generator' => 'Weblog Editor 2.0',
  'docs' => 'http://blogs.law.harvard.edu/tech/rss',
  'cloud' => undef,
  'ttl' => undef,
  'image' => undef,
  'rating' => undef,
  'textInput' => undef,
  'skipHours' => undef,
  'skipDays' => undef,    
};

my $e_item = {
  'title' => 'The Engine That Does More',
  'link' => 'http://liftoff.msfc.nasa.gov/news/2003/news-VASIMR.asp',
  'description' => 'Before man travels to Mars, NASA hopes to design new engines that will let us fly through the Solar System more quickly.  The proposed VASIMR engine would do that.',
  'author' => undef,
  'category' => undef,
  'comments' => undef,
  'enclosure' => undef,
  'guid' => 'http://liftoff.msfc.nasa.gov/2003/05/27.html#item571',
  'pubDate' => 'Tue, 27 May 2003 08:37:32 GMT',
  'source' => undef,  
};


my $got;
my $rid = 'abcd1234';
my $rule_name = 'rfoo';
my $args;

my $r = Kynetx::Test::configure();
my $session = Kynetx::Test::gen_session($r, $rid);


my $req_info = Kynetx::Test::gen_req_info($rid);
my $rule_env = Kynetx::Test::gen_rule_env();

    $krl_src = <<_KRL_;
global {
   dataset fizz_data:RSS <- "http://cyber.law.harvard.edu/rss/examples/rss2sample.xml";
   dataset feed_data:RSS <- "http://feeds.finance.yahoo.com/rss/2.0/category-stocks?region=US&lang=en-US";
}
_KRL_
    $krl = Kynetx::Parser::parse_global_decls($krl_src);
    my ($basic_ds,$basic_rss) = get_rss_dataset($krl->[0],$req_info,$rule_env);
    
    my ($yahoo_ds,$yahoo_rss) = get_rss_dataset($krl->[1],$req_info,$rule_env);
        
    #$logger->debug("RSS part: ", sub {Dumper(get_rss($basic_rss,qr/^rss$/))});
    
    my $preds = Kynetx::Predicates::RSS::get_predicates();
    my @pnames = keys(%{$preds});
    
    foreach my $pn (@pnames) {
      my $outvalue = &{$preds->{$pn}}($req_info, $rule_env,[$basic_rss,2]);
      #$logger->debug($pn,': ',$outvalue);
      if (ref $outvalue) {
          is (ref $outvalue,$expected->{$pn},"$pn works");
      } else {
        is($outvalue,$expected->{$pn},"$pn works");
      }
    }
    
# Eval functions

$args = [$yahoo_rss,'title'];
$got = Kynetx::Predicates::RSS::eval_rss($req_info,$rule_env,$session,$rule_name,'channel',$args);
$logger->debug("got: " ,sub {Dumper($got)});

$args = [$basic_rss,'title'];
$got = Kynetx::Predicates::RSS::eval_rss($req_info,$rule_env,$session,$rule_name,'channel',$args);
$logger->debug("got: " ,sub {Dumper($got)});

$args = [&{$preds->{'random'}}($req_info, $rule_env,[$yahoo_rss,2]),'title'];
$got = Kynetx::Predicates::RSS::eval_rss($req_info,$rule_env,$session,$rule_name,'item',$args);
$logger->debug("got: " ,sub {Dumper($got)});

$logger->debug("basic: ", sub {Dumper($basic_rss)});
my $prune = Kynetx::Predicates::RSS::get_rss($basic_rss,qr/^item$/);
$logger->debug("prune: ", sub {Dumper($prune)});

$args = [$yahoo_rss,'title'];
$got = Kynetx::Predicates::RSS::eval_rss($req_info,$rule_env,$session,$rule_name,'item',$args);
$logger->debug("got: " ,sub {Dumper($got)});

$args = [$yahoo_rss,'content','media'];
$got = Kynetx::Predicates::RSS::eval_rss($req_info,$rule_env,$session,$rule_name,'item',$args);
$logger->debug("got: " ,sub {Dumper($got)});

$args = [$yahoo_rss,'image'];
$got = Kynetx::Predicates::RSS::eval_rss($req_info,$rule_env,$session,$rule_name,'channel',$args);
$logger->debug("got: " ,sub {Dumper($got)});

foreach my $channel_element (Kynetx::Predicates::RSS::get_channel_names()) {
    $args = [$basic_rss,$channel_element];
    $got = Kynetx::Predicates::RSS::eval_rss($req_info,$rule_env,$session,$rule_name,'channel',$args);
    is($got,$e_channel->{$channel_element},"Channel $channel_element works");
}

foreach my $item_element (Kynetx::Predicates::RSS::get_item_names()) {
    $args = [&{$preds->{'index'}}($req_info, $rule_env,[$basic_rss,3]),$item_element];
    $got = Kynetx::Predicates::RSS::eval_rss($req_info,$rule_env,$session,$rule_name,'item',$args);
    is($got,$e_item->{$item_element},"Channel $item_element works");
}

# my $parsed = Kynetx::Parser::parse_ruleset($krl_full);
# my $rs = Kynetx::Rules::eval_ruleset($r,
#         $req_info,
#         empty_rule_env(),
#         $session,
#         $parsed,
#         $parsed->{'rules'});
        
# $logger->debug("Rule: ", sub {Dumper($rs)});
        
plan tests => (int(@pnames) +  int(keys %$e_channel) + int(keys %$e_item)); 

1;


