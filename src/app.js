var express = require('express');
var app = express();
var glob = require('glob');
var _ = require('lodash');
var path = require('path');
var awsServerlessExpressMiddleware = require('aws-serverless-express/middleware');
var apputil = require('./util/util.js');

app.use(awsServerlessExpressMiddleware.eventContext());
// map routes with file names and load all router files
glob.sync('src/routes/**/*.js').forEach(function(router){
    var routeString = '/api/' + path.basename(router, '.js');
    app.use(routeString, require(process.cwd() + '/' + router));
});

app.listen(3000, function() {
    console.log('Listening on port 3000...')
})
// this is for aws lambda
module.exports = app;