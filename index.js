var express = require("express");
var path = require("path");
var fs = require("fs");
var glob = require("glob");
var MarkdownIt = require("markdown-it");
var hljs = require("highlight.js");
var bodyParser = require("body-parser");
const { exec } = require('child_process');

// Start date of the semester
var startTime = new Date('2024-01-18T10:00:00Z');

var app = express();

var port = process.env.PORT || 3000;

var md = new MarkdownIt({
  highlight: function (str, lang) {
    if (lang && hljs.getLanguage(lang)) {
      try {
        return hljs.highlight(str, { language: lang }).value;
      } catch (__) { }
    }

    return ""; // use external default escaping
  },
});

var labs = {};

glob("src/lab*/manifest.json", {}, function (err, files) {
  files.forEach((file) => {
    const labPath = file.split("/").slice(0, -1).join("/");
    const labName = labPath.split("/").slice(-1).pop();
    const index = parseInt(labName.match(new RegExp("lab(\\d+)"))[1]);

    var manifest = JSON.parse(fs.readFileSync(file), {
      encoding: "utf8",
    });

    var markdown = fs
      .readFileSync(path.join(labPath, "note.marp.md"))
      .toString();

    // Calculate the target time by adding n * 7 days to the start time
    var targetTime = new Date(startTime.getTime() + index * 7 * 24 * 60 * 60 * 1000);

    labs[labName] = {
      enabledSince: targetTime,
      md: md.render(markdown),
      pdf: path.join(labPath.replace('src/', ''), "note.marp.pdf"),
      video: manifest.video
    };
  });
});

app.use(express.static("src"));
app.use("/public", express.static("public"));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.set("view engine", "pug");

app.get("/", (req, res) => {
  res.render("index", { labs });
});

app.post("/coolc", (req, res) => {
  const command = `echo '${req.body.code}' > temp.cool && coolc temp.cool && coolspim temp.s`;

  exec(command, (_, stdout, stderr) => {
    res.json({ result: `${stdout}\n${stderr}`.trim(), code: req.body.code });
  });
});

app.post("/format", (req, res) => {
  const PA4jar = '/usr/local/lib/PA4.jar';
  const command = `echo '${req.body.code}' > temp.cool && coolc -P p temp.cool > temp.in && scalac -nowarn -cp .:${PA4jar} PrettyPrinter.scala && scala -cp .:${PA4jar} Main < temp.in`;

  exec(command, (_, stdout, stderr) => {
    res.json({ result: `${stdout}\n${stderr}`.trim(), code: req.body.code });
  });
});

app.listen(port, () => console.log(`app listening on port ${port}!`));
