{
   "dispatch": [],
   "global": [{
      "content": "\n\t\t\t.jqueryDetector {\n\t\t\t\tbackground-color: red;\n\t\t\t\tborder: 2px solid red;\n\t\t\t}\n\n\t\t\t.jqueryOldDetector {\n\t\t\t\tbackground-color: red;\n\t\t\t\tborder: 2px solid red;\n\t\t\t}\n\n\t\t\t.visaHovered {\n\t\t\t\tbackground-color: blue;\n\t\t\t\tborder: 2px solid red;\n\t\t\t}\n\n\t\t\t#kGrowl {\n\t\t\t\tposition: absolute !important;\n\t\t\t}\n\n\t\t\t.selectorDivSelected {\n\t\t\t\tbackground-color: green;\n\t\t\t}\n\t\t",
      "type": "css"
   }],
   "meta": {
      "logging": "off",
      "name": "Visa Selector Detector"
   },
   "rules": [{
      "actions": [{"action": {
         "args": [
            {
               "type": "str",
               "val": "selectorDetector"
            },
            {
               "type": "var",
               "val": "message"
            }
         ],
         "modifiers": [
            {
               "name": "sticky",
               "value": {
                  "type": "bool",
                  "val": "true"
               }
            },
            {
               "name": "width",
               "value": {
                  "type": "str",
                  "val": "300px"
               }
            },
            {
               "name": "pos",
               "value": {
                  "type": "str",
                  "val": "top-left"
               }
            }
         ],
         "name": "notify",
         "source": null
      }}],
      "blocktype": "every",
      "callbacks": null,
      "cond": {
         "type": "bool",
         "val": "true"
      },
      "emit": "\n\t\tJSON.parse = JSON.parse || JSON.decode;\n\n\t\tKOBJ.a41x89.oldData = KOBJ.a41x89.oldData || [];\n\n\t\tKOBJ.parseOld = function(functionCall){\n\t\t\tvar possibleObject = functionCall.replace(/.*?(\\[.*\\]).*/,'$1');\n\t\t\tvar object = JSON.parse(possibleObject);\n\t\t\tif(typeof object === 'object'){\n\t\t\t\treturn object;\n\t\t\t} else {\n\t\t\t\treturn false;\n\t\t\t}\n\t\t};\n\t\t\n\t\t\n\t\tKOBJ.highlight = function(oldArray){\n\t\t\t$K.each(oldArray, function(){\n\t\t\t\tvar objToHighlight = this;\n\t\t\n\t\t\t\t$K(objToHighlight.selector).addClass('jqueryOldDetector');\n\t\t\t\t$K(objToHighlight.selector).val(objToHighlight.map);\n\t\t\t});\n\t\t};\n\t\t\n\t\tKOBJ.addObjectsToDiv = function(oldArray){\n\n\t\t\t$K(\"#configDiv\").html('');\n\n\t\t\t$K.each(oldArray, function(theElement){\n\t\t\t\tvar objToAdd = this;\n\n\t\t\t\tvar selector = \"[name=KOBJ_form_\"+ theElement + \"]\";\n\t\t\t\t\n\t\t\t\tfunction newStuff(value){\n\t\t\t\t\tvar form = this;\n\n\t\t\t\t\tif($K(\"[name^=KOBJ_form_]\",$K(form).parent().parent()).val()){\n\t\t\t\t\t\tvalue = $K(\"[name^=KOBJ_form_]\",$K(form).parent().parent()).val();\n\t\t\t\t\t}\n\n\t\t\t\t\tvar obj = KOBJ.formData;\n\n\t\t\t\t\t$K.each(obj,function(element){\n\t\t\n\t\t\t\t\t\tvar toTry = this;\n\t\t\t\n\t\t\t\t\t\tif(objToAdd.selector == toTry.selector){\n\t\t\t\t\t\t\tif(value == \"------\"){\n\t\t\t\t\t\t\t\tobj.splice(element,1);\n\t\t\t\t\t\t\t\treturn false;\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\tif($K(\".formatter\",$K(form).parent().parent()).length){\n\t\t\t\t\t\t\t\tobjToAdd.format = $K(\".formatter\",$K(form).parent().parent()).val();\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\tobjToAdd.map = value;\n\t\t\t\t\t\t\t$K(objToAdd.selector).val(objToAdd.map);\n\t\t\t\t\t\t\tobj[element] = objToAdd;\n\t\t\t\t\t\t}\n\t\t\t\t\t});\n\t\t\n\t\t\t\t\tKOBJ.formData = obj;\n\t\t\t\t\t\t\t\n\t\t\t\t\t$K('#formFillerFunc,#funcInput').val('');\n\t\t\t\t\tvar string = $K.compactJSON(KOBJ.formData);\n\t\t\t\t\t$K('#formFillerFunc,#funcInput').val(string);\n\t\t\t\t\tKOBJ.addObjectsToDiv(KOBJ.formData);\n\n\t\t\t\t}\n\n\n\t\t\t\tvar selectDealy = $K(selectOptions).val(objToAdd.map).attr(\"name\",\"KOBJ_form_\"+theElement).bind('change',function(){\n\n\t\t\t\t\tvar formSelect = this;\n\t\t\t\t\tvar value = $K(formSelect).val();\n\n\t\t\t\t\tnewStuff(value);\n\t\t\t\t\t\t\n\n\t\t\t\t\tif(value == \"card.expiration\"){\n\t\t\t\t\t\t$K(\"#ccNumberSelector\"+theElement+\",#phoneSelector\"+theElement+\",#stateSelector\"+theElement+\",#ccTypeSelector\"+theElement+\",#countrySelector\"+theElement).remove();\n\t\t\t\t\t\t$K(selector).after('<div id=\"dateSelector'+theElement+'\">'+dateSelector+'<\/div>');\n\t\t\t\t\t} else if(value == \"card.number\"){\n\t\t\t\t\t\t$K(\"#dateSelector\"+theElement+\",#stateSelector\"+theElement+\",#ccTypeSelector\"+theElement+\",#countrySelector\"+theElement).remove();\n\t\t\t\t\t\t$K(selector).after('<div id=\"ccNumberSelector'+theElement+'\">'+ccNumberSelector+'<\/div>');\n\t\t\t\t\t} else if(value == \"personal.phone\"){\n\t\t\t\t\t\t$K(\"#ccNumberSelector\"+theElement+\",#dateSelector\"+theElement+\",#stateSelector\"+theElement+\",#ccTypeSelector\"+theElement+\",#countrySelector\"+theElement).remove();\n\t\t\t\t\t\t$K(selector).after('<div id=\"phoneSelector'+theElement+'\">'+phoneSelector+'<\/div>');\n\t\t\t\t\t} else if(value == \"billto.state\" || value == \"shipto.state\"){\n\t\t\t\t\t\t$K(\"#ccNumberSelector\"+theElement+\",#phoneSelector\"+theElement+\",#dateSelector\"+theElement+\",#ccTypeSelector\"+theElement+\",#countrySelector\"+theElement).remove();\n\t\t\t\t\t\t$K(selector).after('<div id=\"stateSelector'+theElement+'\">'+stateSelector+'<\/div>');\n\t\t\t\t\t} else if(value == \"card.type\"){\n\t\t\t\t\t\t$K(\"#ccNumberSelector\"+theElement+\",#dateSelector\"+theElement+\",#stateSelector\"+theElement+\",#ccTypeSelector\"+theElement+\",#countrySelector\"+theElement).remove();\n\t\t\t\t\t\t$K(selector).after('<div id=\"ccTypeSelector'+theElement+'\">'+ccTypeSelector+'<\/div>');\n\t\t\t\t\t} else if(value == \"billto.country\" || value == \"shipto.country\"){\n\t\t\t\t\t\t$K(\"#ccNumberSelector\"+theElement+\",#phoneSelector\"+theElement+\",#stateSelector\"+theElement+\",#ccTypeSelector\"+theElement).remove();\n\t\t\t\t\t\t$K(selector).after('<div id=\"countrySelector'+theElement+'\">'+countrySelector+'<\/div>');\n\t\t\t\t\t} else {\n\t\t\t\t\t\t$K(\"#ccNumberSelector\"+theElement+\",#dateSelector\"+theElement+\",#phoneSelector\"+theElement+\",#stateSelector\"+theElement+\",#ccTypeSelector\"+ theElement+\",#countrySelector\"+theElement).remove();\n\t\t\t\t\t}\n\n\t\t\t\t\tnewStuff(value);\n\n\t\t\t\t\t$K(\".formatter\",$K(selector).parent()).bind('change',newStuff);\n\n\n\t\t\t\t\t$K('#formFillerFunc').val('');\n\t\t\t\t\tvar string = $K.compactJSON(KOBJ.formData);\n\t\t\t\t\t$K('#formFillerFunc').val(string);\n\t\t\t\t\t$K('#funcInput').val(string);\n\t\t\t\t});\n\n\t\t\t\tvar message = $K('<div>' + $K.compactJSON(objToAdd) + '<\/div>').hover(function(){\n\t\t\t\t\t$K(objToAdd.selector).addClass('visaHovered');\n\t\t\t\t}, function(){\n\t\t\t\t\t$K(objToAdd.selector).removeClass('visaHovered');\n\t\t\t\t}).bind('click',function(){\n\n\t\t\t\t\tvar div = this;\n\t\t\t\t\t\n\t\t\t\t\tif(KOBJ.selectedSelector != ''  || KOBJ.selectedSelector == 0){\n\t\t\t\t\t\t$K(\"#configDiv>div:eq(\"+KOBJ.selectedSelector+\")\").removeClass(\"selectorDivSelected\");\n\t\t\t\t\t}\n\n\t\t\t\t\tvar obj = KOBJ.formData;\n\n\t\t\t\t\t$K.each(obj,function(element){\n\t\t\t\t\t\tvar toTry = this;\n\n\t\t\t\t\t\tif(toTry.selector == objToAdd.selector){\n\t\t\t\t\t\t\t$K(div).addClass(\"selectorDivSelected\");\n\t\t\t\t\t\t\tKOBJ.selectedSelector = theElement;\n\t\t\t\t\t\t\treturn false;\n\t\t\t\t\t\t}\n\t\t\t\t\t});\n\t\t\t\t\t\n\t\t\t\t});\n\n\t\t\t\tif(!$K(objToAdd.selector).length){\n\t\t\t\t\tmessage = message.css({\"background-color\": \"red\"});\n\t\t\t\t}\n\n\t\t\t\tmessage = $K(message).append(selectDealy).append('<br />');\n\n\t\t\t\tvar tempValue = objToAdd.map;\n\n\t\t\t\tif(value == \"card.expiration\"){\n\t\t\t\t\t$K(\"#ccNumberSelector\"+theElement+\",#phoneSelector\"+theElement+\",#stateSelector\"+theElement+\",#ccTypeSelector\"+theElement+\",#countrySelector\"+theElement).remove();\n\t\t\t\t\t$K(selector,message).after('<div id=\"dateSelector'+theElement+'\">'+dateSelector+'<\/div>');\n\t\t\t\t} else if(value == \"card.number\"){\n\t\t\t\t\t$K(\"#dateSelector\"+theElement+\",#stateSelector\"+theElement+\",#ccTypeSelector\"+theElement+\",#countrySelector\"+theElement).remove();\n\t\t\t\t\t$K(selector,message).after('<div id=\"ccNumberSelector'+theElement+'\">'+ccNumberSelector+'<\/div>');\n\t\t\t\t} else if(value == \"personal.phone\"){\n\t\t\t\t\t$K(\"#ccNumberSelector\"+theElement+\",#dateSelector\"+theElement+\",#stateSelector\"+theElement+\",#ccTypeSelector\"+theElement+\",#countrySelector\"+theElement).remove();\n\t\t\t\t\t$K(selector,message).after('<div id=\"phoneSelector'+theElement+'\">'+phoneSelector+'<\/div>');\n\t\t\t\t} else if(value == \"billto.state\" || value == \"shipto.state\"){\n\t\t\t\t\t$K(\"#ccNumberSelector\"+theElement+\",#phoneSelector\"+theElement+\",#dateSelector\"+theElement+\",#ccTypeSelector\"+theElement+\",#countrySelector\"+theElement).remove();\n\t\t\t\t\t$K(selector,message).after('<div id=\"stateSelector'+theElement+'\">'+stateSelector+'<\/div>');\n\t\t\t\t} else if(value == \"card.type\"){\n\t\t\t\t\t$K(\"#ccNumberSelector\"+theElement+\",#dateSelector\"+theElement+\",#stateSelector\"+theElement+\",#ccTypeSelector\"+theElement+\",#countrySelector\"+theElement).remove();\n\t\t\t\t\t$K(selector,message).after('<div id=\"ccTypeSelector'+theElement+'\">'+ccTypeSelector+'<\/div>');\n\t\t\t\t}if(value == \"billto.country\" || value == \"shipto.country\"){\n\t\t\t\t\t$K(\"#ccNumberSelector\"+theElement+\",#phoneSelector\"+theElement+\",#stateSelector\"+theElement+\",#ccTypeSelector\"+theElement).remove();\n\t\t\t\t\t$K(selector,message).after('<div id=\"countrySelector'+theElement+'\">'+countrySelector+'<\/div>');\n\t\t\t\t} else {\n\t\t\t\t\t$K(\"#ccNumberSelector\"+theElement+\",#dateSelector\"+theElement+\",#phoneSelector\"+theElement+\",#stateSelector\"+theElement+\",#ccTypeSelector\"+ theElement+\",#countrySelector\"+theElement).remove();\n\t\t\t\t}\n\t\t\t\n\t\t\t\t$K(\".formatter\",message).bind('change',newStuff);\n\n\t\t\t\tif(objToAdd.format){\n\t\t\t\t\t$K(\".formatter\",message).val(objToAdd.format);\n\t\t\t\t}\n\n\t\t\t\t$K(\"#configDiv\").append(message);\n\n\t\t\t});\n\t\t};\n\t\t\n\t\tKOBJ.magicGoodness = function(){\n\t\t\tvar string = $K(\"#funcInput\").val();\n\t\t\n\t\t\tif(string){\n\t\t\t\tvar obj = KOBJ.parseOld(string);\n\t\t\t}\n\t\t\n\t\t\tif(obj){\n\t\t\t\tKOBJ.highlight(obj);\n\t\t\t\tKOBJ.addObjectsToDiv(obj);\n\t\t\t\tKOBJ.formData = [];\n\t\t\t\tKOBJ.formData = obj;\n\t\t\t}\n\t\t};\n\t\t\n\t\t$K(\"#funcInput\").live('change',KOBJ.magicGoodness);\n\n\t\tKOBJ.selectorReturned = '';\n\n\t\tif(typeof(KOBJ.formData) == \"undefined\"){\n\t\t\t\tKOBJ.formData = [];\n\t\t}\n\t\t\n\t\t$K(\"[name=jqueryDetectorButton]\").live('click',function(){\n\t\t\tif(KOBJ.selectorReturned == ''){\n\t\t\t\treturn false;\n\t\t\t}\n\t\t\tvar mappedElement = $K('[name=jqueryMapper]').val();\n\t\t\tvar obj = {\"selector\":KOBJ.selectorReturned,\"map\":mappedElement};\n\t\t\tif($K(\"#ccNumberSelector>select,#dateSelector>select,#stateSelector>select,#phoneSelector>select,#ccTypeSelector>select,#countrySelector>select\").length){\n\t\t\t\tobj.format = $K(\"#ccNumberSelector>select,#dateSelector>select,#stateSelector>select,#phoneSelector>select,#ccTypeSelector>select,#countrySelector>select\").val();\n\t\t\t}\n\n\t\t\tKOBJ.formData.push(obj);\n\t\t\t$K('#formFillerFunc').val('');\n\t\t\tvar string = $K.compactJSON(KOBJ.formData);\n\t\t\t$K('#formFillerFunc').val(string);\n\t\t});\n\n\t\t\n\t\tKOBJ.detectSelector = function(passedElement){\n\n\n\t\t\tvar element = $K(passedElement);\n\n\t\t\tvar tagName = $K(element)[0].tagName.toLowerCase();\n\n\n\n\t\t\tif($K(element).attr('id')){\n\t\t\t\treturn  '#'+$K(element).attr('id');\n\t\t\t} else if($K(element).attr('name')){\n\t\t\t\treturn '[name='+$K(element).attr('name')+']';\n\t\t\t} else if($K(element).parent().children(tagName).length == 1){\n\t\t\t\tvar parentSelector = KOBJ.detectSelector($K(element).parent());\n\t\t\t\treturn parentSelector + '>' + tagName;\n\t\t\t} else if($K(element).attr('class')){\n\t\t\t\tvar elementClass = $K(element).attr('class');\n\t\t\t\tif($K('.'+elementClass).length == 1){\n\t\t\t\t\treturn '.'+elementClass;\n\t\t\t\t} else {\n\t\t\t\t\tvar counter = 0;\n\t\t\t\t\tvar tmpReturn = '';\n\n\t\t\t\t\t$K('.'+elementClass).each(function(){\n\t\t\t\t\t\tvar data = $K(this);\n\t\t\t\t\t\tif($K(element)[0] == $K(data)[0]){\n\t\t\t\t\t\t\ttmpReturn =  '.' + $K(element).attr('class') + ':eq(' + counter + ')';\n\t\t\t\t\t\t\treturn false;\n\t\t\t\t\t\t}\n\t\t\t\t\t\tcounter++;\n\t\t\t\t\t});\n\t\t\t\t\tif(tmpReturn){\n\t\t\t\t\t\treturn tmpReturn;\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t\t} else {\n\t\t\t\tvar parentSelector = KOBJ.detectSelector($K(element).parent());\n\t\t\t\tvar counter = 0;\n\t\t\t\tvar tmpReturn = '';\n\n\t\t\t\t$K(parentSelector + '>' + tagName).each(function(){\n\t\t\t\t\tvar data = $K(this);\n\t\t\t\t\tif($K(element)[0] == $K(data)[0]){\n\t\t\t\t\t\ttmpReturn = parentSelector + '>' + tagName + ':eq(' + counter + ')';\n\t\t\t\t\t\treturn false;\n\t\t\t\t\t}\n\t\t\t\t\tcounter++;\n\t\t\t\t});\n\t\t\t\tif(tmpReturn){\n\t\t\t\t\treturn tmpReturn;\n\t\t\t\t}\n\t\t\t}\n\t\t};\n\n\t\tfunction selectorBind(){\n\n\t\t\t$K(KOBJ.selectorReturned).removeClass('jqueryDetector');\n\t\t\tvar dataElement = this;\n\t\t\tKOBJ.selectorReturned = KOBJ.detectSelector(dataElement);\n\t\t\tif(typeof(KOBJ.selectedSelector) !== 'string' && (typeof(KOBJ.selectedSelector) === ('number'||'undefined'))){\n\t\t\t\tKOBJ.log(\"You have clicked on a div...\");\n\t\t\t\tvar temp = KOBJ.formData[KOBJ.selectedSelector];\n\t\t\t\talert(\"You have changed \" + temp.selector + \" to \" + KOBJ.selectorReturned);\n\t\t\t\ttemp.selector = KOBJ.selectorReturned;\n\t\t\t\tKOBJ.formData[KOBJ.selectedSelector] = temp;\n\t\t\t\tKOBJ.addObjectsToDiv(KOBJ.formData);\n\t\t\t\t$K('#formFillerFunc').val('');\n\t\t\t\tvar string = $K.compactJSON(KOBJ.formData);\n\t\t\t\t$K('#formFillerFunc').val(string);\n\t\t\t\t$K('#funcInput').val(string);\n\t\t\t\tKOBJ.selectedSelector = '';\n\t\t\t\treturn false;\n\t\t\t}\n\n\t\t\tKOBJ.a41x89.oldData.push(KOBJ.selectorReturned);\n\t\t\tif(KOBJ.a41x89.oldData[KOBJ.a41x89.oldData.length -1] == KOBJ.a41x89.oldData[KOBJ.a41x89.oldData.length - 3]){\n\t\t\t\treturn false;\n\t\t\t}\n\t\t\tKOBJ.log('Object you just clicked:');\n\t\t\tKOBJ.log(KOBJ.selectorReturned);\n\t\t\t$K('#jquerySelector').html(KOBJ.selectorReturned);\n\t\t\t$K(KOBJ.selectorReturned).addClass('jqueryDetector');\n\t\t\treturn false;\n\n\t\t}\n\t\t\n\t\t$K('select').bind('change',selectorBind);\n\n\t\t$K('img,a,div,span,cite,input,p,h1,h2,h3,h4,h5').bind('click',selectorBind);\n\t\ttry{\n\t\t\t$K('iframe').contents().find('img,a,div,span,cite,input,p,h1,h2,h3,h4,h5').bind('click',selectorBind);\n\t\t} catch(error) {\n\t\t\tKOBJ.log(\"I won't be able to do iframes due to an error.\");\n\t\t}\n\n\t\t$K('.kGrowl-notification .close').live('click',function(){\n\t\t\t$K('img,a,div,span,cite,input,p,h1,h2,h3,h4,h5').unbind('click',selectorBind);\n\t\t\t$K('iframe').contents().find('img,a,div,span,cite,input,p,h1,h2,h3,h4,h5').bind('click',selectorBind);\n\t\t\t$K('select').unbind('onchange',selectorBind);\n\t\t\t$K(KOBJ.selectorReturned).removeClass('jqueryDetector');\n\t\t});\n\t\t\n\t\tKOBJ.parseOld = function(functionCall){\n\t\t\tvar possibleObject = functionCall.replace(/.*?(\\[.*\\]).*/,'$1');\n\t\t\tvar object = JSON.parse(possibleObject);\n\t\t\tif(typeof object === 'object'){\n\t\t\t\treturn object;\n\t\t\t} else {\n\t\t\t\treturn false;\n\t\t\t}\n\t\t};\n\n\t$K(\"[name=jqueryMapper]\").live('change',function(){\n\t\tvar form = this;\n\t\tvar value = $K(form).val();\n\n\n\t\t$K(\"#phoneSelector,#stateSelector,#ccTypeSelector,#countrySelector,#dateSelector,#ccNumberSelector,#nameSelector\").remove();\n\n\n\t\tif(value == \"card.expiration\"){\n\t\t\t$K(form).after('<div id=\"dateSelector\">'+dateSelector+'<\/div>');\n\t\t} else if(value == \"personal.phone\"){\n\t\t\t$K(form).after('<div id=\"phoneSelector\">'+phoneSelector+'<\/div>');\n\t\t} else if(value == \"billto.state\"|| value == \"shipto.state\"){\n\t\t\t$K(form).after('<div id=\"stateSelector\">'+stateSelector+'<\/div>');\n\t\t} else if(value == \"card.type\"){\n\t\t\t$K(form).after('<div id=\"ccTypeSelector\">'+ccTypeSelector+'<\/div>');\n\t\t} else if(value == \"billto.country\" || value == \"shipto.country\"){\n\t\t\t$K(form).after('<div id=\"countrySelector\">'+countrySelector+'<\/div>');\n\t\t} else if(value == \"card.number\"){\n\t\t\t$K(form).after('<div id=\"ccNumberSelector\">'+ccNumberSelector+'<\/div>');\n\t\t} else if(value.match(/firstname|lastname/)){\n\t\t\t$K(form).after('<div id=\"nameSelector\">'+nameSelector+'<\/div>');\n\t\t}\n\t});\n\n\n\t",
      "foreach": [],
      "name": "jquery_detector",
      "pagetype": {"event_expr": {
         "legacy": 1,
         "op": "pageview",
         "pattern": ".*",
         "type": "prim_event",
         "vars": []
      }},
      "pre": [
         {
            "lhs": "selectOptions",
            "rhs": "\n\t\t\t<select name=\"jqueryMapper\">\n\t\t\t\t<option>------<\/option>\n\t\t\t\t<option>personal.firstname<\/option>\n\t\t\t\t<option>personal.lastname<\/option>\n\t\t\t\t<option>personal.email<\/option>\n\t\t\t\t<option>personal.phone<\/option>\n\t\t\t\t<option>shipto.firstname<\/option>\n\t\t\t\t<option>shipto.lastname<\/option>\n\t\t\t\t<option>shipto.street1<\/option>\n\t\t\t\t<option>shipto.street2<\/option>\n\t\t\t\t<option>shipto.city<\/option>\n\t\t\t\t<option>shipto.state<\/option>\n\t\t\t\t<option>shipto.zip<\/option>\n\t\t\t\t<option>shipto.country<\/option>\n\t\t\t\t<option>billto.firstname<\/option>\n\t\t\t\t<option>billto.lastname<\/option>\n\t\t\t\t<option>billto.street1<\/option>\n\t\t\t\t<option>billto.street2<\/option>\n\t\t\t\t<option>billto.city<\/option>\n\t\t\t\t<option>billto.state<\/option>\n\t\t\t\t<option>billto.zip<\/option>\n\t\t\t\t<option>billto.country<\/option>\n\t\t\t\t<option>card.number<\/option>\n\t\t\t\t<option>card.type<\/option>\n\t\t\t\t<option>card.nameoncard<\/option>\n\t\t\t\t<option>card.expiration<\/option>\n\t\t\t\t<option>card.verificationcode<\/option>\n\t\t\t<\/select>\n\t\t",
            "type": "here_doc"
         },
         {
            "lhs": "dateSelector",
            "rhs": "\n\t\t\t<select class=\"formatter\">\n\t\t\t\t<option>MM/yyyy<\/option>\n\t\t\t\t<option>yyyy/MM<\/option>\n\t\t\t\t<option>MM/yy<\/option>\n\t\t\t\t<option>yy/MM<\/option>\n\t\t\t\t<option>MM<\/option>\n\t\t\t\t<option>mM<\/option>\n\t\t\t\t<option>yy<\/option>\n\t\t\t\t<option>yyyy<\/option>\n\t\t\t\t<option>y,yyy<\/option>\n\t\t\t<\/select>\n\t\t",
            "type": "here_doc"
         },
         {
            "lhs": "phoneSelector",
            "rhs": "\n\t\t\t<select class=\"formatter\">\n\t\t\t\t<option>all<\/option>\n\t\t\t\t<option>area<\/option>\n\t\t\t\t<option>first-3<\/option>\n\t\t\t\t<option>last-4<\/option>\n\t\t\t\t<option>last-7<\/option>\n\t\t\t\t<option>(nnn)nnn-nnnn<\/option>\n\t\t\t\t<option>nnn-nnn-nnnn<\/option>\n\t\t\t<\/select>\n\t\t",
            "type": "here_doc"
         },
         {
            "lhs": "countrySelector",
            "rhs": "\n\t\t\t<select class=\"formatter\">\n\t\t\t\t<option>Short<\/option>\n\t\t\t\t<option>Long<\/option>\n\t\t\t\t<option>CC<\/option>\n\t\t\t\t<option>CCC<\/option>\n\t\t\t\t<option>cc<\/option>\n\t\t\t\t<option>ccc<\/option>\n\t\t\t<\/select>\n\t\t",
            "type": "here_doc"
         },
         {
            "lhs": "stateSelector",
            "rhs": "\n\t\t\t<select class=\"formatter\">\n\t\t\t\t<option>ST<\/option>\n\t\t\t\t<option>State<\/option>\n\t\t\t\t<option>STATE<\/option>\n\t\t\t\t<option>ST - State<\/option>\n\t\t\t<\/select>\n\t\t",
            "type": "here_doc"
         },
         {
            "lhs": "ccTypeSelector",
            "rhs": "\n\t\t\t<select class=\"formatter\">\n\t\t\t\t<option>CCTYPE<\/option>\n\t\t\t\t<option>CCType<\/option>\n\t\t\t\t<option>CCType w/ AMEX<\/option>\n\t\t\t\t<option>CCType w/ AMEX and Master Card<\/option>\n\t\t\t\t<option>CCType w/ AmericanExpress<\/option>\n\t\t\t\t<option>CC Type<\/option>\n\t\t\t\t<option>CT<\/option>\n\t\t\t\t<option>VS<\/option>\n\t\t\t\t<option>amex<\/option>\n\t\t\t\t<option>num<\/option>\n\t\t\t\t<option>num2<\/option>\n\t\t\t\t<option>C<\/option>\n\t\t\t<\/select>\n\t\t",
            "type": "here_doc"
         },
         {
            "lhs": "ccNumberSelector",
            "rhs": "\n\t\t\t<select class=\"formatter\">\n\t\t\t\t<option>all<\/option>\n\t\t\t\t<option>first-group<\/option>\n\t\t\t\t<option>second-group<\/option>\n\t\t\t\t<option>third-group<\/option>\n\t\t\t\t<option>last-group<\/option>\n\t\t\t<\/select>\n\t\t",
            "type": "here_doc"
         },
         {
            "lhs": "nameSelector",
            "rhs": "\n\t\t\t<select class=\"formatter\">\n\t\t\t\t<option>none<\/option>\n\t\t\t\t<option>fullname<\/option>\n\t\t\t<\/select>\n\t\t",
            "type": "here_doc"
         },
         {
            "lhs": "message",
            "rhs": "\n\t\t\tHello! You are looking to find out what selectors you should use, yes?<br /><br />\n\t\t\tForms, divs, anchors (links), images, headers (h1,h2,etc.), paragraphs, citations (cite) and spans will work.<br /><br />\n\t\t\tSelector to use:<span id=\"jquerySelector\" style=\"margin-left: 5px; color: red\"><\/span><br /><br />\n\t\t\t#{selectOptions}\n\t\t\t<br /><br />\n\t\t\t<button type=\"button\" name=\"jqueryDetectorButton\">Add item to map<\/button><br /><br />\n\t\t\tOverall form fill function call (so far):<br />\n\t\t\t<textarea rows=\"10\" style=\"width: 290px;\" id=\"formFillerFunc\" />\n\t\t\t<br /><br /><br /><br />\n\n\t\t\tPut in the current function to have good stuff happen.\n\t\t\t<textarea  rows=\"10\" style=\"width: 290px;\" id=\"funcInput\" /><br /><br />\n\t\t\n\t\t\tHover over and change the following to get stuff to do things.<br />\n\t\t\tIf you would like to no longer do stuff, click <span onclick=\"if(KOBJ.selectedSelector != '' || KOBJ.selectedSelector == 0){$K('#configDiv>div:eq('+KOBJ.selectedSelector+')').removeClass('selectorDivSelected');}KOBJ.selectedSelector = '';\"> here.<\/span><br />\n\n\t\t\t<div id=\"configDiv\"><\/div>\n\t\t",
            "type": "here_doc"
         }
      ],
      "state": "active"
   }],
   "ruleset_name": "a41x89"
}