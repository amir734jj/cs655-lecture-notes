var glob = require("glob");
var execa = require("execa");
var fs = require("fs");

console.log(
  `${process.env.GOOGLE_CHROME_SHIM}: exists? ${fs.existsSync(
    process.env.GOOGLE_CHROME_SHIM
  )}`
);

console.log(JSON.stringify(process.env));

glob("lab*/*.marp.md", {}, function (err, files) {
  files.forEach((file) => {
    var destination = file.replace(".md", "");
    var cmd = `marp ${file} --allow-local-files --pdf -o ${destination}.pdf`;
    var result = execa.commandSync(cmd, {
      ...process.env,
      CHROME_PATH:
        process.env.GOOGLE_CHROME_BIN || "/app/.apt/opt/google/chrome/chrome",
    });
    console.log(`[${result.failed ? "failed" : "success"}] ${result.command}`);
  });
});
