var AdmZip = require('adm-zip');
var glob = require('glob');
var fs = require('fs');
var zip = new AdmZip();
var archiver = require('archiver');

var prepareLambdaZip = function(){
    if (!fs.existsSync('dist')){
        fs.mkdirSync('dist');
    }
    var output = fs.createWriteStream('dist/lambda.zip');
    var archive = archiver.create('zip',{});
    output.on('close', function () {
        console.log(archive.pointer() + ' total bytes');
        console.log('archiver has been finalized and the output file descriptor has closed.');
    });
    archive.on('error', function(err){
        throw err;
    });
    // externalize it
    archive.directory("src", "src");
    archive.directory("node_modules", "node_modules");
    archive.file("package.json");
    archive.pipe(output);
    archive.finalize();
};
prepareLambdaZip();


