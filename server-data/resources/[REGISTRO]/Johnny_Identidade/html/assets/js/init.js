// Variável global para armazenar o valor de fakeid
var fakeId = false;

$(document).ready(function(){
	$('select').formSelect();

	// Date of birth picker
	$('#dateofbirth').val('01-01-1990');
	$('.datepicker').datepicker({
		defaultDate : new Date(1, 0, 1990),
		setDefaultDate : true,
		yearRange: 100,
		format : 'dd-mm-yyyy',
		i18n : {
			cancel: 'Cancelar',
			done: 'OK',
			clear: 'Limpar',
			months: [ 'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro' ],
			monthsShort: [ 'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez' ],
			weekdays: [ 'Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado' ],
			weekdaysShort: [ 'Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sab' ],
			weekdaysLetter: [ 'D', 'S', 'T', 'Q', 'Q', 'S', 'S' ],
		},
	});

	// LUA event listener
	window.addEventListener('message', function(event) {
		if (event.data.action == 'open') {
			$('#wrapper').show();
		} else if (event.data.action == 'close') {
			$('#wrapper').hide();
		} else if (event.data.action == 'fakeid') {
			fakeId = true;
			$('#wrapper').show();
		}
	});
});

// Register button
$('#register').click(function() {
	if ($('#lastname').val() != '' && $('#firstname').val() != '' && $('#dateofbirth').val() != '' && $('#sex select').val() != null && $('#height').val() != '') {
		if ($('#height').val().length > 1 && $('#dateofbirth').val().length == 10) {
			var dob = $('#dateofbirth').val();

			$.post('http://Johnny_Identidade/register', JSON.stringify({
			  firstname: $("#firstname").val(),
			  lastname: $("#lastname").val(),
			  dateofbirth: $("#dateofbirth").val(),
			  sex: $("#sex select").val(),
			  height: $("#height").val(),
			  fakeid: fakeId
			}));
		}
	}
});

// Disable space on the input
$("form").on({
  keydown: function(e) {
	if (e.which === 32)
	  return false;
  },
});

// Disable form submit
$("form").submit(function() {
	return false;
});
