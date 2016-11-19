'use strict'
var express = require('express');
var router = express.Router();

var healthCheckFn = function(req, res){
    res.send("i am healthy as devil - domain test with api gateway through travis CI");
};

router.get('/', healthCheckFn);
router.get('/healthcheck', healthCheckFn);
router.get('/pulse', healthCheckFn);
router.get('/heartbeat', healthCheckFn);

module.exports = router;
