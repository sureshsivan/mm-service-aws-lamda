'use strict'
var express = require('express');
var router = express.Router();

var ping = function(req, res){
    res.send("pong");
};

router.get('/', ping);

module.exports = router;
