$(document).ready(function () {
  $("ul.nav.nav-pills li a").click(function () {
    window.location.hash = $(this).attr("href");
  });

  $("#cool").on("submit", function (evt) {
    evt.preventDefault();
    var request = $(this).serialize();
    $("#cool-spiner").show();
    $.post("/coolc", request, function (data) {
      $("#cool-spiner").hide();
      $("#result").show().html(data.result);
    });
  });

  if (window.location.hash) {
    $("[href='%s']".replace("%s", window.location.hash)).trigger("click");
  }

  var text =
    "st=>start: Highlevel language (i.e. Cool)\n" +
    "e=>end: Assembly code\n" +
    "lex=>operation: Lexical Analyzer (Lexer)\n" +
    "yacc=>operation: Syntax Analyzer (Parser)\n" +
    "semant=>operation: Semantic Analyzer (Semant)\n" +
    "codegen=>operation: Code Generation\n" +
    "optgen=>inputoutput: Optimize Code Generation\n" +
    "\n" +
    "cond=>condition: Optimize ?\n" +
    "st(right)->lex(bottom)->yacc(right)->semant(bottom)->codegen(bottom)->cond(bottom)->e\n" +
    "cond(no,bottom)->e\n" +
    "cond(yes)->optgen\n" +
    "optgen->e";

  var diagram = flowchart.parse(text);
  diagram.drawSVG("diagram");
});
