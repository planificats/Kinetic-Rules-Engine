package Kynetx::Cloud;

# file: Kynetx/Sky.pm
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

#use warnings;

use Log::Log4perl qw(get_logger :levels);
use Data::Dumper;
$Data::Dumper::Indent = 1;

use JSON::XS;
use Apache2::Const qw( :http );

use Kynetx::Version;
use Kynetx::Rules;
use Kynetx::Response;
use Kynetx::Dispatch;
use Kynetx::Directives;
use Kynetx::Configure;
use Kynetx::Environments;
use Kynetx::Modules;
use Kynetx::Session;
use Kynetx::Expressions;
use Kynetx::Memcached;

use Kynetx::Metrics::Datapoint;

use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

# put exported names inside the "qw"
our %EXPORT_TAGS = (
	all => [
		qw(
unalias
		  )
	]
);
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

sub handler {
	my $r = shift;

	# configure logging for production, development, etc.
	Kynetx::Util::config_logging($r);

	my $logger = get_logger();
  my $metric = new Kynetx::Metrics::Datapoint();
	$metric->start_timer();
	$metric->series("sky-cloud");
	$metric->path($r->path_info);
	$metric->mem_stats();
	my $req = Apache2::Request->new($r);
	my @params = $req->param;
	for my $parm (@params) {
	  my $val = $req->param($parm);
	  $metric->push($parm,$val);
	}
	if (scalar @params > 0){
	  $metric->add_tag(join(",",@params));
	}	
	
	eval {
		 $logger->remove_appender('ConsoleLogger');
	};
	

	$logger->trace(
"\n\n------------------------------ begin ID evaluation with CLOUDID API---------------------"
	);
	$logger->trace("Initializing memcached");
	Kynetx::Memcached->init();

	my ($rids);
	$r->subprocess_env( START_TIME => Time::HiRes::time );

	# path looks like: /sky/{cloud|version|flush}/<module>/<function>?_eci=...&arg0=...&arg1=...&...&argn=...

	my @path_components = split( /\//, $r->path_info );

	my $req_info = Kynetx::Request::build_request_env($r, $path_components[4], $rids, undef, int(rand(999999999999)) ); # EID for Cloud is random since API doesn't provide one

        # store the EID so we have it in the PerlLogHandler
        $r->pnotes(EID => $req_info->{"eid"});
	
	
	my $session = _cloud_session($r,$req_info);
  return Apache2::Const::HTTP_BAD_REQUEST unless ($session);
  

	if ( Kynetx::Configure::get_config('RUN_MODE') eq 'development' ) {

		# WARNING: THIS CHANGES THE USER'S IP NUMBER FOR TESTING!!
		my $test_ip = Kynetx::Configure::get_config('TEST_IP');
		$r->connection->remote_ip($test_ip);
		$logger->debug( "In development mode using IP address ",
			$r->connection->remote_ip() );
	}


	# store these for later logging
	if ($path_components[2] eq 'version' ) {
		$logger->trace("returning version info for Sky cloud API");
		Kynetx::Version::show_build_num($r);
		exit();
	}
	elsif ( $path_components[2] eq 'flush' ) {
	  # nothing to flush for now
	}
	else { # doing cloud 

	  # store these for later logging
	  Log::Log4perl::MDC->put( 'site',  $path_components[2]);
	  Log::Log4perl::MDC->put( 'rule', $path_components[3] );    # function.
	  Log::Log4perl::MDC->put( 'eid', $req_info->{"eid"} );    # no eid


	  


	  my ($module_alias, $version) = split(/\./,$path_components[2]);
	  my $rid = unalias($module_alias);

	  $version ||= 'prod';
	  $req_info->{'module_name'} = $rid;
	  $req_info->{'rid'} = Kynetx::Rids::mk_rid_info( $req_info, $rid, {"version" => $version} );
	  $req_info->{'module_version'} = $version;
	  $req_info->{'module_alias'} = $module_alias;
	  $req_info->{'function_name'} = $path_components[3];
	  
	  $metric->add_tag($rid);

	  Kynetx::Request::log_request_env( $logger, $req_info );

	  my $dd = Kynetx::Response->create_directive_doc( $req_info->{'eid'} );

	  my $result = eval_ruleset_function($req_info, $session, $dd);

	  my $js = "";
	  Kynetx::Response::respond( $r, $req_info, $session, $js, $dd, "Cloud API" );

	}
	$metric->token($req_info->{'id_token'});
	$metric->stop_and_store();
	$logger->info("Processed Cloud API for ". $r->path_info);
	


	return Apache2::Const::OK;
}


sub eval_ruleset_function {
  my($req_info, $session, $dd) = @_;
  
  my $logger = get_logger();

  # TODO: check that this is installed

  # this can be a big list...
  # my $unfiltered_rid_list =
  #   Kynetx::Dispatch::calculate_rid_list( $req_info, $session );

  # my $ken = Kynetx::Persistence::get_ken( $session, "", "web" );   # empty rid
  # my $rid_list = Kynetx::Dispatch::get_ridlist( $req_info, $req_info->{'id_token'}, $ken );
  my $rid_list = Kynetx::Dispatch::get_ridlist( $req_info, $req_info->{'id_token'});
  my $rid_list_hash = {map { $_->{'rid'} => 1 } @{ $rid_list }};

#  $logger->trace("Ridlist: ", sub { Dumper $rid_list_hash } );


  my $ruleset =
      Kynetx::Rules::get_rule_set( $req_info, 1, 
				   $req_info->{'module_name'}, 
				   $req_info->{'module_version'}
				 );



  $logger->trace("Sharing is: ", sub { Dumper $ruleset->{'meta'}->{'sharing'} } );

  my $result = "";


  if ( !defined $ruleset->{'meta'}->{'sharing'} 
    || $ruleset->{'meta'}->{'sharing'} eq "off" 
     ) {

    $logger->info("Sharing not on for module $req_info->{'module_alias'}");
    $result = {"error" => 100,
	       "error_str" => "Sharing not on for module $req_info->{'module_alias'}"
	      };

  } 
  elsif (! $req_info->{'id_token'}
	) {
    $logger->debug("Request info: ", sub {Dumper($req_info)});
    $logger->error("Bad ECI; aborting");
    $result = {"error" => 103,
	       "error_str" => "No ECI defined"
	      };

  }
  elsif (! ( defined $rid_list_hash->{$req_info->{'module_name'}}
	  || Kynetx::Configure::get_config('ALLOW_ALL_RULESETS')
           )
	) {
    $logger->info("$req_info->{'module_name'} is not installed in pico");
    $result = {"error" => 102,
	       "error_str" => "Module $req_info->{'module_alias'} is not installed in pico"
	      };

  }
  else {
     
    $logger->info("Executing $req_info->{'module_alias'}.$req_info->{'module_version'}/$req_info->{'function_name'}");

    my $rule_env = Kynetx::Rules::mk_initial_env();

    my $env_stash = {};
    my $modifiers= [];

    $rule_env = Kynetx::Rules::eval_use_module( $req_info, $rule_env, $session, 
						$req_info->{'module_name'},
						$req_info->{'module_alias'}, $modifiers, 
						$req_info->{'module_version'}, $env_stash );


    # $logger->trace("Env: ", sub{Dumper $rule_env});
    
    my $rule_name = "empty_rule";

    my $closure = Kynetx::Modules::lookup_module_env($req_info->{'module_alias'}, 
						     $req_info->{'function_name'}, 
						     $rule_env,
						     $req_info
						    );

    #$logger->trace("Closure: ", sub{Dumper $closure});

    if ( defined $closure 
      && $closure->{'type'} eq 'closure'
       ) {

  
      my $attrs  = Kynetx::Request::get_attrs($req_info) || {};
      delete $attrs->{'attr_names'};

      my $expr = {'function_expr' => $closure,
		  'args' => $attrs,
		  'name' => $req_info->{'function_name'}
		 };

      # $logger->trace("Expr: ", sub{Dumper $expr});
      $result = Kynetx::Expressions::den_to_exp(
	  	  Kynetx::Expressions::eval_application($expr, $rule_env, $rule_name,
							$req_info, $session));

    } else {

      $logger->info("Function $req_info->{'function_name'} does not exist");

      $result = {"error" => 101,
		 "error_str" => "Function $req_info->{'function_name'} does not exist"
		};
       
    }


  }



 # $logger->debug("Result: ", sub{Dumper $result});
 
  my $json = JSON::XS->new->allow_nonref;
  my $content_type = "application/json";

  if (ref $result eq "HASH" || ref $result eq "ARRAY") {

      eval {
	  $result = $json->encode( $result );
      };
      if ($@) {
	  $result = $json->encode({"error" => 104,
				   "error_str" => "Error encoding JSON: $@"
				  });
      }
  } elsif ( $result =~ m#^\s*<html>.+</html>\s*#is  # infer content type
	  ) {
      $content_type = "text/html";
  }
  my $opts = {'is_raw' => 1,
	      'content' => $result ,
	     };
  $req_info->{'send_raw'} = 1;

  Kynetx::Directives::send_directive($req_info, $dd, $content_type, $opts );

  return $result;

}


sub unalias {
  my($alias) = @_;
  my $module_aliases = {"pds" => "a169x676",
			"cloudos" => "a169x625",
			"notify" => "a16x161",
			"squaretag" => "a41x178",
			"mythings" => "a169x667",
                        "pdsx" => "a369x202",
			"gtour" => "b501810x1",
		       };
  my $logger = get_logger();

  my $rid;
  if ($module_aliases->{$alias}) {
    $rid = $module_aliases->{$alias};
  } else {
    $rid = $alias;
  }
  $logger->trace("[unalias] : $alias -> $rid");
  return $rid;
}

# repeat some code from Kynetx::Request for
# cloud specific debugging
sub _cloud_session {
  my ($r,$req_info) = @_;
  my $logger = get_logger();
  my $session = undef;
  my $id_token = $req_info->{'id_token'};
  unless ($id_token) {
    my $req = Apache2::Request->new($r);
    $logger->debug("Request type: ", $r->method_number);
    $logger->debug("URI: ",$r->unparsed_uri());
    $logger->debug("Path: ",$r->path_info());
    $logger->debug("Args: ", sub {Dumper($r->args)});
    $logger->debug("Header: ",$r->headers_in->{'Kobj-Session'});
    $logger->debug("Cookie: ",$r->headers_in->{'Cookie'});    
  }
  my $valid = Kynetx::Persistence::KToken::is_valid_token($id_token);
  if ($valid) {
    my $session_id = $valid->{"endpoint_id"};
    $session = { "_session_id" => $session_id};
  } else {
    $logger->debug("SkyCloud token ($id_token) is invalid")
  }
  return $session;
}


1;
