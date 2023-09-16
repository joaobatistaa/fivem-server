$(document).ready(function(){
  window.addEventListener('message', function(event) {
      if (event.data.action == 'open') {
        $('#wrapper').show();
      } else if (event.data.action == 'close') {
        $('#wrapper').hide();
      } else if (event.data.action == 'callback') {
        if (event.data.array == 'upload-fail') {
          $('#upload h1').text('Não têns ADN..');
          $('.progress').hide();
        } else if (event.data.array == 'upload-success') {
          var txt;
          if (event.data.atype == 'murder') {
            txt = 'Fizeste o upload do ADN com ID: ' + event.data.value;
          } else {
            txt = 'Fizeste o uploado do ADN de ' + event.data.value;
          }
		  setTimeout(function(){
			  $('#upload h1').text('Feito!');
			  $('.progress').hide();
			  $('.upload-success').text(txt);
		   }, 3000);
        } else if (event.data.array == 'upload-failed') {
          var txt;
          if (event.data.atype == 'murder') {
            txt = 'O ADN com ID: ' + event.data.value + ' já está no sistema';
          } else {
            txt = 'O ADN de ' + event.data.value + ' já está no sistema';
          }
		  setTimeout(function(){
            $('#upload h1').text(txt);
            $('.progress').hide();
          }, 3000);
        } else if (event.data.array == 'match-fail') {
          $('#match-message').css('background', '#ae0e00');
          $('#match-message').text('Sem resultados..').slideDown().show();
          setTimeout(function(){
            $('#match-message').slideUp();
          }, 3000);
        } else if (event.data.array == 'match-exists') {
          $('#match-message').css('background', '#ae0e00');
          $('#match-message').text("Já existe uma correspondência..").slideDown().show();
          setTimeout(function(){
            $('#match-message').slideUp();
          }, 3000);
        } else if (event.data.array == 'match-success') {
          $('#match-message').css('background', '#00ae22');
          $('#match-message').text('Correspondência encontrada! A enviar relatório..').slideDown().show();
          setTimeout(function(){
            $('#match-message').slideUp();
          }, 3000);
        } else if (event.data.array == 'search-fail') {
          $('#match-message').css('background', '#ae0e00');
          $('#match-message').text("Não foi encontrado esse ID na base de dados.").slideDown().show();
          setTimeout(function(){
            $('#match-message').slideUp();
          }, 3000);
        } else if (event.data.array == 'remove-success') {
          $('#remove-message').css('background', '#00ae22');
          $('#remove-message').text('ADN removido!').slideDown().show();
          setTimeout(function(){
            $('#remove-message').slideUp();
          }, 3000);
        } else if (event.data.array == 'remove-fail') {
          $('#remove-message').css('background', '#ae0e00');
          $('#remove-message').text("Não foi possível encontrar o ADN..").slideDown().show();
          setTimeout(function(){
            $('#remove-message').slideUp();
          }, 3000);
        }
      } else if (event.data.action == 'murder') {
        if (event.data.array.pk != 'tomt') {
          for (var i = 0; i < event.data.array.length; i++) {
            $('#brottsplatser ul').append('<li><img src="assets/images/dna.png"/><p class="id">'+event.data.array[i].pk+'</p><p>Upload por:</p><p>'+event.data.array[i].uploader+'</p><p>'+event.data.array[i].datum+'</p></li>');
          }
        } else {
          $('#database h1').text('Não foram encontrados resultados...');
        }
      } else if (event.data.action == 'prov') {
        if (event.data.array.pk != 'tomt') {
          for (var i = 0; i < event.data.array.length; i++) {
            $('#personer ul').append('<li><img src="assets/images/dna.png"/><p class="id">'+event.data.array[i].killer+'</p><p>Upload por:</p><p>'+event.data.array[i].uploader+'</p><p>'+event.data.array[i].datum+'</p></li>');
          }
        } else {
          $('#database h1').text('Não foram encontrados resultados...');
        }
      } else if (event.data.action == 'match') {
        if (event.data.array.pk != 'tomt') {
          for (var i = 0; i < event.data.array.length; i++) {
            $('#lab ul').append('<li><img src="assets/images/dna.png"/><p class="id">'+event.data.array[i].pk+'</p><p>Encontrados vestígios de:</p><p>'+event.data.array[i].killer+'</p></li>');
          }
          $('#lab h1').text('Resultado Laboratório');
        } else {
          $('#lab h1').text('Não foram encontrados resultados...');
        }
      }
  });

function resetAll() {
  $('#database h1').text('Base de Dados');
  $('#upload h1').text('A carregar...');
  $('.upload-success').text('');
  $('.progress').show();
  $('#upload').hide();
  $('#match').hide();
  $('#match-message').hide();
  $('#remove').hide();
  $('#remove-password').val('');
  $('#remove-id').val('');
  $('#remove-message').hide();
  $('#lab').hide();
  $('#database').hide();
  $('#brottsplatser').hide();
  $('#personer').hide();
  $('#brottsplatser ul').html('');
  $('#personer ul').html('');
  $('#lab ul').html('');
  $('#match-input').val('');
  $('#home').show();
}

$('.btn-back').click(function(){
  resetAll()
});
  $('#btn-upload').click(function() {
    $('#home').hide();
    $('#upload').show();
    $.post('http://Johnny_DNA/upload', JSON.stringify({}));
  });

  $('#btn-match').click(function() {
    $('#home').hide();
    $('#match').show();
  });

  $('#btn-remove').click(function() {
    $('#home').hide();
    $('#remove').show();
  });

  $('#btn-remove-go').click(function() {
    if ($('#remove-password').val() == 'worldtuga2021') {
      if ($('#remove-id').val() != '') {
        if (parseInt($('#remove-id').val())) {
          if ($('#remove-id').val().includes("#m")) {
            $.post('http://Johnny_DNA/remove', JSON.stringify({match: $('#remove-id').val()}));
          } else {
            $.post('http://Johnny_DNA/remove', JSON.stringify({id: $('#remove-id').val()}));
          }
        } else {
          $.post('http://Johnny_DNA/remove', JSON.stringify({name: $('#remove-id').val()}));
        }
      }
    } else {
      $('#remove-message').css('background', '#ae0e00');
      $('#remove-message').text('Password errada!').slideDown().show();
      setTimeout(function(){
        $('#remove-message').slideUp();
      }, 3000);
    }
  });

  $('#btn-match-go').click(function() {
    if ($('#match-input').val() != '') {
      $.post('http://Johnny_DNA/match', JSON.stringify({id: $('#match-input').val()}));
    }
  });

  $('#btn-lab').click(function() {
    $('#home').hide();
    $.post('http://Johnny_DNA/fetch', JSON.stringify({type: "match"}));
    $('#lab').show();
  });

  $('#btn-brottsplatser').click(function() {
    $('#home').hide();
    $.post('http://Johnny_DNA/fetch', JSON.stringify({type: "murder"}));
    $('#database h1').text('Base de Dados - Cenas de Crimes');
    $('#database').show();
    $('#brottsplatser').show();
  });

  $('#btn-personer').click(function() {
    $('#home').hide();
    $.post('http://Johnny_DNA/fetch', JSON.stringify({type: "prov"}));
    $('#database h1').text('Base de Dados - Pessoas');
    $('#database').show();
    $('#personer').show();
  });

  $(document).keyup(function(e) {
     if (e.keyCode == 27) {
       $('#wrapper').hide();
       resetAll()
       $.post('http://Johnny_DNA/escape', JSON.stringify({}));
    }
  });
});
