$(document).ready(function(){
  var entityMap = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#39;',
    '/': '&#x2F;',
    '`': '&#x60;',
    '=': '&#x3D;'
  };

  function escapeHtml (string) {
    return String(string).replace(/[&<>"'`=\/]/g, function (s) {
      return entityMap[s];
    });
  }

  function replaceEnterToPost(text){
    return text.replace(/(\r\n|\n|\r)/gm,"[p]");
  }
  function replaceEnterToshow(text){
    return text.replace("[p]","\n");
  }

  $(".btnDrop").click(function(){
      $.post('http://qs-notepad/drop', JSON.stringify({ noteText: replaceEnterToPost(escapeHtml($("#notepadInfof").val())) }));
  });

  window.addEventListener('message', function(event){
    var item = event.data;

    if(item.openSection == "openNotepadRead") {
      text = replaceEnterToshow(item.TextRead)
      $(".notepad-container").fadeIn(300); 
      $("#Ticket-form-Jail").css("display", "none");
      $("#Ticket-form-JailRead").fadeIn(300);
      while (text.includes("[p]") == true) {
        text = replaceEnterToshow(text)
      }
      $("#notepadInfofRead").val(text);
    }

    if(item.openSection == "openNotepad") {
      $(".notepad-container").fadeIn(300); 
      $("#Ticket-form-JailRead").css("display", "none");
      $("#Ticket-form-Jail").fadeIn(300); 
    }

    if(item.openSection == "close") {
      $(".notepad-container").fadeOut(300)
    }
  });

  document.onkeyup = function (data) {
    if ( data.which == 27 ) {
      $.post('http://qs-notepad/close', JSON.stringify({}));
    }
  };
});
