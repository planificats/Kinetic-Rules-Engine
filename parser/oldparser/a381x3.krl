{"global":[],"global_start_line":null,"dispatch":[{"domain":"google.com","ruleset_id":null}],"dispatch_start_col":5,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"notify","args":[{"val":"Stock Information","type":"str"},{"args":[{"val":"msg","type":"var"},{"val":"msg2","type":"var"}],"type":"prim","op":"+"}],"modifiers":null},"label":null}],"post":null,"pre":[{"rhs":{"val":"goog","type":"str"},"lhs":"ticker","type":"expr"},{"rhs":{"source":"stocks","predicate":"last","args":[{"val":"ticker","type":"var"}],"type":"qualified"},"lhs":"last","type":"expr"},{"rhs":{"source":"stocks","predicate":"open","args":[{"val":"ticker","type":"var"}],"type":"qualified"},"lhs":"open","type":"expr"},{"rhs":{"source":"stocks","predicate":"high","args":[{"val":"ticker","type":"var"}],"type":"qualified"},"lhs":"high","type":"expr"},{"rhs":{"source":"stocks","predicate":"low","args":[{"val":"ticker","type":"var"}],"type":"qualified"},"lhs":"low","type":"expr"},{"rhs":{"source":"stocks","predicate":"volume","args":[{"val":"ticker","type":"var"}],"type":"qualified"},"lhs":"volume","type":"expr"},{"rhs":{"source":"stocks","predicate":"previous_close","args":[{"val":"ticker","type":"var"}],"type":"qualified"},"lhs":"previous_close","type":"expr"},{"rhs":{"source":"stocks","predicate":"name","args":[{"val":"ticker","type":"var"}],"type":"qualified"},"lhs":"name","type":"expr"},{"rhs":{"source":"stocks","predicate":"last","args":[{"val":"^DJI","type":"str"}],"type":"qualified"},"lhs":"current_price","type":"expr"},{"rhs":{"source":"stocks","predicate":"change","args":[{"val":"^DJI","type":"str"}],"type":"qualified"},"lhs":"change","type":"expr"},{"rhs":{"source":"stocks","predicate":"name","args":[{"val":"^DJI","type":"str"}],"type":"qualified"},"lhs":"name","type":"expr"},{"rhs":"Name: #{name}<br/>          Change: #{change}<br/>  \tCurrent_price: #{current_price}<br/>          <style>            .KOBJ_message { font-size: 16px; }            .KOBJ_header { font-size: 20px !important; }          </style>            \n ","lhs":"msg","type":"here_doc"},{"rhs":"<br/>  \t<br/>          Ticker: #{ticker}<br/>          Last: #{last}<br/>          Open: #{open}<br/>          High: #{high}<br/>          Low: #{low}<br/>          Volume: #{volume}<br/>          Previous Close: #{previous_close}<br/>          Name: #{name}<br/>          <style>            .KOBJ_message { font-size: 18px; }            .KOBJ_header { font-size: 24px !important; }          </style>            \n ","lhs":"msg2","type":"here_doc"}],"name":"newrule","start_col":5,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"pattern":".*","legacy":1,"type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":13}],"meta_start_col":5,"meta":{"logging":"on","name":"StockTracker","meta_start_line":2,"author":"Nathan Whiting","description":"Tracks The Stocks Based on the Web Site     \n","meta_start_col":5},"dispatch_start_line":10,"global_start_col":null,"ruleset_name":"a381x3"}