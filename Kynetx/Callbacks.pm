package Kynetx::Callbacks;
# file: Kynetx/Callbacks.pm
#
# Copyright 2007-2009, Kynetx Inc.  All rights reserved.
# 
# This Software is an unpublished, proprietary work of Kynetx Inc.
# Your access to it does not grant you any rights, including, but not
# limited to, the right to install, execute, copy, transcribe, reverse
# engineer, or transmit it by any means.  Use of this Software is
# governed by the terms of a Software License Agreement transmitted
# separately.
# 
# Any reproduction, redistribution, or reverse engineering of the
# Software not in accordance with the License Agreement is expressly
# prohibited by law, and may result in severe civil and criminal
# penalties. Violators will be prosecuted to the maximum extent
# possible.
# 
# Without limiting the foregoing, copying or reproduction of the
# Software to any other server or location for further reproduction or
# redistribution is expressly prohibited, unless such reproduction or
# redistribution is expressly permitted by the License Agreement
# accompanying this Software.
# 
# The Software is warranted, if at all, only according to the terms of
# the License Agreement. Except as warranted in the License Agreement,
# Kynetx Inc. hereby disclaims all warranties and conditions
# with regard to the software, including all warranties and conditions
# of merchantability, whether express, implied or statutory, fitness
# for a particular purpose, title and non-infringement.
# 
use strict;
use warnings;

use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

our $VERSION     = 1.00;
our @ISA         = qw(Exporter);

our %EXPORT_TAGS = (all => [ 
qw(
process_callbacks
) ]);
our @EXPORT_OK   =(@{ $EXPORT_TAGS{'all'} }) ;



use Log::Log4perl qw(get_logger :levels);
use Data::UUID;

use Kynetx::Session qw(:all);
use Kynetx::Util qw(:all);
use Kynetx::Version qw(:all);
use Kynetx::Repository qw(:all);
use Kynetx::Request qw(:all);
use Kynetx::Environments qw(:all);
use Kynetx::Actions qw(:all);



sub handler {
    my $r = shift;

    # configure logging for production, development, etc.
    config_logging($r);

    Log::Log4perl::MDC->put('site', '[global]');
    Log::Log4perl::MDC->put('rule', '[callbacks]'); 

    $r->content_type('text/javascript');

    # set up memcached
    Kynetx::Memcached->init();

    my ($rids) = $r->path_info =~ m!/([A-Za-z0-9_;]*)/?!;

    my $logger = get_logger();

    if($rids eq 'version' ) {
    # store these for later logging
	$r->subprocess_env(METHOD => 'version');
	show_build_num($r);
    } else {
	process_action($r, $rids);
    }

    return Apache2::Const::OK; 
}


1;


sub process_action {
    my ($r, $rids, $method) = @_;

    my $logger = get_logger();


    $r->subprocess_env(START_TIME => Time::HiRes::time);


    # get a session hash from the cookie or build a new one
    my $session = process_session($r);

    # build initial env
    my $req_info = Kynetx::Request::build_request_env($r, 'callback', $rids);

#    my $ug = new Data::UUID;
#    my $path_info = $r->uri;
#     my %request_info = (
# 	host => $r->connection->get_remote_host,
# 	caller => $r->headers_in->{'Referer'},
# 	now => time,
# 	site => $path_info =~ m#/log|callback/([^/]+)#,
# 	hostname => $r->hostname(),
# 	ip => $r->connection->remote_ip(),
# 	txn_id => $ug->create_str(),
# 	);

    Log::Log4perl::MDC->put('site', $req_info->{'site'});

    my $req = Apache2::Request->new($r);

    $req_info->{'rid'} = $req->param('rid');

#    Kynetx::Request::log_request_env($logger, $req_info);

    process_callbacks(get_ruleset($req_info->{'rid'}, 
				  $req_info),
		      $req->param('rule'),
		      $req->param('sense'),
		      $req->param('type'),
		      $req->param('element'),
		      $req_info,
		      $session) if $req_info->{'rid'};
		      


    # store these for later logging
    $r->subprocess_env(METHOD => 'callback');
    $r->subprocess_env(RIDS => $req_info->{'site'});
    $r->subprocess_env(SITE => $req_info->{'site'});
    $r->subprocess_env(RID => $req_info->{'rid'});

    # make sure we use the one sent, not the one for this interaction
    $r->subprocess_env(TXN_ID => $req->param('txn_id'));
    $r->subprocess_env(CALLER => $req_info->{'caller'});

    my $sid = session_id($session);
    $r->subprocess_env(SID => $sid);

    $r->subprocess_env(IP => $req_info->{'ip'});
    $r->subprocess_env(REFERER => $req_info->{'referer'});
    $r->subprocess_env(TITLE => $req_info->{'title'});
    $r->subprocess_env(URL => $req->param('url'));
    $r->subprocess_env(SENSE => $req->param('sense'));
    $r->subprocess_env(TYPE => $req->param('type'));
    $r->subprocess_env(ELEMENT => $req->param('element'));
    $r->subprocess_env(RULE_NAME => $req->param('rule'));

    if($req->param('type') eq 'click') {
      $r->subprocess_env(CB_INFO => $req->param('url'));
    } elsif ($req->param('type') eq 'explicit') {
      $r->subprocess_env(CB_INFO => $req->param('message'));
    }

    $logger->debug("Finish time: ", time, " Start time: ", $r->subprocess_env('START_TIME'));
   
    if($req->param('url')){
	my $url = $req->param('url');
	$logger->debug("Redirecting to ", $url);
	print "window.location.replace('$url');";


    }

    $logger->info("Processing callback for site " . $req_info->{'rid'} . " and rule " . $req->param('rule'));

    $r->subprocess_env(TOTAL_SECS => Time::HiRes::time - 
	$r->subprocess_env('START_TIME'));

}

# retrieve callback info for expression
sub get_ruleset {
    my ($rid, $req_info) = @_;

    my $logger = get_logger();
    $logger->debug("[callbacks] Getting ruleset for $rid");

    return Kynetx::Repository::get_rules_from_repository($rid, $req_info);

}

sub process_callbacks {
    my ($ruleset, $rule_name, $sense, $type, $value, $req_info, $session) = @_;

    my $logger = get_logger();

    foreach my $rule (@{ $ruleset->{'rules'} }) {
	if($rule->{'name'} eq $rule_name) {
	    $logger->debug("Processing callbacks for $rule_name");
	    foreach my $cb (@{ $rule->{'callbacks'}->{$sense}} ) {
		if($cb->{'type'} eq $type &&
		   $cb->{'value'} eq $value) {
		    $logger->debug("Evaluating callback triggered persistent expr");
#		    $logger->debug(Dumper($cb->{'trigger'}));
		    eval_persistent_expr($cb->{'trigger'}, 
					 $session, 
					 $req_info,
					 empty_rule_env(), 
					 $rule_name);
		}
	    }
	    last; # only one rule with that name
	} 
    }

}




