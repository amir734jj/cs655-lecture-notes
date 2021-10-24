var glob = require("glob");
var cp = require("child_process");

glob("lab*/*.marp.md", {}, function (err, files) {
  files.forEach((file) => {
    var destination = file.replace(".md", "");
    var cmd = `marp ${file} --allow-local-files --pdf -o ${destination}.pdf`;
    var result = cp.execSync(cmd);
    console.log(result.toString());
  });
});
