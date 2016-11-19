const md5File = require('md5-file');
const glob = require('glob');
const fs = require('fs');

glob.sync("dist/*.*").forEach(function(filepath){
    const checksum = md5File.sync(filepath);
    const newFileName = filepath.substr(0, filepath.lastIndexOf(".")) + "." + checksum + filepath.substr(filepath.lastIndexOf("."));
    fs.renameSync(filepath, newFileName);
});