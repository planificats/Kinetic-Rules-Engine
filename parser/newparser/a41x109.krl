{"global":[{"source":"http://www.ultimate-guitar.com/search.php?view_state=advanced","cachable":{"value":"10","period":"hours"},"name":"tabs","datatype":"XML","type":"datasource"}],"dispatch":[{"domain":"last.fm"}],"ruleset_name":"a41x109","rules":[{"blocktype":"every","emit":null,"pre":[{"rhs":{"source":"datasource","args":[{"val":[{"rhs":{"val":"doors","type":"str"},"lhs":"band_name"},{"rhs":{"val":"ship","type":"str"},"lhs":"song_name"}],"type":"hashraw"}],"predicate":"tabs","type":"qualified"},"type":"expr","lhs":"tabs"}],"name":"last_fm","callbacks":null,"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":["artist","album","song"],"pattern":"^http://www.last.fm/music/(.*?)/(.*?)/(.*?)$","op":"pageview","type":"prim_event","legacy":1}},"cond":{"val":"true","type":"bool"},"actions":[{"action":{"source":null,"args":[{"val":"tabs","type":"var"}],"name":"notify","modifiers":null}}]}],"meta":{"author":"","description":"\n      \n    ","name":"Guitar Lover","logging":"off"}}
