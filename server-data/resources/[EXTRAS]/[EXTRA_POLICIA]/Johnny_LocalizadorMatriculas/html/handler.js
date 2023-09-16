$(function() {
  window.onload = e => {
    window.addEventListener("message", event => {
      var item = event.data;
      if (item !== undefined && item.type === "ui") {
        if (item.display === true) {
          $("#track-container").fadeIn();
        } else {
          $("#track-container").fadeOut();
          $(".tracker-search-input").text("");
          $(".tracker-plate-search").hide();
          $(".tracker-plate-error").hide();
          $(".tracker-plate-max").hide();
        }
      }

      if (event.data.type == "noPlate") {
        $(".tracker-plate-search").hide();
        $(".tracker-plate-max").hide();
        $(".tracker-plate-error").show();
        $(".tracker-search-input").text("");
      }

      if (event.data.type == "maxPlate") {
        $(".tracker-plate-search").hide();
        $(".tracker-plate-error").hide();
        $(".tracker-plate-max").show();
        $(".tracker-search-input").text("");
      }
    });
  };

  $(document).keyup(function(e) {
    if (e.keyCode == 27) {
      closeMenu();
    }
  });

  function closeMenu() {
    $.post("https://Johnny_LocalizadorMatriculas/close");

    $("#track-container").fadeOut();
    $(".tracker-search-input").text("");
    $(".tracker-plate-search").hide();
    $(".tracker-plate-error").hide();
  }

  $(".tracker-button-save").click(function() {
    $.post(
      "https://Johnny_LocalizadorMatriculas/searchPlate",
      JSON.stringify({
        plate: $(".tracker-search-input")
          .val()
          .toUpperCase()
      })
    );

    $(".tracker-plate-search").show();
  });

  $(".tracker-button-cancel").click(function() {
    closeMenu();
  });

  $(".tracker-button-remove").click(function() {
    $.post(
      "https://Johnny_LocalizadorMatriculas/removeSearch",
      JSON.stringify({
        plate: $(".tracker-search-input")
          .val()
          .toUpperCase()
      })
    );
  });
});
