$(document).ready(function () {
  var self = {};

  $("ul.nav.nav-pills li a").click(function () {
    window.location.hash = $(this).attr("href");
  });

  $("#cool").on("submit", function (evt) {
    evt.preventDefault();
    var request = {
      code: self.editor.getValue()
    };
    var submitButton = $(this).find(':submit');

    self.editor.updateOptions({ readOnly: true });
    submitButton.prop('disabled', true);
    $("#cool-spiner").show();

    $.post("/coolc", request, function (data) {
      $("#cool-spiner").hide();
      
      submitButton.prop('disabled', false);
      self.editor.updateOptions({ readOnly: false });

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

  const defaultCoolCode = 'class Main() extends IO() {\n' +
  '  {\n' +
  '    out_any("hello world\\n")\n' +
  '  };\n' +
  '}';

  require.config({ paths: { 'vs': 'https://cdn.jsdelivr.net/npm/monaco-editor@0.45.0/min/vs' }});
  require(['vs/editor/editor.main'], function() {
      self.editor = monaco.editor.create(document.getElementById('container'), {
          value: defaultCoolCode,
          language: 'scala'
      });
  });  
});