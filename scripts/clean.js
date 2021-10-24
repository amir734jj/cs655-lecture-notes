var glob = require("glob")
var fs = require('fs');

glob("lab*/*.marp.pdf", { }, function (err, files) {
  files.forEach(file => {
    fs.unlinkSync(file);
  })
});
