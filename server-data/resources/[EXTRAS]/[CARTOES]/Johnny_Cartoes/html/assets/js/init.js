$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.action == 'open') {
	  $('#numero_cc').text('');
	  $('#nome').text('');
	  $('#nome2').text('');
	  $('#apelido').text('');
	  $('#apelido2').text('');
      $('#dob').text('');
      $('#dob2').text('');
      $('#dob3').text('');
      $('#height').text('');
      $('#height2').text('');
      $('#signature').hide();
	  $('#signature2').hide();
      $('#sex').text('');
      $('#sex2').text('');
      $('#id-card').hide();
      $('#licenses').html('');
	  $('#img').hide();
	  $('#img2').hide();
      var type        = event.data.type;
      var userData    = event.data.array['user'][0];
      var licenseData = event.data.array['licenses'];
      var sex         = userData.sex;
	
      if ( type == 'driver' || type == null || type == undefined) {
		
		if ( type == 'driver') {
			$('#img').show();
			if ( sex.toLowerCase() == 'm' ) {
				$('#img').attr('src', 'assets/images/male.png');
				$('#sex').text('M');
			} else {
				$('#img').attr('src', 'assets/images/female.png');
				$('#sex').text('F');
			}
			$('#nome').text(userData.firstname + ' ' + userData.lastname);
			$('#dob').text(userData.dateofbirth);
			$('#height').text(userData.height);
			$('#signature').show();
			$('#signature').text(userData.firstname + ' ' + userData.lastname);
			$('#img').show();
			$('#nome2').hide();
			$('#apelido2').hide();
			$('#numerocc').hide();
			$('#dob2').hide();
			$('#dob3').hide();
			$('#sex2').hide();
			$('#height2').hide();
			$('#dob').show();
			$('#height').show();
			$('#sex').show();
			$('#nome').show();
			$('#apelido').show();
			$('#signature2').hide();
			
			if ( licenseData != null ) {
				Object.keys(licenseData).forEach(function(key) {
					var type = licenseData[key].type;

					if ( type == 'drive_bike') {
						type = 'Motociclos';
					} else if ( type == 'drive_truck' ) {
						type = 'Camião';
					} else if ( type == 'drive' ) {
						type = 'Automóvel';
					}

					if ( type == 'Motociclos' || type == 'Camião' || type == 'Automóvel' ) {
						$('#licenses').append('<p>'+ type +'</p>');
					}
				});
			}

			$('#id-card').css('background', 'url(assets/images/license.png)');
        } else {
			$('#img2').show();
			$('#nome').hide();
			$('#apelido').hide();
			$('#numerocc').show();
			$('#nome2').show();
			$('#apelido2').show();
			$('#dob2').show();
			$('#dob3').hide();
			$('#sex2').show();
			$('#height2').show();
			$('#dob').hide();
			$('#height').hide();
			$('#sex').hide();
			$('#signature').hide();
			if ( sex.toLowerCase() == 'm' ) {
				$('#img2').attr('src', 'assets/images/male2.png');
				$('#sex2').text('M');
			} else {
				$('#img2').attr('src', 'assets/images/female2.png');
				$('#sex2').text('F');
			}
			$('#nome2').text(userData.firstname);
			$('#apelido2').text(userData.lastname);
			$('#dob2').text(userData.dateofbirth);
			$('#height2').text(userData.height);
			$('#signature2').show();
			$('#signature2').text(userData.firstname + ' ' + userData.lastname);
			$('#numerocc').text(userData.numero_cc);
			
			$('#id-card').css('background', 'url(assets/images/idcard.png)');
        }
		$('#id-card').show();
      } else if ( type == 'weapon' ) {
        $('#img').hide();
        $('#img2').hide();
		$('#nome').show();
		$('#apelido').hide();
		$('#numerocc').hide();
		$('#nome2').hide();
		$('#apelido2').hide();
		$('#dob2').hide();
		$('#dob3').show();
		$('#sex2').hide();
		$('#height2').hide();
		$('#dob').hide();
		$('#height').hide();
		$('#sex').hide();
		$('#signature2').hide();
		$('#signature').show();
        $('#nome').text(userData.firstname + ' ' + userData.lastname);
        $('#dob3').text(userData.dateofbirth);
        $('#signature').text(userData.firstname + ' ' + userData.lastname);

        $('#id-card').css('background', 'url(assets/images/firearm.png)');

		$('#id-card').show();
	 } else if ( type == 'hunt' ) {
        $('#img').hide();
        $('#img2').hide();
		$('#nome').show();
		$('#apelido').hide();
		$('#numerocc').hide();
		$('#nome2').hide();
		$('#apelido2').hide();
		$('#dob2').hide();
		$('#sex2').hide();
		$('#height2').hide();
		$('#dob').hide();
		$('#dob3').show();
		$('#height').hide();
		$('#sex').hide();
		$('#signature2').hide();
		$('#signature').show();
        $('#nome').text(userData.firstname + ' ' + userData.lastname);
        $('#dob3').text(userData.dateofbirth);
        $('#signature').text(userData.firstname + ' ' + userData.lastname);

        $('#id-card').css('background', 'url(assets/images/licenca_caca.png)');
		
      }

      $('#id-card').show();
    } else if (event.data.action == 'close') {
      $('#nome').text('');
      $('#dob').text('');
      $('#height').text('');
      $('#signature').text('');
      $('#sex').text('');
      $('#id-card').hide();
      $('#licenses').html('');
	  $('#numero_cc').text('');
    }
  });
});
