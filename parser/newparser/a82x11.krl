{"global":[{"content":"#spotlight-reminders-wrapper{    \theight:24px;    \tbackground:#e4effd;    \tpadding:0 0 0 9px;    \tmargin:15px 0;    \tfont-size:small;    }        .remindme-reminders-wrapper{    \theight:24px;    \tbackground:white;    \tpadding:0;    \tmargin:0;    \tfont-size:small;    \twidth:450px;    }        p.descriptive-text{    \tfloat:right;    \tmargin:4px 9px 0 0;    \tpadding:0;    \tcolor:#7a7a7a;    \tfont-size:small;    }        ul.spotlightReminders{    \tfloat:left;    \tmargin:0;    \tpadding:0;    \tlist-style:none;    \theight:24px;    }        ul.spotlightReminders li{    \tdisplay:block;    \tfloat:left !important;    \tmargin:3px 3px 0 0;    }        ul.spotlightReminders li.azigo-logo{    \tmargin:4px 0 0 0;    }        ul.spotlightReminders li.txt-reminder{    \tpadding:0 0 0 4px;    \tmargin:4px 3px 0 0;    \tcolor:#2b30d1;    }        .clear{    \tclear:both;    }               .remindme-flyout-wrapper{    \tborder: 3px solid #e471ac;    \twidth:450px;    \tmargin:0 0 0 20px;    \tposition: absolute;            background-color: white;    \tdisplay: none;    \tz-index: 1;    \ttext-align:left;    }        .flyout-pointer{    \tbackground:url(\"http://www.azigo.com/images/rm/FlyoutPoint.png\") no-repeat;    \theight:11px;    \twidth:15px;    \tposition:relative;    \tmargin:-11px 0 0 20px;    }        .flyout-reminder-details{    \tpadding:8px 10px;    \tborder-bottom:1px solid #c2c2c2;            color: black;    \tfloat: left;    }        p.flyout-reminder-url{    \tmargin:0 0 5px 0;    \tpadding:0;    }        .flyout-reminder-details ul{    \tmargin:0;    \tpadding:0;    \tlist-style:none;    \tline-height:14px;    }        .flyout-reminder-details ul li{    \tdisplay:block;    \tfloat:left !important;    \tmargin:0 4px 0 0;    \tpadding:0;    }        .flyout-reminder-details ul li.flyout-reminder-url{    \tmargin:0 0 5px 0;    \tpadding:0;    \twidth:250px;    }        .flyout-reminder-details ul li.flyout-reminder-text{    \twidth:230px;    }        .flyout-reminder-details ul li.flyout-reminder-button{    \tmargin:0;    }        a.flyout-reminder-button{    \tdisplay:block;    \tfont-size:10px;    \tfont-weight:bold;    \tfont-family:Verdana, sans-serif, Arial, Helvetica;    \tbackground:#57b6e3;    \ttext-align:center;    \ttext-decoration:none;    \theight:16px;    \twidth:96px;    \tcolor:#fff;    \tpadding:2px 0 0 0;    \tmargin:0;    }            .clearfix:after {        content: \".\";        display: block;        clear: both;        visibility: hidden;        line-height: 0;        height: 0;    }        .clearfix {        display: inline-block;    }        html[xmlns] .clearfix {        display: block;    }        * html .clearfix {        height: 1%;    }           .flyout-wrapper{    \tborder: 3px solid #e471ac;    \twidth:450px;    \tmargin:-15px 0 0 29px;    \tposition: absolute;            background-color: white;    \tdisplay: none;    \tz-index: 1;    }                .flyout-reminder-details{    \tpadding:8px 10px;    \tborder-bottom:1px solid #c2c2c2;    \tfont-size: small;            width:430px;    }    ","type":"css"},{"emit":"\nvar globalData = {                                    \"Source\" : \"sadv\",    \t\t\t\t\"RemindMeIconUrl\" : \"http://www.azigo.com/images/rm/crd/sadv_18x24.png\",                                    \"FlyoutIconUrl\" : \"http://www.azigo.com/images/rm/crd/sadv_60x90.png\"    \t\t\t };        \tfunction remindMeSelector(obj) {                    var annotationContent;    \t\tvar remindMeDomain = obj.name.replace(/http:\\/\\/([A-Za-z0-9.-]+)\\/.*/,\"$1\");            \tremindMeDomain = remindMeDomain.replace(\"http://\",\"\");    \t\tremindMeDomain = remindMeDomain.replace(\"www.\",\"\");    \t\tremindMeDomain = remindMeDomain.replace(\"www1.\",\"\");    \t\tremindMeDomain = remindMeDomain.replace(/\\.[^.]+$/,\"\");                    remindMeDomain = remindMeDomain.replace(/[&]/g,\"and\");                    remindMeDomain = remindMeDomain.replace(/\\s+/g,\"\");    \t\tremindMeDomain = remindMeDomain.replace(/[']/g,\"\");    \t\tremindMeDomain = remindMeDomain.replace(/[-]/g,\"\");                    remindMeDomain = remindMeDomain.toLowerCase();                        var remindMeDivId = \"remindMe_\"+remindMeDomain;                    var remindMeFlyoutDivId = \"remindMeFlyout_\"+remindMeDomain;    \t\tvar remindMeWrapper = \"remindMeWrapper_\"+remindMeDomain;        \t\tif($K(\"#\"+remindMeDivId).length == 0) {    \t\t   var remindMeMainDiv = createRemindMeDiv(remindMeDivId);                       var remindMeFlyoutDiv = createRemindMeFlyoutDiv(remindMeFlyoutDivId);        \t\t   remindMeFlyoutDiv.append(    \t\t\tgetFlyoutDetails(                                                     obj.name,                                                     obj.link,                                                      globalData.FlyoutIconUrl,                                                      obj.text,                                                      obj.icon                                              )    \t\t   );         \t           var remindMeDiv = $K(\"<div><\/div>\");                           var wrapperDiv = $K(\"<div id='\"+remindMeWrapper+\"' class='remindme-reminders-wrapper'><\/div>\");    \t\t   wrapperDiv.append(remindMeMainDiv);        \t\t   remindMeDiv.append(wrapperDiv);        \t           remindMeDiv.append(remindMeFlyoutDiv);                           annotationContent = remindMeDiv;                       registerEvents(remindMeDivId, remindMeFlyoutDivId, false);                    }                    else {                        if($K(\"#\"+remindMeDivId).find(\"#img_\"+globalData.Source+\"_remindMe\").length) {                            return false;                       }        \t\t   if($K(\"#\"+remindMeDivId).children(\".txt-reminder\").length) {                          $K(\"#\"+remindMeDivId).children(\".txt-reminder\").after(                                                  makeListItem(    \t\t                                    null,     \t\t                                    null,     \t\t                                    $K(\"<img id='img_\"+globalData.Source+\"_remindMe' src='\"+globalData.RemindMeIconUrl+\"' />\")    \t\t                              )                          );                       }        \t\t   if($K(\"#\"+remindMeFlyoutDivId).length) {    \t\t\t$K(\"#\"+remindMeFlyoutDivId).append(    \t\t\t                   getFlyoutDetails(                                                                    obj.name,                                                                    obj.link,                                                                     globalData.FlyoutIconUrl,                                                                     obj.text,                                                                     obj.icon                                               )    \t\t        );      \t\t   }        \t\t     \t\t   var spanReminders = $K(\"#\"+remindMeDivId).children(\".txt-reminder\").children(\".spanRemindMeNReminders\");                       if (spanReminders.length > 0)                       {                           var totalReminders = parseInt(spanReminders.text());                           if (!isNaN(totalReminders))                           {    \t                    totalReminders = totalReminders + 1;                                spanReminders.text(String(totalReminders));    \t                    if(totalReminders == 1) {    \t\t               $K(\"#\"+remindMeDivId).children(\".txt-reminder\").children(\".spanRemindMeTextReminders\").text(\"Reminder\");    \t                    }    \t                    else {    \t\t               $K(\"#\"+remindMeDivId).children(\".txt-reminder\").children(\".spanRemindMeTextReminders\").text(\"Reminders\");    \t                    }                           }                    \t\t   }                       annotationContent = false;                    }    \t     return annotationContent;            }                function registerEvents(remindMeDivId, remindMeFlyoutDivId, isSpotlightEvent) {\t\t    \t     $K(\"#\"+remindMeDivId).live('mouseover', function () {    \t\t   $K('#'+remindMeDivId).css({'cursor':'hand','cursor':'pointer'});                       $K('#'+remindMeFlyoutDivId).show();    \t     });        \t     $K(\"#\"+remindMeDivId).live('mouseout', function () {                                              if(isSpotlightEvent) {                          $K(\"#spotlight-reminders-wrapper\").live('mouseover', function() {                               $K('#'+remindMeFlyoutDivId).show();                                                     });                          $K(\"#spotlight-reminders-wrapper\").live('mouseout', function() {                               $K('#'+remindMeFlyoutDivId).hide();       \t\t\t   $K(\"#spotlight-reminders-wrapper\").die('mouseover');    \t\t\t   $K(\"#spotlight-reminders-wrapper\").die('mouseout');                          });                       }    \t\t   else {    \t\t\t$K(\"#\"+remindMeDivId).parent().mouseover(function() {                               $K('#'+remindMeFlyoutDivId).show();        \t\t\t});                          $K(\"#\"+remindMeDivId).parent().mouseout(function() {                               $K('#'+remindMeFlyoutDivId).hide();       \t\t\t   $K(\"#\"+remindMeDivId).parent().unbind('mouseover');    \t\t\t   $K(\"#\"+remindMeDivId).parent().unbind('mouseout');                          });    \t\t   }        \t\t   $K('#'+remindMeFlyoutDivId).hide();    \t     });        \t     $K(\"#\"+remindMeFlyoutDivId).live('mouseover', function () {            \t   $K('#'+remindMeFlyoutDivId).show();    \t     });        \t     $K(\"#\"+remindMeFlyoutDivId).live('mouseout', function () {    \t\t   $K('#'+remindMeFlyoutDivId).hide();    \t\t   if(isSpotlightEvent) {    \t\t\t   $K(\"#spotlight-reminders-wrapper\").die('mouseover');    \t\t\t   $K(\"#spotlight-reminders-wrapper\").die('mouseout');    \t\t   }    \t\t   else {    \t\t\t   $K(\"#\"+remindMeDivId).parent().unbind('mouseover');    \t\t\t   $K(\"#\"+remindMeDivId).parent().unbind('mouseout');    \t\t   }                 });            }        \tfunction createRemindMeDiv(remindMeDivId) {                 var remindMeMainUl = $K(\"<ul><\/ul>\");                 remindMeMainUl.attr({\"id\":remindMeDivId, \"class\":\"spotlightReminders\"});                     remindMeMainUl.append(                      makeListItem(null, \"azigo-logo\", $K(\"<img src='http:               );                     remindMeMainUl.append(                      makeListItem(    \t\t     \"remindme-txt-reminder\",     \t\t     \"txt-reminder\",     \t\t     \"<span class='spanRemindMeNReminders'>1<\/span> <span class='spanRemindMeTextReminders'>Reminder<\/span>\"    \t\t  )                 );                     remindMeMainUl.append(                      makeListItem(    \t\t     null,     \t\t     null,     \t\t     $K(\"<img id='img_\"+globalData.Source+\"_remindMe' src='\"+globalData.RemindMeIconUrl+\"' />\")    \t\t  )                 );                     remindMeMainUl.append(                      makeListItem(null, null, $K(\"<img src='http://www.azigo.com/images/rm/FlyoutIndicator.png' />\"))                 );                     return remindMeMainUl;            }        \tfunction createRemindMeFlyoutDiv(remindMeFlyoutDivId)            {    \t    var remindMeFlyoutDiv = $K(\"<div><\/div>\");    \t    remindMeFlyoutDiv.attr({\"id\":remindMeFlyoutDivId, \"class\":\"remindme-flyout-wrapper\"});    \t    remindMeFlyoutDiv.append($K(\"<div><\/div>\").attr(\"class\", \"flyout-pointer\"));                return remindMeFlyoutDiv;            }        \tfunction makeListItem(listItemId, listItemClass, listItemContent) {                 var listItem = $K(\"<li><\/li>\");                 if(listItemClass != null) {                     listItem.attr(\"class\", listItemClass);                 }    \t     if(listItemId != null) {    \t         listItem.attr(\"id\", listItemId);    \t     }                 listItem.append(listItemContent);                 return listItem;                    }        \tfunction makeAnchorTag(aUrl, aClass, aText)            {                 var anchorTag = $K(\"<a><\/a>\");                 anchorTag.attr(\"href\", aUrl);                 if(aClass != null) {                     anchorTag.attr(\"class\", aClass);                 }                 anchorTag.append(aText);                 return anchorTag;            }                    function getFlyoutDetails(clientName, clientUrl, clientLogo, displayText, buttonType)        { \t             \tvar flyoutDetailsDiv = $K(\"<div><\/div>\");    \tflyoutDetailsDiv.attr(\"class\",\"flyout-reminder-details clearfix\");                var flyoutDetailsUl = $K(\"<ul><\/ul>\");                flyoutDetailsUl.append(    \t\tmakeListItem(null, null, $K(\"<img src='\"+clientLogo+\"' />\"))    \t);            flyoutDetailsUl.append(                    makeListItem(null, \"flyout-reminder-url\", makeAnchorTag(clientUrl, null, clientName))            );            flyoutDetailsUl.append(    \t\tmakeListItem(null, \"flyout-reminder-text\", displayText)    \t);    \tvar discountButton = \"\";    \t  \t\tdiscountButton = makeAnchorTag(clientUrl, \"flyout-reminder-button\", \"Get Discount...\");    \t          flyoutDetailsUl.append(    \t\tmakeListItem(null, null, discountButton)    \t);                        flyoutDetailsDiv.append(flyoutDetailsUl);                    \treturn flyoutDetailsDiv;        }            KOBJ.spotlight = function (source) {                function datasetcallback(d){            if(d) {               var response = d.response;               if(response) {                   if(response.docs.length > 0) {                   \t    displaySpotlight(response);                   }               }            }      \t        }                    var q = String(top.location).replace(/^.*[\\?&][qp]=([^&]+).*$/, \"$1\");        var remoteUrl = \"http://service.azigo.com/solr/nutchfilter.jsp?q=\"+q+\"&fq=source:\"+source+\"&callback=?\";            $K.getJSON(remoteUrl,datasetcallback);                    function createSpotlightMainDiv()        {    \t var spotlightMainDiv = $K(\"<div><\/div>\");    \t spotlightMainDiv.attr(\"id\", \"spotlight-reminders-wrapper\");                 var spotlightMainUl = $K(\"<ul><\/ul>\");             spotlightMainUl.attr({\"id\":\"spotlightReminders\", \"class\":\"spotlightReminders\"});                 spotlightMainUl.append(                        makeListItem(null, 'azigo-logo', $K(\"<img src='http://www.azigo.com/images/rm/azigo_16x16.png' />\"))             );                 var spotlightReminderNSpan = $K(\"<span><\/span>\");             spotlightReminderNSpan.attr(\"id\", \"spanNReminders\");             spotlightReminderNSpan.text(\"0\");                 var spotlightReminderTextSpan = $K(\"<span><\/span>\");             spotlightReminderTextSpan.attr(\"id\", \"spanTextReminders\");             spotlightReminderTextSpan.text(\"Reminders\");                 spotlightMainUl.append(                               makeListItem(    \t\t\t\t\"spotlight-txt-reminder\",     \t\t\t\t\"txt-reminder\",     \t\t\t\t\"<span id='spanNReminders'>0<\/span> <span id='spanTextReminders'>Reminders<\/span>\"    \t\t\t   )             );                 spotlightMainUl.append(                        makeListItem(null, null, $K(\"<img src='http://www.azigo.com/images/rm/FlyoutIndicator.png' />\"))             );                 var spotlightMainP = $K(\"<p><\/p>\");             spotlightMainP.attr(\"class\", \"descriptive-text\");             spotlightMainP.text(\"My Sponsored Links\");                 spotlightMainDiv.append(spotlightMainUl);             spotlightMainDiv.append(spotlightMainP);                 return spotlightMainDiv;        }                    function createSpotlightFlyoutDiv()        {    \tvar spotlightFlyoutDiv = $K(\"<div><\/div>\");    \tspotlightFlyoutDiv.attr({\"id\":\"spotlightFlyoutDiv\", \"class\":\"flyout-wrapper\"});    \tspotlightFlyoutDiv.append($K(\"<div><\/div>\").attr(\"class\", \"flyout-pointer\"));            return spotlightFlyoutDiv;        }                    function flyoutContentCallback(data)        {            if($K('#spotlightFlyoutDiv').length) {               $K.each(data, function(){                            $K('#spotlightFlyoutDiv').append(    \t\t\t                  getFlyoutDetails(                                                     this.name,                                                     this.link,                                                      globalData.FlyoutIconUrl,                                                      this.text,                                                      this.icon                                              )                            );                        }               );            }        }                        function displaySpotlight(response)        {            var logoUrl = globalData.RemindMeIconUrl;                if($K(\"#spotlight-reminders-wrapper\").length == 0) {    \t    var spotlightMainDiv = createSpotlightMainDiv();                var spotlightFlyoutDiv = createSpotlightFlyoutDiv();     \t    var spotlightDiv = $K(\"<div id='spotlight-main-flyout'><\/div>\");    \t    spotlightDiv.append(spotlightMainDiv);    \t    spotlightDiv.append(spotlightFlyoutDiv);                if($K(\"#res\").length) {                    $K(\"#res\").prepend(spotlightDiv);                }                else if($K(\"#web\").length) {                    $K(\"#web\").prepend(spotlightDiv);                }                else if($K(\"#results\").length) {                    $K(\"#results\").prepend(spotlightDiv);                }            }                  \tregisterEvents(\"spotlightReminders\", \"spotlightFlyoutDiv\", true);        \t        \tif($K(\"#img_\"+source+\"_spotlight\").length) {                return;            }                if($K(\"#spotlight-txt-reminder\").length) {                 $K(\"#spotlight-txt-reminder\").after(\"<li><img id='img_\"+source+\"_spotlight' src='\"+logoUrl+\"' /><\/li>\");            }            var spanReminders = $K(\"#spanNReminders\");            if (spanReminders.length > 0)            {                var totalReminders = parseInt(spanReminders.text());               if (!isNaN(totalReminders))               {    \t       if(response.docs.length > 3) {    \t\t   totalReminders = totalReminders + 3;    \t       }    \t       else {                   \t   totalReminders = totalReminders + response.docs.length;    \t       }                   spanReminders.text(String(totalReminders));    \t       if(totalReminders == 1) {    \t\t   $K(\"#spanTextReminders\").text(\"Reminder\");    \t       }    \t       else {    \t\t   $K(\"#spanTextReminders\").text(\"Reminders\");    \t       }               }            }                    \tvar jsonData = \"\";    \tvar index = 1;    \t$K.each(response.docs, function(){    \t\t\t\tif(index > 1)    \t\t\t\t    jsonData += \",\";    \t\t\t\tjsonData += \"'KOBJL\"+index+\"':{'url':'\"+this.url+\"'}\";    \t\t\t\tindex++;    \t\t\t\tif(index > 3)    \t\t\t\t   return false;    \t\t\t});                var jsonUrl = \"https://service.azigo.com/remindmeac/fetch?callback=?&jsonData=true&source=\"+source;            $K.getJSON(jsonUrl, \"annotatedata={\"+jsonData+\"}\", flyoutContentCallback);      }    };                "}],"dispatch":[{"domain":"www.google.com"},{"domain":"maps.google.com"},{"domain":"search.yahoo.com"},{"domain":"local.yahoo.com"}],"ruleset_name":"a82x11","rules":[{"blocktype":"every","emit":"\n        ","pre":[],"name":"kroger_google","callbacks":{"success":[{"trigger":null,"value":"flyout-reminder-button","attribute":"class","type":"click"}]},"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":[],"pattern":"^http://www.google.com|^http://www.bing.com","op":"pageview","type":"prim_event","legacy":1}},"cond":{"args":[],"type":"app","function_expr":{"val":"truth","type":"var"}},"actions":[{"action":{"source":null,"args":[{"val":"remindMeSelector","type":"var"}],"name":"annotate_search_results","modifiers":[{"name":"remote","value":{"val":"https://service.azigo.com/remindmeac/fetch?callback=?&jsonData=true&source=sadv","type":"str"}},{"name":"outer_div_css","value":{"val":[{"rhs":{"val":"none","type":"str"},"lhs":"float"},{"rhs":{"val":"0px","type":"str"},"lhs":"margin-left"},{"rhs":{"val":"0px","type":"str"},"lhs":"padding-right"}],"type":"hashraw"}},{"name":"inner_div_css","value":{"val":[{"rhs":{"val":"0px","type":"str"},"lhs":"margin-left"},{"rhs":{"val":"0px","type":"str"},"lhs":"padding-right"},{"rhs":{"val":"5px","type":"str"},"lhs":"padding-top"}],"type":"hashraw"}},{"name":"li_css","value":{"val":[{"rhs":{"val":"0px","type":"str"},"lhs":"padding-left"},{"rhs":{"val":"normal","type":"str"},"lhs":"white-space"}],"type":"hashraw"}},{"name":"placement","value":{"val":"after","type":"str"}},{"name":"domains","value":{"val":[{"rhs":{"val":[{"rhs":{"val":".sa_cc","type":"str"},"lhs":"modify"}],"type":"hashraw"},"lhs":"www.bing.com"}],"type":"hashraw"}}]}}]},{"blocktype":"every","emit":null,"pre":[],"name":"kroger_spotlight_google","callbacks":{"success":[{"trigger":null,"value":"flyout-reminder-button","attribute":"class","type":"click"}]},"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":[],"pattern":"^http://www.google.com","op":"pageview","type":"prim_event","legacy":1}},"cond":{"args":[],"type":"app","function_expr":{"val":"truth","type":"var"}},"actions":[{"emit":"\nKOBJ.spotlight('sadv');        KOBJ.watchDOM(\"#rso\",function() {                                $K('#spotlight-main-flyout').remove();                                KOBJ.spotlight('sadv');                            }                    );                      "}]},{"blocktype":"every","emit":null,"pre":[],"name":"kroger_spotlight","callbacks":{"success":[{"trigger":null,"value":"flyout-reminder-button","attribute":"class","type":"click"}]},"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":[],"pattern":"^http://search.yahoo.com|^http://www.bing.com","op":"pageview","type":"prim_event","legacy":1}},"cond":{"args":[],"type":"app","function_expr":{"val":"truth","type":"var"}},"actions":[{"emit":"\nKOBJ.spotlight('sadv');                      "}]},{"blocktype":"every","emit":"\n        ","pre":[],"name":"kroger_remindme","callbacks":{"success":[{"trigger":null,"value":"flyout-reminder-button","attribute":"class","type":"click"}]},"state":"active","pagetype":{"foreach":[],"event_expr":{"vars":[],"pattern":"^http://search.yahoo.com","op":"pageview","type":"prim_event","legacy":1}},"cond":{"args":[],"type":"app","function_expr":{"val":"truth","type":"var"}},"actions":[{"action":{"source":null,"args":[{"val":"remindMeSelector","type":"var"}],"name":"annotate_search_results","modifiers":[{"name":"remote","value":{"val":"https://service.azigo.com/remindmeac/fetch?callback=?&jsonData=true&source=sadv","type":"str"}},{"name":"outer_div_css","value":{"val":[{"rhs":{"val":"none","type":"str"},"lhs":"float"},{"rhs":{"val":"40px","type":"str"},"lhs":"height"},{"rhs":{"val":"0px","type":"str"},"lhs":"margin-left"},{"rhs":{"val":"-10px","type":"str"},"lhs":"margin-top"},{"rhs":{"val":"0px","type":"str"},"lhs":"padding-right"}],"type":"hashraw"}},{"name":"inner_div_css","value":{"val":[{"rhs":{"val":"0px","type":"str"},"lhs":"margin-left"},{"rhs":{"val":"0px","type":"str"},"lhs":"padding-right"}],"type":"hashraw"}},{"name":"li_css","value":{"val":[{"rhs":{"val":"0px","type":"str"},"lhs":"padding-left"},{"rhs":{"val":"normal","type":"str"},"lhs":"white-space"}],"type":"hashraw"}},{"name":"placement","value":{"val":"after","type":"str"}},{"name":"domains","value":{"val":[{"rhs":{"val":[{"rhs":{"val":"#web > ol > li","type":"str"},"lhs":"selector"},{"rhs":{"val":"div.res","type":"str"},"lhs":"modify"}],"type":"hashraw"},"lhs":"search.yahoo.com"}],"type":"hashraw"}}]}}]}],"meta":{"description":"\nKroger coupon demo     \n","name":"Kroger - Demo","logging":"off"}}
