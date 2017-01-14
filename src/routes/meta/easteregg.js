'use strict'
var express = require('express');
var router = express.Router();
var cowsay = require("cowsay");

var easteregg = function(req, res){
    var cowsayResponse = cowsay.say({
        text : "You found me... now try to use a word.. ex: easteregg/javascript",
        e : "oO",
        T : "U "
    });
    res.set('Content-Type', 'text/plain');
    res.send(cowsayResponse)
};

router.get('/', easteregg);

module.exports = router;
