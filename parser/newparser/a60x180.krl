{"global":[],"dispatch":[{"domain":"www.familysearch.org"}],"ruleset_name":"a60x180","rules":[{"blocktype":"every","emit":null,"pre":[{"rhs":" \n###########################\\n###########################\\n## I found 23!!!!!\\n###########################\\n###########################        \n ","type":"here_doc","lhs":"found"}],"name":"newrule","callbacks":null,"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":[],"pattern":"http://www.familysearch.org/eng/search/frameset_search.asp.*","op":"pageview","type":"prim_event","legacy":1}},"cond":{"val":"true","type":"bool"},"actions":[{"action":{"source":null,"args":[{"val":"I have run!","type":"str"},{"val":"Check your console for example output.","type":"str"}],"name":"notify","modifiers":null}},{"emit":"\n$K(\"iframe\").contents().find(\"table:eq(0) table:eq(1) tr\").each(function() {            var number = $K(this).find(\"td:eq(1) strong\").text();            var link = $K(this).find(\"td:eq(1) a\").attr(\"href\");            var name = $K(this).find(\"td:eq(1) a\").text();            var meta = $K(this).find(\"td:eq(1) span\").text();            if( number == 23 ) {              console.log(found);            }            console.log(\"Number: \" + number + \"\\nName: \" + name + \"\\nMeta: \" + meta + \"\\nLink: \" + link);          });                        "}]}],"meta":{"author":"Mike Grace","name":"Family Search example","logging":"on"}}
