{"global":[],"dispatch":[{"domain":"google.com"}],"ruleset_name":"a38x8","rules":[{"blocktype":"every","emit":null,"pre":[{"rhs":" \n<p style=\"font-size:.6em;\">Free WiFi brought to you by:<\/p><a href=\"http://www.beansandbrews.com/\"><img style=\"border:0;\" alt=\"Beans and Brew Free WiFi\" src=\"http://img198.imageshack.us/img198/2485/75525359.jpg\"/><\/a> \n ","type":"here_doc","lhs":"test"}],"name":"free_wifi","callbacks":null,"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":[],"pattern":"google.com","op":"pageview","type":"prim_event","legacy":1}},"cond":{"val":"true","type":"bool"},"actions":[{"action":{"source":null,"args":[{"val":"#body>center","type":"str"},{"val":"test","type":"var"}],"name":"append","modifiers":null}}]}],"meta":{"name":"Google Free WiFi","logging":"off"}}
