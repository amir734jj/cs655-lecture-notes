var glob = require("glob")
var fs = require('fs');

glob("src/lab*/*.marp.pdf", { }, function (err, files) {
  files.forEach(file => {
    fs.unlinkSync(file);
  })
});
