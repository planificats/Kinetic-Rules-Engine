{"global":[],"dispatch":[{"domain":"google.com"},{"domain":"yahoo.com"},{"domain":"bing.com"}],"ruleset_name":"a60x188","rules":[{"blocktype":"every","emit":null,"name":"percolation","callbacks":null,"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":[],"pattern":"google\\.com|yahoo\\.com|bing\\.com","op":"pageview","type":"prim_event","legacy":1}},"cond":{"val":"true","type":"bool"},"actions":[{"emit":"\n        function findDevex(obj){\n         console.log( $K(obj).data(\"domain\") );\n         return $K(obj).data(\"domain\").match(/codeproject|stackoverflow|msdn|codeguru/gi);      \n        }            \n      "},{"action":{"source":null,"args":[{"val":"findDevex","type":"var"}],"name":"percolate","modifiers":null}}]}],"meta":{"author":"Alex Quintero","description":" \n     Make it so that programming websites that are likely to help appear first. \n   ","name":"Programming websites preference","logging":"on"}}
