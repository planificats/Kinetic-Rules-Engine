package Kynetx::JParser;
# file: Kynetx/JParser.pm
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
use lib qw(/web/lib/perl);

use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

our $VERSION     = 1.00;
our @ISA         = qw(Exporter);

our %EXPORT_TAGS = (all => [
qw(
    rq
) ]);
our @EXPORT_OK   =(@{ $EXPORT_TAGS{'all'} }) ;

use Log::Log4perl qw(get_logger :levels);
use Data::Dumper;
use Kynetx::Configure;
use vars qw(%VARIABLE);

our $PARSER;


#---------------------------------------------------------------------------------
# Structure to incorporate ANTLR parser's java code into PERL
#---------------------------------------------------------------------------------
my $wdir;
BEGIN {
    my $jroot = Kynetx::Configure::get_config("JAVA_ROOT") || '/web/lib/perl/parser';
    $wdir = "$jroot/perl";
    my $blogger = get_logger();
    my $libdir = $jroot.'/'."lib";
    my $pclasses = $jroot . '/' . 'output/classes';
    my @jars = ();
    opendir LIBDIR,$libdir or warn $1;
    while (my $fname = readdir(LIBDIR)) {
        next unless $fname =~ m@\.jar$@;
        push @jars,$libdir."/".$fname;
    }
    push @jars,$pclasses;
    $ENV{CLASSPATH} = join (":",@jars);
}


my $cp = $ENV{CLASSPATH};

use Inline (Java => <<'END',
    import java.util.*;
    import org.antlr.runtime.*;
    import java.io.*;
    import org.json.*;

    class Antlr_ {
        public Antlr_() {
        }

        public String ruleset(String krl) throws org.antlr.runtime.RecognitionException {
            try {
                org.antlr.runtime.ANTLRStringStream input = new org.antlr.runtime.ANTLRStringStream(krl);
                com.kynetx.RuleSetLexer lexer = new com.kynetx.RuleSetLexer(input);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                com.kynetx.RuleSetParser parser = new com.kynetx.RuleSetParser(tokens);
                parser.ruleset();
                HashMap map = new HashMap();
                JSONObject js = new JSONObject(parser.rule_json);
                //System.err.println("Java Secret Sauce: "  + js.toString() + "\n");
                if (parser.parse_errors.size() > 0) {
                    ArrayList elist = new ArrayList();
                    for (int i = 0;i< parser.parse_errors.size(); i++) {
                        elist.add(parser.parse_errors.get(i));
                    }
                    map.put("error",elist);
                    JSONObject error = new JSONObject(map);
                    return error.toString();
                }
                return js.toString();
            } catch(Exception e) {
                StringBuffer sb = new StringBuffer();
                sb.append("Parser Exception (" + e.getMessage() + "): ");
                sb.append(e.getStackTrace()[0].getClassName()).append(":");
                sb.append(e.getStackTrace()[0].getMethodName()).append(":");
                sb.append(e.getStackTrace()[0].getLineNumber()).append(":");
                return (sb.toString());
            }
        }

        public String expr(String krl) throws org.antlr.runtime.RecognitionException {
            try {
                org.antlr.runtime.ANTLRStringStream input = new org.antlr.runtime.ANTLRStringStream(krl);
                com.kynetx.RuleSetLexer lexer = new com.kynetx.RuleSetLexer(input);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                com.kynetx.RuleSetParser parser = new com.kynetx.RuleSetParser(tokens);
                com.kynetx.RuleSetParser.expr_return result = parser.expr();
                HashMap map = new HashMap();
                map.put("result",result.result);
                JSONObject js = new JSONObject(map);
                if (parser.parse_errors.size() > 0) {
                    ArrayList elist = new ArrayList();
                    for (int i = 0;i< parser.parse_errors.size(); i++) {
                        elist.add(parser.parse_errors.get(i));
                    }
                    map.put("error",elist);
                    JSONObject error = new JSONObject(map);
                    return error.toString();
                }
                return js.toString();
            } catch(Exception e) {
                StringBuffer sb = new StringBuffer();
                sb.append("Parser Exception (" + e.getMessage() + "): ");
                sb.append(e.getStackTrace()[0].getClassName()).append(":");
                sb.append(e.getStackTrace()[0].getMethodName()).append(":");
                sb.append(e.getStackTrace()[0].getLineNumber()).append(":");
                return (sb.toString());
            }
        }

        public String decl(String krl) throws org.antlr.runtime.RecognitionException {
            try {
                org.antlr.runtime.ANTLRStringStream input = new org.antlr.runtime.ANTLRStringStream(krl);
                com.kynetx.RuleSetLexer lexer = new com.kynetx.RuleSetLexer(input);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                com.kynetx.RuleSetParser parser = new com.kynetx.RuleSetParser(tokens);
                ArrayList block_array = new ArrayList();
                parser.decl(block_array);
                HashMap map = new HashMap();
                map.put("result", block_array.toArray()[0]);
                JSONObject js = new JSONObject(map);
                if (parser.parse_errors.size() > 0) {
                    ArrayList elist = new ArrayList();
                    for (int i = 0;i< parser.parse_errors.size(); i++) {
                        elist.add(parser.parse_errors.get(i));
                    }
                    map.put("error",elist);
                    JSONObject error = new JSONObject(map);
                    return error.toString();
                }
                return js.toString();
            } catch(Exception e) {
                StringBuffer sb = new StringBuffer();
                sb.append("Parser Exception (" + e.getMessage() + "): ");
                sb.append(e.getStackTrace()[0].getClassName()).append(":");
                sb.append(e.getStackTrace()[0].getMethodName()).append(":");
                sb.append(e.getStackTrace()[0].getLineNumber()).append(":");
                return (sb.toString());
            }
        }

        public String pre_block(String krl) throws org.antlr.runtime.RecognitionException {
            try {
                org.antlr.runtime.ANTLRStringStream input = new org.antlr.runtime.ANTLRStringStream(krl);
                com.kynetx.RuleSetLexer lexer = new com.kynetx.RuleSetLexer(input);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                com.kynetx.RuleSetParser parser = new com.kynetx.RuleSetParser(tokens);
                com.kynetx.RuleSetParser.pre_block_return result = parser.pre_block();
                HashMap map = new HashMap();
                map.put("result",result.result);
                JSONObject js = new JSONObject(map);
                if (parser.parse_errors.size() > 0) {
                    ArrayList elist = new ArrayList();
                    for (int i = 0;i< parser.parse_errors.size(); i++) {
                        elist.add(parser.parse_errors.get(i));
                    }
                    map.put("error",elist);
                    JSONObject error = new JSONObject(map);
                    return error.toString();
                }
                return js.toString();
            } catch(Exception e) {
                StringBuffer sb = new StringBuffer();
                sb.append("Parser Exception (" + e.getMessage() + "): ");
                sb.append(e.getStackTrace()[0].getClassName()).append(":");
                sb.append(e.getStackTrace()[0].getMethodName()).append(":");
                sb.append(e.getStackTrace()[0].getLineNumber()).append(":");
                return (sb.toString());
            }
        }

        public String global(String krl) throws org.antlr.runtime.RecognitionException {
            try {
                org.antlr.runtime.ANTLRStringStream input = new org.antlr.runtime.ANTLRStringStream(krl);
                com.kynetx.RuleSetLexer lexer = new com.kynetx.RuleSetLexer(input);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                com.kynetx.RuleSetParser parser = new com.kynetx.RuleSetParser(tokens);
                parser.global_block();
                ArrayList array = (ArrayList)parser.rule_json.get("global");
                HashMap map = new HashMap();
                map.put("result", array);
                JSONObject js = new JSONObject(map);
                if (parser.parse_errors.size() > 0) {
                    ArrayList elist = new ArrayList();
                    for (int i = 0;i< parser.parse_errors.size(); i++) {
                        elist.add(parser.parse_errors.get(i));
                    }
                    map.put("error",elist);
                    JSONObject error = new JSONObject(map);
                    return error.toString();
                }
                return js.toString();
            } catch(Exception e) {
                StringBuffer sb = new StringBuffer();
                sb.append("Parser Exception (" + e.getMessage() + "): ");
                sb.append(e.getStackTrace()[0].getClassName()).append(":");
                sb.append(e.getStackTrace()[0].getMethodName()).append(":");
                sb.append(e.getStackTrace()[0].getLineNumber()).append(":");
                return (sb.toString());
            }
        }

        public String rule(String krl) throws org.antlr.runtime.RecognitionException {
            try {
                org.antlr.runtime.ANTLRStringStream input = new org.antlr.runtime.ANTLRStringStream(krl);
                com.kynetx.RuleSetLexer lexer = new com.kynetx.RuleSetLexer(input);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                com.kynetx.RuleSetParser parser = new com.kynetx.RuleSetParser(tokens);
                parser.rule();
                ArrayList array = (ArrayList)parser.rule_json.get("rules");
                HashMap map = new HashMap();
                map.put("result", array.toArray()[0]);
                JSONObject js = new JSONObject(map);
                if (parser.parse_errors.size() > 0) {
                    ArrayList elist = new ArrayList();
                    for (int i = 0;i< parser.parse_errors.size(); i++) {
                        elist.add(parser.parse_errors.get(i));
                    }
                    map.put("error",elist);
                    JSONObject error = new JSONObject(map);
                    return error.toString();
                }
                return js.toString();
            } catch(Exception e) {
                return (exceptionMessage(e.getMessage()));
            }
        }

        public String action(String krl) throws org.antlr.runtime.RecognitionException {
            try {
                org.antlr.runtime.ANTLRStringStream input = new org.antlr.runtime.ANTLRStringStream(krl);
                com.kynetx.RuleSetLexer lexer = new com.kynetx.RuleSetLexer(input);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                com.kynetx.RuleSetParser parser = new com.kynetx.RuleSetParser(tokens);
                HashMap map = new HashMap();
                parser.action(map);
                JSONObject js = new JSONObject(map);
                if (parser.parse_errors.size() > 0) {
                    ArrayList elist = new ArrayList();
                    for (int i = 0;i< parser.parse_errors.size(); i++) {
                        elist.add(parser.parse_errors.get(i));
                    }
                    map.put("error",elist);
                    JSONObject error = new JSONObject(map);
                    return error.toString();
                }
                return js.toString();
            } catch(Exception e) {
                StringBuffer sb = new StringBuffer();
                sb.append("Parser Exception (" + e.getMessage() + "): ");
                sb.append(e.getStackTrace()[0].getClassName()).append(":");
                sb.append(e.getStackTrace()[0].getMethodName()).append(":");
                sb.append(e.getStackTrace()[0].getLineNumber()).append(":");
                return (sb.toString());
            }
        }

        public String callbacks(String krl) throws org.antlr.runtime.RecognitionException {
            try {
                org.antlr.runtime.ANTLRStringStream input = new org.antlr.runtime.ANTLRStringStream(krl);
                com.kynetx.RuleSetLexer lexer = new com.kynetx.RuleSetLexer(input);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                com.kynetx.RuleSetParser parser = new com.kynetx.RuleSetParser(tokens);
                com.kynetx.RuleSetParser.callbacks_return result = parser.callbacks();
                HashMap map = new HashMap();
                map.put("result",result.result);
                JSONObject js = new JSONObject(map);
                if (parser.parse_errors.size() > 0) {
                    ArrayList elist = new ArrayList();
                    for (int i = 0;i< parser.parse_errors.size(); i++) {
                        elist.add(parser.parse_errors.get(i));
                    }
                    map.put("error",elist);
                    JSONObject error = new JSONObject(map);
                    return error.toString();
                }
                return js.toString();
            } catch(Exception e) {
                StringBuffer sb = new StringBuffer();
                sb.append("Parser Exception (" + e.getMessage() + "): ");
                sb.append(e.getStackTrace()[0].getClassName()).append(":");
                sb.append(e.getStackTrace()[0].getMethodName()).append(":");
                sb.append(e.getStackTrace()[0].getLineNumber()).append(":");
                return (sb.toString());
            }
        }

        public String post_block(String krl) throws org.antlr.runtime.RecognitionException {
            try {
                org.antlr.runtime.ANTLRStringStream input = new org.antlr.runtime.ANTLRStringStream(krl);
                com.kynetx.RuleSetLexer lexer = new com.kynetx.RuleSetLexer(input);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                com.kynetx.RuleSetParser parser = new com.kynetx.RuleSetParser(tokens);
                com.kynetx.RuleSetParser.post_block_return result = parser.post_block();
                HashMap map = new HashMap();
                map.put("result",result.result);
                JSONObject js = new JSONObject(map);
                if (parser.parse_errors.size() > 0) {
                    ArrayList elist = new ArrayList();
                    for (int i = 0;i< parser.parse_errors.size(); i++) {
                        elist.add(parser.parse_errors.get(i));
                    }
                    map.put("error",elist);
                    JSONObject error = new JSONObject(map);
                    return error.toString();
                }
                return js.toString();
            } catch(Exception e) {
                StringBuffer sb = new StringBuffer();
                sb.append("Parser Exception (" + e.getMessage() + "): ");
                sb.append(e.getStackTrace()[0].getClassName()).append(":");
                sb.append(e.getStackTrace()[0].getMethodName()).append(":");
                sb.append(e.getStackTrace()[0].getLineNumber()).append(":");
                return (sb.toString());
            }
        }

            public String dispatch_block(String krl) throws org.antlr.runtime.RecognitionException {
            try {
                org.antlr.runtime.ANTLRStringStream input = new org.antlr.runtime.ANTLRStringStream(krl);
                com.kynetx.RuleSetLexer lexer = new com.kynetx.RuleSetLexer(input);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                com.kynetx.RuleSetParser parser = new com.kynetx.RuleSetParser(tokens);
                parser.dispatch_block();
                ArrayList array = (ArrayList)parser.rule_json.get("dispatch");
                HashMap map = new HashMap();
                map.put("result", array);
                JSONObject js = new JSONObject(map);
                if (parser.parse_errors.size() > 0) {
                    ArrayList elist = new ArrayList();
                    for (int i = 0;i< parser.parse_errors.size(); i++) {
                        elist.add(parser.parse_errors.get(i));
                    }
                    map.put("error",elist);
                    JSONObject error = new JSONObject(map);
                    return error.toString();
                }
                return js.toString();
            } catch(Exception e) {
                StringBuffer sb = new StringBuffer();
                sb.append("Parser Exception (" + e.getMessage() + "): ");
                sb.append(e.getStackTrace()[0].getClassName()).append(":");
                sb.append(e.getStackTrace()[0].getMethodName()).append(":");
                sb.append(e.getStackTrace()[0].getLineNumber()).append(":");
                return (sb.toString());
            }
        }

            public String meta_block(String krl) throws org.antlr.runtime.RecognitionException {
            try {
                org.antlr.runtime.ANTLRStringStream input = new org.antlr.runtime.ANTLRStringStream(krl);
                com.kynetx.RuleSetLexer lexer = new com.kynetx.RuleSetLexer(input);
                CommonTokenStream tokens = new CommonTokenStream(lexer);
                com.kynetx.RuleSetParser parser = new com.kynetx.RuleSetParser(tokens);
                parser.meta_block();
                HashMap result = (HashMap)parser.rule_json.get("meta");
                HashMap map = new HashMap();
                map.put("result", result);
                //JSONObject js = new JSONObject(map);
                //System.err.println("Java Secret Sauce: "  + js.toString() + "\n");
                if (parser.parse_errors.size() > 0) {
                    ArrayList elist = new ArrayList();
                    for (int i = 0;i< parser.parse_errors.size(); i++) {
                        elist.add(parser.parse_errors.get(i));
                    }
                    map.put("error",elist);
                }
                JSONObject js = new JSONObject(map);
                return js.toString();
            } catch(Exception e) {
                StringBuffer sb = new StringBuffer();
                sb.append("Parser Exception (" + e.getMessage() + "): ");
                sb.append(e.getStackTrace()[0].getClassName()).append(":");
                sb.append(e.getStackTrace()[0].getMethodName()).append(":");
                sb.append(e.getStackTrace()[0].getLineNumber()).append(":");
                return (sb.toString());
            }
        }

        public String exceptionMessage(String s) {
            StackTraceElement stackTraceElements[] =
                (new Throwable()).getStackTrace();
            StringBuffer sb = new StringBuffer();
            sb.append("{\"error\":[\"");
            sb.append("Parser Exception (" + s + "): ");
            sb.append(stackTraceElements[1].toString()).append("\"]}");
            return (sb.toString());
        }
    }
END
    CLASSPATH=>$ENV{CLASSPATH},
    SHARED_JVM => 1,
    DIRECTORY => $wdir,
    START_JVM  => 0,
    AUTOSTUDY  => 1,
    DEBUG      => 0,
    STUDY      => ['org.json.JSONObject'],
    PACKAGE => 'main',
);

use Inline::Java qw(cast);

sub env {
    my $logger = get_logger();
    foreach my $key (keys %ENV) {
        $logger->info("$key -> ", $ENV{$key});
    }
}


sub get_antlr_parser {
    return new Antlr_();
}




1;
