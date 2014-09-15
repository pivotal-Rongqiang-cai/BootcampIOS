//
//  Action.js
//
//  Created by Joshua Kendall on 6/14/14.
//  Copyright (c) 2014 Simple App Group, LLC. All rights reserved.
//
var Action = function() {};

Action.prototype = {

run: function(arguments) {
    var selected = "No Text Selected";
    if (window.getSelection) {
        selected = window.getSelection().getRangeAt(0).toString();
    } else {
        selected = document.getSelection().getRangeAt(0).toString();
    }
    arguments.completionFunction({"selectedText" : selected});
},

finalize: function(arguments) {
    if(arguments["message"] != "noTextSelected"){
        alert(arguments["message"])
    }
}
    
};

var ExtensionPreprocessingJS = new Action