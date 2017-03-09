'use strict'
var express = require('express');
var router = express.Router();

var printEnv = function(req, res){
    res.send(JSON.stringify(process.env));
};

router.get('/', printEnv);
router.get('/all', printEnv);

module.exports = router;
