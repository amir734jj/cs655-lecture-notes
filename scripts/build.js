var glob = require("glob");
var execa = require("execa");
var path = require("path");

path.existsSync(process.env.GOOGLE_CHROME_BIN, function (exists) {
  console.log(`${process.env.GOOGLE_CHROME_BIN}: exists? ${exists}`);
});

glob("lab*/*.marp.md", {}, function (err, files) {
  files.forEach((file) => {
    var destination = file.replace(".md", "");
    var cmd = `marp ${file} --allow-local-files --pdf -o ${destination}.pdf`;
    var result = execa.commandSync(cmd, {
      ...process.env,
      CHROME_PATH: process.env.GOOGLE_CHROME_BIN,
    });
    console.log(`[${result.failed ? "failed" : "success"}] ${result.command}`);
  });
});
