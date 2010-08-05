{
   "dispatch": [{"domain": "www.google.com"}],
   "global": [
      {
         "cachable": {
            "period": "hours",
            "value": "3"
         },
         "datatype": "JSON",
         "name": "totalmiles",
         "source": "http://spreadsheets.google.com/pub?key=rxzHBMZyj1S-HVLy9lFEU7A&single=true&gid=1&range=B1&output=txt",
         "type": "dataset"
      },
      {
         "cachable": {
            "period": "hours",
            "value": "3"
         },
         "datatype": "JSON",
         "name": "ridestats",
         "source": "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20csv%20where%20url%3D'http%3A%2F%2Fspreadsheets.google.com%2Fpub%3Fkey%3DrxzHBMZyj1S-HVLy9lFEU7A%26single%3Dtrue%26gid%3D1%26range%3DA12%253AC16%26output%3Dcsv'%20and%20columns%3D'period%2Cmiles%2Chours'%20and%20period%20!%3D%20%22%22&format=json&callback=",
         "type": "dataset"
      }
   ],
   "meta": {
      "author": "Sam Curren",
      "description": "\nMaking public sam's 1000 mile progress     \n",
      "logging": "on",
      "name": "SamRides1000"
   },
   "rules": [
      {
         "actions": [{"action": {
            "args": [
               {
                  "type": "str",
                  "val": "#logo h2"
               },
               {
                  "type": "var",
                  "val": "milesmessage"
               }
            ],
            "modifiers": null,
            "name": "replace_html",
            "source": null
         }}],
         "blocktype": "every",
         "callbacks": null,
         "cond": {
            "type": "bool",
            "val": "true"
         },
         "emit": null,
         "foreach": [],
         "name": "samwebsite",
         "pagetype": {"event_expr": {
            "legacy": 1,
            "op": "pageview",
            "pattern": "http://sam.curren.ws/",
            "type": "prim_event",
            "vars": []
         }},
         "pre": [
            {
               "lhs": "daymiles",
               "rhs": {
                  "args": [{
                     "type": "str",
                     "val": "$..results.row[0].miles"
                  }],
                  "name": "ick",
                  "obj": {
                     "type": "var",
                     "val": "ridestats"
                  },
                  "type": "operator"
               },
               "type": "expr"
            },
            {
               "lhs": "weekmiles",
               "rhs": {
                  "args": [{
                     "type": "str",
                     "val": "$..results.row[1].miles"
                  }],
                  "name": "ick",
                  "obj": {
                     "type": "var",
                     "val": "ridestats"
                  },
                  "type": "operator"
               },
               "type": "expr"
            },
            {
               "lhs": "monthmiles",
               "rhs": {
                  "args": [{
                     "type": "str",
                     "val": "$..results.row[2].miles"
                  }],
                  "name": "ick",
                  "obj": {
                     "type": "var",
                     "val": "ridestats"
                  },
                  "type": "operator"
               },
               "type": "expr"
            },
            {
               "lhs": "totalmiles",
               "rhs": {
                  "args": [{
                     "type": "str",
                     "val": "$..results.row[3].miles"
                  }],
                  "name": "ick",
                  "obj": {
                     "type": "var",
                     "val": "ridestats"
                  },
                  "type": "operator"
               },
               "type": "expr"
            },
            {
               "lhs": "milesmessage",
               "rhs": " \n<h2>Sam is on a bike. Progress:   #{(daymiles > 0 ? daymiles + \" Today, \" : \"\")}   #{(weekmiles > 0 && weekmiles != daymiles ? weekmiles + \" This Week, \" : \"\")}   #{(monthmiles > 0 ? monthmiles + \" This Month, \" : \"\")}   #{totalmiles} Total.<\/h2>  \n ",
               "type": "here_doc"
            }
         ],
         "state": "active"
      },
      {
         "actions": [{"action": {
            "args": [
               {
                  "type": "str",
                  "val": "div.fade"
               },
               {
                  "type": "var",
                  "val": "milesmessage"
               }
            ],
            "modifiers": null,
            "name": "append",
            "source": null
         }}],
         "blocktype": "every",
         "callbacks": null,
         "cond": {
            "type": "bool",
            "val": "true"
         },
         "emit": null,
         "foreach": [],
         "name": "googlefrontpage",
         "pagetype": {"event_expr": {
            "legacy": 1,
            "op": "pageview",
            "pattern": "http://www.google.com/",
            "type": "prim_event",
            "vars": []
         }},
         "pre": [
            {
               "lhs": "daymiles",
               "rhs": {
                  "args": [{
                     "type": "str",
                     "val": "$..results.row[0].miles"
                  }],
                  "name": "ick",
                  "obj": {
                     "type": "var",
                     "val": "ridestats"
                  },
                  "type": "operator"
               },
               "type": "expr"
            },
            {
               "lhs": "weekmiles",
               "rhs": {
                  "args": [{
                     "type": "str",
                     "val": "$..results.row[1].miles"
                  }],
                  "name": "ick",
                  "obj": {
                     "type": "var",
                     "val": "ridestats"
                  },
                  "type": "operator"
               },
               "type": "expr"
            },
            {
               "lhs": "monthmiles",
               "rhs": {
                  "args": [{
                     "type": "str",
                     "val": "$..results.row[2].miles"
                  }],
                  "name": "ick",
                  "obj": {
                     "type": "var",
                     "val": "ridestats"
                  },
                  "type": "operator"
               },
               "type": "expr"
            },
            {
               "lhs": "totalmiles",
               "rhs": {
                  "args": [{
                     "type": "str",
                     "val": "$..results.row[3].miles"
                  }],
                  "name": "ick",
                  "obj": {
                     "type": "var",
                     "val": "ridestats"
                  },
                  "type": "operator"
               },
               "type": "expr"
            },
            {
               "lhs": "milesmessage",
               "rhs": " \n<h2>Sam is riding 1,000 miles.<\/h2><p> Progress:   #{(daymiles > 0 ? daymiles + \" Today, \" : \"\")}   #{(weekmiles > 0 && weekmiles != daymiles ? weekmiles + \" This Week, \" : \"\")}   #{(monthmiles > 0 ? monthmiles + \" This Month, \" : \"\")}   #{totalmiles} Total.<\/p>  \n ",
               "type": "here_doc"
            }
         ],
         "state": "active"
      }
   ],
   "ruleset_name": "a8x11"
}