{"global":[],"dispatch":[{"domain":"facebook.com"}],"ruleset_name":"a41x47","rules":[{"blocktype":"every","emit":"\nif($K(\"#home_left_column\").length) {  \t$K(\"#home_left_column\").before('<iframe frameborder=\"0\" width=\"740px\" scrolling=\"no\" src=\"http://www.caandb.com/kynetx/googleads.html\">Please update your browser!<\/iframe>');  } else if($K(\"#tab_content\").length) {  \t$K(\"#tab_content\").before('<iframe frameborder=\"0\" width=\"740px\" scrolling=\"no\" src=\"http://www.caandb.com/kynetx/googleads.html\">Please update your browser!<\/iframe>');  }            ","name":"facebook","callbacks":null,"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":[],"pattern":"www.facebook.com","op":"pageview","type":"prim_event","legacy":1}},"cond":{"val":"true","type":"bool"},"actions":[{"action":{"source":null,"args":[],"name":"noop","modifiers":null}}]}],"meta":{"description":"\nAdds ads to Facebook   \n","name":"Facebook Ads","logging":"off"}}
