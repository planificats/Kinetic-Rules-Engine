{"global":[{"emit":"\nif (!window.console || !console.firebug)    {        var names = [\"log\", \"debug\", \"info\", \"warn\", \"error\", \"assert\", \"dir\", \"dirxml\",        \"group\", \"groupEnd\", \"time\", \"timeEnd\", \"count\", \"trace\", \"profile\", \"profileEnd\"];            window.console = {};        for (var i = 0; i < names.length; ++i)            window.console[names[i]] = function() {}    }        alert(window.console);                    "}],"dispatch":[],"ruleset_name":"a8x8","rules":[{"blocktype":"every","emit":null,"name":"allthingsgoogle","callbacks":null,"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":[],"pattern":"www.google.com","op":"pageview","type":"prim_event","legacy":1}},"cond":{"val":"true","type":"bool"},"actions":[{"action":{"source":null,"args":[],"name":"noop","modifiers":null}}]}],"meta":{"description":"\ntesting the console problem between firebug and google reader \n"}}
