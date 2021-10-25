$(document).ready(function () {
  $("ul.nav.nav-pills li a").click(function () {
    window.location.hash = $(this).attr("href");
  });

  if (window.location.hash) {
    $("[href='%s']".replace("%s", window.location.hash)).trigger("click");
  }
});
