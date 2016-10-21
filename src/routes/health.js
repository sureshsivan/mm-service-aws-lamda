'use strict'
var express = require('express');
var router = express.Router();

var healthCheckFn = function(req, res){
    res.send("i am healthy as devil - sarooosdfnvlkisdjfb56476547654vnkdsjfbk!!! ");
};

router.get('/', healthCheckFn);
router.get('/healthcheck', healthCheckFn);
router.get('/pulse', healthCheckFn);
router.get('/heartbeat', healthCheckFn);

module.exports = router;
