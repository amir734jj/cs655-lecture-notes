var express = require("express");
var path = require("path");
var fs = require("fs");
var glob = require("glob");
var MarkdownIt = require("markdown-it");
var hljs = require("highlight.js");

var app = express();

var port = process.env.PORT || 3000;

var md = new MarkdownIt({
  highlight: function (str, lang) {
    if (lang && hljs.getLanguage(lang)) {
      try {
        return hljs.highlight(str, { language: lang }).value;
      } catch (__) {}
    }

    return ""; // use external default escaping
  },
});

var labs = {};

glob("src/lab*/manifest.json", {}, function (err, files) {
  files.forEach((file) => {
    var labPath = file.split("/").slice(0, -1).join("/");
    var labName = labPath.split("/").slice(-1).pop();

    var manifest = JSON.parse(fs.readFileSync(file), {
      encoding: "utf8",
    });

    var markdown = fs
      .readFileSync(path.join(labPath, "note.marp.md"))
      .toString();

    labs[labName] = {
      md: md.render(markdown),
      pdf: path.join(labPath.replace('src/', ''), "note.marp.pdf"),
      video: manifest.video,
      enabled: process.env.NODE_ENV === "production" ? manifest.enabled : true,
    };
  });
});

app.use(express.static("src"));
app.use("/public", express.static("public"));

app.set("view engine", "pug");

app.get("/", (req, res) => {
  res.render("index", { labs });
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`));
