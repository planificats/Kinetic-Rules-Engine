{
   "dispatch": [
      {"domain": "www.google.com"},
      {"domain": "search.yahoo.com"},
      {"domain": "www.bing.com"},
      {"domain": "search.microsoft.com"},
      {"domain": "zappos.com"}
   ],
   "global": [{"emit": "\nKOBJ.visa = {             \"payless.com\":[{\"name\":\"Payless\",\"link\":\"http://www.kqzyfj.com/click-1569421-10393678?cm_mmc=CJ-_-1470427-_-1569421-_-Payless%20Home%20Page&sid=|SID|\",\"text\":\"Get 10% cash back\"}],             \"shoemall.com\":[{\"name\":\"Shoe Mall\",\"link\":\"http://www.jdoqocy.com/click-3384099-10387077?sid=|SID|\",\"text\":\"Earn 15 pts per dollar spent\"}],             \"shoes.com\":[{\"name\":\"Shoes.com\",\"link\":\"http://clickserve.cc-dt.com/link/tplclick?lid=41000000025255752&pubid=21000000000042638&mid=|SID|\",\"text\":\"Earn 8 points per dollar spent\"}],             \"harryanddavid.com\":[{\"name\":\"Harry & David\",\"link\":\"http://clickserve.cc-dt.com/link/tplclick?lid=41000000000769078&pubid=21000000000042638&mid=|SID|\",\"text\":\"Get 6% cash back\"}],             \"1800flowers.com\":[{\"name\":\"1800-Flowers\",\"link\":\"http://click.linksynergy.com/fs-bin/click?id=E7Il34ja9WM&offerid=100462.8&type=3&subid=0&u1=|SID|\",\"text\":\"Earn 10 points per dollar spent\"}],             \"proflowers.com\":[{\"name\":\"Proflowers\",\"link\":\"http://clickserve.cc-dt.com/link/tplclick?lid=41000000028347206&pubid=21000000000042638&mid=|SID|\",\"text\":\"Earn 8 points per dollar spent\"}]        };                           "}],
   "meta": {
      "description": "\nVisa Demo Reminder   \n",
      "logging": "off",
      "name": "Visa Demo"
   },
   "rules": [
      {
         "actions": [{"action": {
            "args": [{
               "type": "var",
               "val": "wbur_selector"
            }],
            "modifiers": [
               {
                  "name": "name",
                  "value": {
                     "type": "str",
                     "val": "remindme"
                  }
               },
               {
                  "name": "left_margin",
                  "value": {
                     "type": "str",
                     "val": "46px"
                  }
               }
            ],
            "name": "annotate_search_results",
            "source": null
         }}],
         "blocktype": "every",
         "callbacks": {"success": [{
            "attribute": "class",
            "trigger": null,
            "type": "click",
            "value": "KOBJ_wbur"
         }]},
         "cond": {
            "type": "bool",
            "val": "true"
         },
         "emit": "\nvar link_text = {    \"visa\": \"<img style='padding-top: 3px' src='\" + logo_url_prefix + \"CapitalLogo.png' height='34px' border='0'>\"  };      function make_selector(key){  \tvar func = function(obj){  \t  function mk_anchor (o, key) {              return $K('<a href=' + o.link + '/>').attr(  \t      {\"class\": 'KOBJ_'+key,  \t       \"title\": o.text || \"Click here for discounts!\"  \t      }).html(link_text[key]);  \t  }  \t  var entryURL = $K(obj).find(\"span.url, cite\").text();  \t  var host = KOBJ.get_host(entryURL).replace(/^www./, \"\");            var o = KOBJ.pick(KOBJ.visa[host]);  \t  if(o) {  \t     return mk_anchor(o,key);  \t  } else {  \t    return false;  \t  }  \t};  \treturn func;  }    wbur_selector = make_selector('visa');      search_percolate = {};  search_percolate.domains = {};    function elevate_search_results (annotate) {    var page = 1;      function mk_list_item(i) {      return $K(i).attr({\"class\": \"KOBJ_item\"}).css({\"margin\":\"5px\"});    }       function mk_rm_div (anchor) {      var separator = $K(\"<div>\");      separator.css({\"margin-top\":\"0px\",\"border-top\":\"2px solid black\",\"width\":\"100%\"});        var logo_item = mk_list_item(anchor);        var logo = $K('<img>');      logo.attr({\"src\":\"http://www.azigo.com/sales-demo/VisaLogo.jpg\",\"align\":\"left\"});      logo.css({\"margin\":\"5px\",\"height\":\"34px\"});        var logo2 = $K('<img>');      logo2.attr({\"src\":\"http://www.azigo.com/sales-demo/CapitalLogo.png\",\"align\":\"left\"});      logo2.css({\"margin\":\"5px\",\"height\":\"34px\"});          var header=$K(\"<div>\");      header.css({\"height\":\"30px\", \"margin\":\"0px 0px 0px 0px\"});      header.append(logo2);            var top_box = $K('<ol>');      top_box.css({\"display\": \"block\",\"padding-top\": \"0px\"});      top_box.attr(\"id\", \"KOBJ_top_box\");      top_box.append(logo_item);        var inner_div = $K('<div>');      inner_div.css({\"margin-top\":\"0px\",\"border-top\":\"2px solid black\",\"width\":\"100%\"});       inner_div.css({});      inner_div.append(top_box);        var rm_div = $K('<div>');      rm_div.attr({\"class\":\"cxx\"});      rm_div.css({\"border\":\"1px solid black\",\"padding-right\": \"0px\",\"min-height\": \"80px\", \"max-width\":\"48em\", \"margin\":\"10px\"});      rm_div.append(header);      rm_div.append($K('<br>'));      rm_div.append(inner_div);        return rm_div;    }        function move_item (obj) {            if($K('#KOBJ_top_box').find(\"li\").is('.KOBJ_item')) {        var separator = $K(\"<div>\");        separator.css({\"margin-top\":\"0px\"});                $K('#KOBJ_top_box').append(mk_list_item(obj));      } else {        if ($K(\"#res\").length)           $K(\"#res\").before(mk_rm_div(obj));        else if ($K(\"#web\").length)           $K(\"#web\").before(mk_rm_div(obj));        else if ($K(\"#results\").length)           $K(\"#results\").before(mk_rm_div(obj));      }    }       var q = String(top.location).replace(/^.*[\\?&][qp]=([^&]+).*$/, \"$1\");      if (q == \"shoes\" || q == \"shoe\"){  \t  move_item(annotate(\"\",1));  \t  move_item(annotate(\"\",2));  \t  move_item(annotate(\"\",3));    }    if (q == \"flower\" || q == \"flowers\"){  \t  move_item(annotate(\"\",4));  \t  move_item(annotate(\"\",5));    }  }      function abq_selector(obj, page){    function mk_anchor (o, key) {      var url_prefix = \"http://www.azigo.com/sales-demo/\";        var lnk = $K('<a href=' + o.link + '/>');      lnk.attr({\"class\": 'KOBJ_'+key,\"title\": o.name});      lnk.text(o.name);            var desc = $K('<span>' + o.text + '<\/span>');      desc.text(o.text);      desc.css({\"margin\":\"5px\",\"font-weight\":\"bold\"});        var pg = $K('<span>');      pg.text(\"Page #\"+page);      pg.css({\"margin\":\"5px\",\"color\":\"#676767\"});        var line = $K('<div>');      line.append(lnk);      line.append(desc);          line.attr({\"class\": \"KOBJ_item\"});        return $K(\"<li>\").append(line);    }      var host = page==1?\"payless.com\":page==2?\"shoes.com\":page==3?\"shoemall.com\":page==4?\"1800flowers.com\":\"proflowers.com\";    var o = KOBJ.pick(KOBJ.visa[host]);    if(o && !search_percolate.domains[host]) {       search_percolate.domains[host] = 1;       return mk_anchor(o,'abq');    } else {       return false;    }  }    elevate_search_results(abq_selector);              ",
         "foreach": [],
         "name": "google",
         "pagetype": {"event_expr": {
            "legacy": 1,
            "op": "pageview",
            "pattern": "^http://www.google.com|^http://search.yahoo.com|^http://www.bing.com",
            "type": "prim_event",
            "vars": []
         }},
         "pre": [
            {
               "lhs": "url_prefix",
               "rhs": {
                  "type": "str",
                  "val": "http://frag.kobj.net/clients/1024/images/"
               },
               "type": "expr"
            },
            {
               "lhs": "logo_url_prefix",
               "rhs": {
                  "type": "str",
                  "val": "http://www.azigo.com/sales-demo/"
               },
               "type": "expr"
            }
         ],
         "state": "active"
      },
      {
         "actions": [
            {"action": {
               "args": [
                  {
                     "type": "str",
                     "val": "<img src='http://3.static.getsatisfaction.com/uploaded_images/0275/6462/azigo-a_48px_medium.png' width='34px' height='26px' style='margin-bottom:5px'>"
                  },
                  {
                     "type": "var",
                     "val": "invite"
                  }
               ],
               "modifiers": [
                  {
                     "name": "opacity",
                     "value": {
                        "type": "num",
                        "val": 1
                     }
                  },
                  {
                     "name": "sticky",
                     "value": {
                        "type": "bool",
                        "val": "true"
                     }
                  }
               ],
               "name": "notify",
               "source": null
            }},
            {"action": {
               "args": [{
                  "type": "str",
                  "val": "span.no_thanks"
               }],
               "modifiers": null,
               "name": "close_notification",
               "source": null
            }}
         ],
         "blocktype": "every",
         "callbacks": null,
         "cond": {
            "type": "bool",
            "val": "true"
         },
         "emit": "\nfill_card = function(type) {   $K('input[name=ccard_z_number]').attr('value','4121555544444321');   $K('select[name=ccard_z_exp_month]>option[value=02]').attr('selected','selected');   $K('select[name=ccard_z_exp_year]>option[value=2011]').attr('selected','selected');    $K('#screenOne').hide();    $K('#screenTwo').hide();    $K('#screenThree').hide();    if (type=='miles')       $K('#wellDone1').show();    else       $K('#wellDone2').show();  };    show_miles = function(){    $K('#screenOne').hide();    $K('#screenTwo').show();  }  ;show_card = function(){    $K('#screenOne').hide();    $K('#screenThree').show();  }  ;noThanks = function(){    $K('#screenOne').show();    $K('#screenTwo').hide();    $K('#screenThree').hide();  };              ",
         "foreach": [],
         "name": "zappos",
         "pagetype": {"event_expr": {
            "legacy": 1,
            "op": "pageview",
            "pattern": "https://shopping.zappos.com/reqauth/checkout.cgi|https://shopping.zappos.com/r/checkout.cgi|https://secure-www.zappos.com/checkout",
            "type": "prim_event",
            "vars": []
         }},
         "pre": [{
            "lhs": "invite",
            "rhs": " \n<div id=\"kobj_discount\" style=\"padding: 3pt;    -moz-border-radius: 5px;    -webkit-border-radius: 5px;    background-color: #FFFFFF;    width: 225px;    text-align: center;    color: black;\">    <div id=\"screenOne\">    <table border=\"0\">  <tr>   <td><span style=\"color: #72BDCA; font-weight:bold;\"><\/span><\/td>   <td><img src=\"https://www.azigo.com/sales-demo/VisaLogo.jpg\" width=\"70px\"><\/td>    <\/tr>  <\/table>    <table border=\"0\" style=\"margin-top: 20px;\" >  <tr>  <td><span>Use your Visa<\/span><\/td>   <td>    <span style=\"cursor: pointer;\"><img src=\"https://www.azigo.com/sales-demo/VisaCardLogo.png\" width=\"120px\" onclick=\"fill_card();\"><\/span>   <\/td>  <\/tr>  <\/table>    <table border=\"0\" style=\"margin-top: 20px;\" >  <tr>    <td><span>Pay with points<\/span><\/td>   <td>    <span style=\"cursor: pointer; align:left;\"><img src=\"https://www.azigo.com/sales-demo/VisaCart.jpg\" width=\"100px\" onclick=\"show_miles();\"><\/span>   <\/td>  <\/tr >  <\/table>    <table border=\"0\" style=\"margin-top: 20px;\" >  <tr align=\"center\">   <td colspan=\"2\" align=\"center\">    <span class=\"no_thanks\" style=\"cursor: pointer; align:center; margin-left:17px;\"><img src=\"https://www.azigo.com/sales-demo/NoThanksButton.png\"><\/span>   <\/td>  <\/tr>  <\/table>    <\/div>              <div id=\"screenTwo\" style=\"display:none;\">  <table>  <tr style=\"margin-top: 30px;\">   <td><span style=\"color: #72BDCA; font-weight:bold\">Two ways to buy!<\/span><\/td>   <td><img src=\"https://www.azigo.com/sales-demo/VisaLogo.jpg\" width=\"70px\"><\/td>    <\/tr>  <\/table><br/>  <div style=\"align: center; \">  <img src=\"https://www.azigo.com/sales-demo/VisaCart.jpg\" width=\"100px\"><br/>  <span style=\"font-weight:bold;margin-top:3px;\">Pay with points!<\/span><br/>    <div class=\"info\" style=\"margin: 20px;\">      Balance: 150,351<br/>      Needed: 7,200<br/>    <\/div>  <span style=\"cursor: pointer; margin-left:-5px;\"><img src=\"https://www.azigo.com/sales-demo/UsePointsButton.png\" onclick=\"fill_card('miles');\" width=\"200px\"><br/>  <span style=\"cursor: pointer;\"><img src=\"https://www.azigo.com/sales-demo/GoBackButton.png\" onclick=\"noThanks();\">  <\/div>  <\/div>              <div id=\"screenThree\" style=\"display:none;\">  <table>  <tr style=\"margin-top: 30px;\">   <td><span style=\"color: #72BDCA; font-weight:bold\">Don't forget...<\/span><\/td>   <td><img src=\"https://www.azigo.com/sales-demo/VisaLogo.jpg\" width=\"80px\"><\/td>    <\/tr>  <\/table><br/>  <div style=\"align: center; margin-top:20px;\">  <span style=\"font-weight:bold;\">Use your MasyerCard now and earn even more miles!<\/span><br/>  <div style=\"margin-top: 20px;\">  <img src=\"https://www.azigo.com/sales-demo/VisaLogo.jpg\" width=\"160px\">  <\/div>  <br/>  <span style=\"font-weight:bold;\">Want to use your SkyMiles AMEX?<\/span><br/>  <div style=\"margin-top: 30px;\">  <span style=\"cursor: pointer;\"><img src=\"https://www.azigo.com/sales-demo/LetsUseItButton.png\" onclick=\"fill_card('card');\" width=\"200px\"><br/>  <span style=\"cursor: pointer;\"><img src=\"https://www.azigo.com/sales-demo/NoThanksButton.png\" onclick=\"noThanks();\">  <\/div>  <\/div>  <\/div>      <div id=\"wellDone1\" style=\"display:none; margin:15px; font-weight:bold; align: center;\">    Thank you, Jack. You've just saved $72.00 with your Visa.<br/><br/><br/>    Your confirmation number is <span style=\"color:red\">GP965J23<\/span>.<br/><br/><br/>   <span class=\"no_thanks\" style=\"cursor: pointer;\"><img src=\"https://www.azigo.com/sales-demo/CloseButton.png\">  <\/div>    <div id=\"wellDone2\" style=\"display:none; margin:15px; font-weight:bold; align: center;\">    Thank you, Jack. You've just earned 7,200 Points.<br/><br/><br/>    Your confirmation number is <span style=\"color:red\">GP592J23<\/span>.<br/><br/><br/>  <span class=\"no_thanks\" style=\"cursor: pointer;\"><img src=\"https://www.azigo.com/sales-demo/CloseButton.png\">  <\/div>      <\/p>  <\/div>     \n ",
            "type": "here_doc"
         }],
         "state": "active"
      }
   ],
   "ruleset_name": "a58x20"
}