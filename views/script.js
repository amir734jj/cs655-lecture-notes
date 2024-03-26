$(document).ready(function () {
  var self = {};

  $("[data-enabled-since]").each(function() {
    var enabledSince = new Date($(this).data("enabledSince"));

    if ((new Date() < enabledSince)) {
      $(this).hide();
    }
  });

  $("ul.nav.nav-pills li a").click(function () {
    window.location.hash = $(this).attr("href");
  });

  const toggleEnableButtons = (enable) => {
    $("#cool #format").prop('disabled', enable);
    $("#cool #run").prop('disabled', enable);
  };

  const toggleEnableSpinner = (enable) => {
    if (enable) {
      $("#cool-spiner").show();
    } else {
      $("#cool-spiner").hide();
    }
  };

  $("#cool #run").on("click", function () {
    var request = {
      code: self.editor.getValue()
    };

    self.editor.updateOptions({ readOnly: true });
    toggleEnableButtons(true);
    toggleEnableSpinner(true);

    $.post("/coolc", request, function (data) {
      toggleEnableSpinner(false);
      toggleEnableButtons(false);

      self.editor.updateOptions({ readOnly: false });
      $("#result").show().html(data.result);
    });
  });

  $("#cool #format").on("click", function () {
    var request = {
      code: self.editor.getValue()
    };

    self.editor.updateOptions({ readOnly: true });
    toggleEnableButtons(true);
    toggleEnableSpinner(true);

    $.post("/format", request, function (data) {
      toggleEnableSpinner(false);
      toggleEnableButtons(false);

      self.editor.updateOptions({ readOnly: false });
      self.editor.setValue(data.result);
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
      self.timer = setInterval(function() {
        if ($("#editor-container").is(":visible")) {
          self.editor = monaco.editor.create(document.getElementById('editor-container'), {
            value: defaultCoolCode,
            language: 'scala'
          });


          clearInterval(self.timer);
        }
      }, 100);
  });

  $('.lazyload').lazyload({
    threshold: 200,
    load: function(element) {},
    trigger: "appear"
  });
});