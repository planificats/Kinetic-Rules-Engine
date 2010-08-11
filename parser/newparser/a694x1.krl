{"global":[],"dispatch":[{"domain":"refresheverything.com"}],"ruleset_name":"a694x1","rules":[{"blocktype":"every","emit":"\nif ($K(\"#user-login\")) {      $K(\"input#emailAddress\").val(frmEmail);      $K(\"input#password\").val(frmPwd);      $K(\"input#httpReferer\").val(\"\");      $K(\"#user-login\").find(\"input[type='submit']\").trigger(\"click\");    }                ","pre":[{"rhs":{"val":"email","type":"var"},"type":"expr","lhs":"frmEmail"},{"rhs":{"val":"password","type":"var"},"type":"expr","lhs":"frmPwd"}],"name":"form_login","callbacks":null,"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":["email","password"],"pattern":"/index/login.*(?:&email|\\?email)=([^&]*).*(?:&password|\\?password)=([^&]*)","op":"pageview","type":"prim_event","legacy":1}},"cond":{"val":"true","type":"bool"},"actions":[{"action":{"source":null,"args":[{"val":"Password","type":"str"},{"val":"frmPwd","type":"var"}],"name":"notify","modifiers":null}}]},{"blocktype":"every","emit":"\nif ($K(\"#profile-pcna\").text()==\"Your Profile\") {          window.location=\"/dashboard\";    };            ","name":"go_dashboard","callbacks":null,"state":"inactive","pagetype":{"foreach":[],"event_expr":{"vars":[],"pattern":"/index/login.*","op":"pageview","type":"prim_event","legacy":1}},"cond":{"val":"true","type":"bool"},"actions":[{"action":{"source":null,"args":[{"val":"Going to","type":"str"},{"val":"Dashboard","type":"str"}],"name":"notify","modifiers":null}}]},{"blocktype":"every","emit":"\nif ($K(\"#register\")) {      $K(\"input#firstName\").val(frmFname );      $K(\"input#lastName\").val(frmLname );      $K(\"input#emailAddress\").val(frmEmail);      $K(\"input#password\").val(frmPwd);      $K(\"input#passwordCheck\").val(frmPwd);      $K(\"#dobMonth\").val(frmDOBMonth);      $K(\"#dobDay\").append('<option value=\"'+ frmDOBDay + '\" selected=\"selected\">' + frmDOBDay + '<\/option>');      $K(\"#dobYear\").val(frmDOBYear);      $K(\"input#httpReferer\").val(\"\");      $K(\"input#captchaText\").focus();    }                ","pre":[{"rhs":{"val":"fname","type":"var"},"type":"expr","lhs":"frmFname"},{"rhs":{"val":"lname","type":"var"},"type":"expr","lhs":"frmLname"},{"rhs":{"val":"email","type":"var"},"type":"expr","lhs":"frmEmail"},{"rhs":{"val":"password","type":"var"},"type":"expr","lhs":"frmPwd"},{"rhs":{"val":"dobMonth","type":"var"},"type":"expr","lhs":"frmDOBMonth"},{"rhs":{"val":"dobDay","type":"var"},"type":"expr","lhs":"frmDOBDay"},{"rhs":{"val":"dobYear","type":"var"},"type":"expr","lhs":"frmDOBYear"}],"name":"light_registration","callbacks":null,"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":["fname","lname","email","password","dobMonth","dobDay","dobYear"],"pattern":"/light-registration.*(?:&fname|\\?fname)=([^&]*).*(?:&lname|\\?lname)=([^&]*).*(?:&email|\\?email)=([^&]*).*(?:&password|\\?password)=([^&]*).*(?:&dobMonth|\\?dobMonth)=([^&]*).*(?:&dobDay|\\?dobDay)=([^&]*).*(?:&dobYear|\\?dobYear)=([^&]*)","op":"pageview","type":"prim_event","legacy":1}},"cond":{"val":"true","type":"bool"},"actions":[{"action":{"source":null,"args":[{"val":"Password","type":"str"},{"val":"frmPwd","type":"var"}],"name":"notify","modifiers":null}}]},{"blocktype":"every","emit":null,"name":"dashboard","callbacks":null,"state":"inactive","pagetype":{"foreach":[],"event_expr":{"vars":[],"pattern":"","op":"pageview","type":"prim_event","legacy":1}},"cond":{"val":"true","type":"bool"},"actions":[{"action":{"source":null,"args":[],"name":"noop","modifiers":null}}]}],"meta":{"description":"\nPepsi Refresh Login     \n","name":"pepsi light","logging":"on"}}
