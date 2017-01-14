'use strict'
var express = require('express');
var router = express.Router();

var ping = function(req, res){
    res.send("pong");
};

router.get('/ping', healthCheckFn);
router.get('/healthcheck', healthCheckFn);
router.get('/pulse', healthCheckFn);
router.get('/heartbeat', healthCheckFn);

module.exports = router;
