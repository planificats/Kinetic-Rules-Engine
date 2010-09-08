{"global":[{"source":"http://services.odata.org/Northwind/Northwind.svc","name":"northwind_service","type":"datasource","datatype":"XML","cachable":0}],"global_start_line":18,"dispatch":[{"domain":"linkedin.com","ruleset_id":null}],"dispatch_start_col":3,"meta_start_line":2,"rules":[{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"prepend","args":[{"val":"#extra","type":"str"},{"val":"northwindmodule","type":"var"}],"modifiers":null,"vars":null},"label":null},{"action":{"source":null,"name":"watch","args":[{"val":"#northwindextract","type":"str"},{"val":"submit","type":"str"}],"modifiers":null,"vars":null},"label":null},{"label":null,"emit":"region = $K(\"a[name=location]\").text();\n      $K('#northwindextract input[name=territory]').val(region);\n      $K('#northwindextract').submit();\n    "}],"post":null,"pre":[{"rhs":"<div class=\"general-box panel\">\n      <div class=\"modules\">\n      <div class=\"module open\" id=\"northwind-module\">\n        <div class=\"header\">\n          <h3><strong>NorthWind</strong></h3> \n        </div>\n        <div id=\"northwind-widget\" class=\"content\">\n          <form id=\"northwindextract\" style=\"display:none;\">\n            <input type=\"text\" name=\"territory\" value=\"\"/>\n          </form>\n          <i class=\"loadingmessage\">Loading...</i>\n        </div>\n      </div>\n      </div>\n      </div>\n      ","lhs":"northwindmodule","type":"here_doc"}],"name":"extract_region","start_col":3,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"domain":null,"pattern":"www.linkedin.com/profile","type":"prim_event","vars":[],"op":"pageview"},"foreach":[]},"start_line":22},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"replace_html","args":[{"val":"#northwind-widget .loadingmessage","type":"str"},{"val":"","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":{"alt":null,"type":"fired","cons":[{"test":null,"domain":"ent","name":"Territory","action":"clear","type":"persistent"},{"test":null,"domain":"ent","name":"Territory","action":"mark","type":"persistent","with":{"val":"TerritoryID","type":"var"}},{"test":null,"domain":"ent","name":"NumResults","action":"clear","type":"persistent"}]},"pre":[{"rhs":{"source":"page","predicate":"param","args":[{"val":"territory","type":"str"}],"type":"qualified"},"lhs":"a","type":"expr"},{"rhs":{"obj":{"val":"a","type":"var"},"args":[{"val":"/,.*/","type":"regexp"},{"val":"","type":"str"}],"name":"replace","type":"operator"},"lhs":"b","type":"expr"},{"rhs":{"obj":{"val":"b","type":"var"},"args":[{"val":"/Greater /","type":"regexp"},{"val":"","type":"str"}],"name":"replace","type":"operator"},"lhs":"c","type":"expr"},{"rhs":{"obj":{"val":"c","type":"var"},"args":[{"val":"/ Area/","type":"regexp"},{"val":"","type":"str"}],"name":"replace","type":"operator"},"lhs":"d","type":"expr"},{"rhs":{"val":"d","type":"var"},"lhs":"territory","type":"expr"},{"rhs":{"source":"datasource","predicate":"northwind_service","args":[{"val":"/Territories?$select=TerritoryID&$top=1&$filter=TerritoryDescription eq '#{territory}'","type":"str"}],"type":"qualified"},"lhs":"tdata","type":"expr"},{"rhs":{"obj":{"val":"tdata","type":"var"},"args":[{"val":"$..d$TerritoryID.$t","type":"str"}],"name":"pick","type":"operator"},"lhs":"TerritoryID","type":"expr"}],"name":"process_region","start_col":3,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"on":null,"domain":"web","type":"prim_event","vars":null,"op":"submit","element":"#northwindextract"},"foreach":[]},"start_line":56},{"cond":{"val":"true","type":"bool"},"blocktype":"every","actions":[{"action":{"source":null,"name":"append","args":[{"val":"#northwind-widget","type":"str"},{"val":"employeeline","type":"var"}],"modifiers":null,"vars":null},"label":null}],"post":{"alt":null,"type":"fired","cons":[{"test":null,"value":{"val":1,"type":"num"},"name":"NumResults","domain":"ent","from":{"val":1,"type":"num"},"action":"iterator","type":"persistent","op":"+="}]},"pre":[{"rhs":{"obj":{"val":"entry","type":"var"},"args":[{"val":"$..d$FirstName.$t","type":"str"}],"name":"pick","type":"operator"},"lhs":"firstname","type":"expr"},{"rhs":{"obj":{"val":"entry","type":"var"},"args":[{"val":"$..d$LastName.$t","type":"str"}],"name":"pick","type":"operator"},"lhs":"lastname","type":"expr"},{"rhs":{"obj":{"val":"entry","type":"var"},"args":[{"val":"$..d$HomePhone.$t","type":"str"}],"name":"pick","type":"operator"},"lhs":"homephone","type":"expr"},{"rhs":{"obj":{"val":"entry","type":"var"},"args":[{"val":"$..d$TitleOfCourtesy.$t","type":"str"}],"name":"pick","type":"operator"},"lhs":"title","type":"expr"},{"rhs":{"obj":{"val":"entry","type":"var"},"args":[{"val":"$..d$Title.$t","type":"str"}],"name":"pick","type":"operator"},"lhs":"jobtitle","type":"expr"},{"rhs":{"obj":{"val":"entry","type":"var"},"args":[{"val":"$..d$City.$t","type":"str"}],"name":"pick","type":"operator"},"lhs":"city","type":"expr"},{"rhs":{"obj":{"val":"entry","type":"var"},"args":[{"val":"$..d$Country.$t","type":"str"}],"name":"pick","type":"operator"},"lhs":"country","type":"expr"},{"rhs":{"obj":{"val":"entry","type":"var"},"args":[{"val":"$..d$Notes.$t","type":"str"}],"name":"pick","type":"operator"},"lhs":"notes","type":"expr"},{"rhs":"<h4 class=\"tags\">#{jobtitle}</h4>\n        <p>\n        #{title} #{firstname} #{lastname}<br/>\n        #{homephone}<br/>\n        #{city}, #{country}\n        </p><br/>\n        <h4 class=\"tags\">Notes</h4>\n        <p>#{notes}</p>\n      ","lhs":"employeeline","type":"here_doc"}],"name":"list_employees","start_col":3,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"on":null,"domain":"web","type":"prim_event","vars":null,"op":"submit","element":"#northwindextract"},"foreach":[{"expr":{"obj":{"source":"datasource","predicate":"northwind_service","args":[{"val":"/Territories('#{current ent:Territory}')/Employees?$select=EmployeeID,LastName,FirstName,Title,TitleOfCourtesy,BirthDate,HireDate,Address,City,Region,PostalCode,Country,HomePhone,Extension,Notes","type":"str"}],"type":"qualified"},"args":[{"val":"$..entry","type":"str"}],"name":"pick","type":"operator"},"var":["entry"]}]},"start_line":79},{"cond":{"args":[{"domain":"ent","name":"NumResults","type":"persistent"},{"val":0,"type":"num"}],"type":"ineq","op":"=="},"blocktype":"every","actions":[{"action":{"source":null,"name":"append","args":[{"val":"#northwind-widget","type":"str"},{"val":"<i>No Representatives Found</a>","type":"str"}],"modifiers":null,"vars":null},"label":null}],"post":null,"pre":null,"name":"noresults","start_col":3,"emit":null,"state":"active","callbacks":null,"pagetype":{"event_expr":{"on":null,"domain":"web","type":"prim_event","vars":null,"op":"submit","element":"#northwindextract"},"foreach":[]},"start_line":111}],"meta_start_col":3,"meta":{"logging":"on","name":"OData Demo","meta_start_line":2,"author":"Sam Curren","description":"Northwind LinkedIn mashup\n    ","meta_start_col":3},"dispatch_start_line":13,"global_start_col":3,"ruleset_name":"a8x49"}