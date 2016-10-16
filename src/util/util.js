var _ = require('lodash');
var glob = require('glob');
var path = require('path');
// to folders up to root
var _root = path.resolve(__dirname, '../..');
/**
 * A helper to glob files - the glob pattern always matches from roo not from the folder it is running against
 * 
 * @param globPatterns
 * @param removeRoot
 * @returns {Array}
 */
// module.exports.resolveFilesSync = function(glob){
//
// };