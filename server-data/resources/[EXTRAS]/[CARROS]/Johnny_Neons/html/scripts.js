function OpenUi() {
	$("main").css("display", "block");
	$("body").css("display", "block");
}


window.addEventListener('message', function (event) {

	var item = event.data;
	
	if (item.message == "showui") {
		$('#main').show();
		OpenUi();
	}

	if (item.message == "hideui") {
		$('#main').hide();
		$('#colors').hide();
		$('#anims').hide();
		$('#settings').hide();
		OpenUi();
	}	
  
  if (item.message == "sneon1ON") {
    document.getElementById("s-neon1").checked = true;
  } 

  if (item.message == "sneon2ON") {
    document.getElementById("s-neon2").checked = true;
  } 

  if (item.message == "sneon3ON") {
    document.getElementById("s-neon3").checked = true;
  } 

  if (item.message == "sneon4ON") {
    document.getElementById("s-neon4").checked = true;
  } 

  if (item.message == "sallneonsON") {
    document.getElementById("s-allneons").checked = true;
  } 

  if (item.message == "animspeed1ON") {
    document.getElementById("s-aspeed1").checked = true;
    $.post('http://Johnny_Neons/aspeed1ON', JSON.stringify({}));
    document.getElementById("s-aspeed2").checked = false;
    document.getElementById("s-aspeed3").checked = false;
  } 

  if (item.message == "animspeed2ON") {
    document.getElementById("s-aspeed2").checked = true;
    $.post('http://Johnny_Neons/aspeed2ON', JSON.stringify({}));
    document.getElementById("s-aspeed1").checked = false;
    document.getElementById("s-aspeed3").checked = false;
  } 

  if (item.message == "animspeed3ON") {
    document.getElementById("s-aspeed3").checked = true;
    $.post('http://Johnny_Neons/aspeed3ON', JSON.stringify({}));
    document.getElementById("s-aspeed1").checked = false;
    document.getElementById("s-aspeed2").checked = false;
  } 

  if (item.message == "animspeedallOFF") {
    document.getElementById("s-aspeed3").checked = false;
    document.getElementById("s-aspeed1").checked = false;
    document.getElementById("s-aspeed2").checked = false;
  } 

  if (item.message == "rgbspeed1ON") {
    document.getElementById("s-rgbspeed1").checked = true;
    $.post('http://Johnny_Neons/rgbspeed1ON', JSON.stringify({}));
    document.getElementById("s-rgbspeed2").checked = false;
    document.getElementById("s-rgbspeed3").checked = false;
  } 

  if (item.message == "rgbspeed2ON") {
    document.getElementById("s-rgbspeed2").checked = true;
    $.post('http://Johnny_Neons/rgbspee2ON', JSON.stringify({}));
    document.getElementById("s-rgbspeed1").checked = false;
    document.getElementById("s-rgbspeed3").checked = false;
  } 

  if (item.message == "rgbspeed3ON") {
    document.getElementById("s-rgbspeed3").checked = true;
    $.post('http://Johnny_Neons/rgbspee3ON', JSON.stringify({}));
    document.getElementById("s-rgbspeed1").checked = false;
    document.getElementById("s-rgbspeed2").checked = false;
  } 

  if (item.message == "rgbspeedallOFF") {
    document.getElementById("s-rgbspeed1").checked = false;
    document.getElementById("s-rgbspeed2").checked = false;
    document.getElementById("s-rgbspeed3").checked = false;
  } 

  if (item.message == "rgbswitchOFF") {
    document.getElementById("s-rgbanim").checked = false;
  } 

  if (item.message == "animrgbON") {
    document.getElementById("s-rgbanim").checked = true;
    $.post('http://Johnny_Neons/rgbanimON', JSON.stringify({}));
  } 
  
	if (item.message == "resyncanims") {
		document.getElementById("s-crisscross").checked = false;
		document.getElementById("s-neon1").checked = false;
		document.getElementById("s-neon2").checked = false;
		document.getElementById("s-neon3").checked = false;
		document.getElementById("s-neon4").checked = false;
		document.getElementById("s-allneons").checked = false;
		document.getElementById("s-lightning").checked = false;
		document.getElementById("s-fourways").checked = false;
		document.getElementById("s-blinking").checked = false;
		document.getElementById("s-snake").checked = false;
		document.getElementById("s-allinone").checked = false;
		if (item.toggleanim == true) {
			document.getElementById(item.resyncedanim).checked = true;
		}
	}
	
  $('#color-picker').spectrum({
    type: "text",
    showPalette: "false",
    showAlpha: "false",
    showButtons: "false",
    allowEmpty: "false"
  }); 

});

$(document).ready(function(){
  $('.colorchanger input').change(function(){
    var colorvalue = $("#color-picker").val();
    $.post('http://Johnny_Neons/changecolor', JSON.stringify({
      hexvalue: colorvalue
    }));    
  });
});

$('#button-anims').click(function(){
  $('#main').hide();
  $('#anims').show();
})

$('#button-colors').click(function(){
  $('#main').hide();
  $('#colors').show();
})

$('#button-settings').click(function(){
  $('#main').hide();
  $('#settings').show();
})

$('#button-closed').click(function(){
  $.post('http://Johnny_Neons/escesc', JSON.stringify({}));
})

$('#sbutton-closed').click(function(){
  $.post('http://Johnny_Neons/escesc', JSON.stringify({}));
})

$('#cbutton-closed').click(function(){
  $.post('http://Johnny_Neons/escesc', JSON.stringify({}));
})

$('#nbutton-closed').click(function(){
  $.post('http://Johnny_Neons/escesc', JSON.stringify({}));
})

$('#sbutton-back').click(function(){
  $('#settings').hide();
  $('#main').show();
})

$('#cbutton-back').click(function(){
  $('#colors').hide();
  $('#main').show();
})

$('#nbutton-back').click(function(){
  $('#anims').hide();
  $('#main').show();
})

$('#sneon-1').click(function(){
  if (document.getElementById("s-neon1").checked == false){
    $.post('http://Johnny_Neons/neon1ON', JSON.stringify({}));
  }
  else {
    $.post('http://Johnny_Neons/neon1OFF', JSON.stringify({}));
    document.getElementById("s-allneons").checked = false;
  };
  document.getElementById("s-crisscross").checked = false;
  document.getElementById("s-lightning").checked = false;
  document.getElementById("s-fourways").checked = false;
  document.getElementById("s-blinking").checked = false;
  document.getElementById("s-snake").checked = false;
  document.getElementById("s-allinone").checked = false;
})

$('#sneon-2').click(function(){
  if (document.getElementById("s-neon2").checked == false){
    $.post('http://Johnny_Neons/neon2ON', JSON.stringify({}));
  }
  else {
    $.post('http://Johnny_Neons/neon2OFF', JSON.stringify({}));
    document.getElementById("s-allneons").checked = false;
  };
  document.getElementById("s-crisscross").checked = false;
  document.getElementById("s-lightning").checked = false;
  document.getElementById("s-fourways").checked = false;
  document.getElementById("s-blinking").checked = false;
  document.getElementById("s-snake").checked = false;
  document.getElementById("s-allinone").checked = false;
})

$('#sneon-3').click(function(){
  if (document.getElementById("s-neon3").checked == false){
    $.post('http://Johnny_Neons/neon3ON', JSON.stringify({}));
  }
  else {
    $.post('http://Johnny_Neons/neon3OFF', JSON.stringify({}));
    document.getElementById("s-allneons").checked = false;
  };
  document.getElementById("s-crisscross").checked = false;
  document.getElementById("s-lightning").checked = false;
  document.getElementById("s-fourways").checked = false;
  document.getElementById("s-blinking").checked = false;
  document.getElementById("s-snake").checked = false;
  document.getElementById("s-allinone").checked = false;
})

$('#sneon-4').click(function(){
  if (document.getElementById("s-neon4").checked == false){
    $.post('http://Johnny_Neons/neon4ON', JSON.stringify({}));
  }
  else {
    $.post('http://Johnny_Neons/neon4OFF', JSON.stringify({}));
    document.getElementById("s-allneons").checked = false;
  };
  document.getElementById("s-crisscross").checked = false;
  document.getElementById("s-lightning").checked = false;
  document.getElementById("s-fourways").checked = false;
  document.getElementById("s-blinking").checked = false;
  document.getElementById("s-snake").checked = false;
  document.getElementById("s-allinone").checked = false;
})

$('#sneon-all').click(function(){
  if (document.getElementById("s-allneons").checked == false){
    $.post('http://Johnny_Neons/neonallON', JSON.stringify({}));
    document.getElementById("s-neon1").checked = true;
    document.getElementById("s-neon2").checked = true;
    document.getElementById("s-neon3").checked = true;
    document.getElementById("s-neon4").checked = true;
  }
  else {
    $.post('http://Johnny_Neons/neonallOFF', JSON.stringify({}));
    document.getElementById("s-neon1").checked = false;
    document.getElementById("s-neon2").checked = false;
    document.getElementById("s-neon3").checked = false;
    document.getElementById("s-neon4").checked = false;
  };
  document.getElementById("s-crisscross").checked = false;
  document.getElementById("s-lightning").checked = false;
  document.getElementById("s-fourways").checked = false;
  document.getElementById("s-blinking").checked = false;
  document.getElementById("s-snake").checked = false;
  document.getElementById("s-allinone").checked = false;
})

$('#sneon-crisscross').click(function(){
  if (document.getElementById("s-crisscross").checked == false){
    $.post('http://Johnny_Neons/crisscrossON', JSON.stringify({}));
    document.getElementById("s-neon1").checked = false;
    document.getElementById("s-neon2").checked = false;
    document.getElementById("s-neon3").checked = false;
    document.getElementById("s-neon4").checked = false;
    document.getElementById("s-lightning").checked = false;
    document.getElementById("s-fourways").checked = false;
    document.getElementById("s-blinking").checked = false;
    document.getElementById("s-snake").checked = false;
    document.getElementById("s-allinone").checked = false;
    document.getElementById("s-allneons").checked = false;
  }
  else {
    $.post('http://Johnny_Neons/crisscrossOFF', JSON.stringify({}));
  };
})

$('#sneon-lightning').click(function(){
  if (document.getElementById("s-lightning").checked == false){
    $.post('http://Johnny_Neons/lightningON', JSON.stringify({}));
    document.getElementById("s-neon1").checked = false;
    document.getElementById("s-neon2").checked = false;
    document.getElementById("s-neon3").checked = false;
    document.getElementById("s-neon4").checked = false;
    document.getElementById("s-crisscross").checked = false;
    document.getElementById("s-fourways").checked = false;
    document.getElementById("s-blinking").checked = false;
    document.getElementById("s-snake").checked = false;
    document.getElementById("s-allinone").checked = false;
    document.getElementById("s-allneons").checked = false;
  }
  else {
    $.post('http://Johnny_Neons/lightningOFF', JSON.stringify({}));
  };
})

$('#sneon-fourways').click(function(){
  if (document.getElementById("s-fourways").checked == false){
    $.post('http://Johnny_Neons/fourwaysON', JSON.stringify({}));
    document.getElementById("s-neon1").checked = false;
    document.getElementById("s-neon2").checked = false;
    document.getElementById("s-neon3").checked = false;
    document.getElementById("s-neon4").checked = false;
    document.getElementById("s-crisscross").checked = false;
    document.getElementById("s-lightning").checked = false;
    document.getElementById("s-blinking").checked = false;
    document.getElementById("s-snake").checked = false;
    document.getElementById("s-allinone").checked = false;
    document.getElementById("s-allneons").checked = false;
  }
  else {
    $.post('http://Johnny_Neons/fourwaysOFF', JSON.stringify({}));
  };
})

$('#sneon-blinking').click(function(){
  if (document.getElementById("s-blinking").checked == false){
    $.post('http://Johnny_Neons/blinkingON', JSON.stringify({}));
    document.getElementById("s-neon1").checked = false;
    document.getElementById("s-neon2").checked = false;
    document.getElementById("s-neon3").checked = false;
    document.getElementById("s-neon4").checked = false;
    document.getElementById("s-crisscross").checked = false;
    document.getElementById("s-lightning").checked = false;
    document.getElementById("s-fourways").checked = false;
    document.getElementById("s-snake").checked = false;
    document.getElementById("s-allinone").checked = false;
    document.getElementById("s-allneons").checked = false;
  }
  else {
    $.post('http://Johnny_Neons/blinkingOFF', JSON.stringify({}));
  };
})

$('#sneon-snake').click(function(){
  if (document.getElementById("s-snake").checked == false){
    $.post('http://Johnny_Neons/snakeON', JSON.stringify({}));
    document.getElementById("s-neon1").checked = false;
    document.getElementById("s-neon2").checked = false;
    document.getElementById("s-neon3").checked = false;
    document.getElementById("s-neon4").checked = false;
    document.getElementById("s-crisscross").checked = false;
    document.getElementById("s-lightning").checked = false;
    document.getElementById("s-blinking").checked = false;
    document.getElementById("s-fourways").checked = false;
    document.getElementById("s-allinone").checked = false;
    document.getElementById("s-allneons").checked = false;
  }
  else {
    $.post('http://Johnny_Neons/snakeOFF', JSON.stringify({}));
  };
})

$('#sneon-allinone').click(function(){
  if (document.getElementById("s-allinone").checked == false){
    $.post('http://Johnny_Neons/allinoneON', JSON.stringify({}));
    document.getElementById("s-neon1").checked = false;
    document.getElementById("s-neon2").checked = false;
    document.getElementById("s-neon3").checked = false;
    document.getElementById("s-neon4").checked = false;
    document.getElementById("s-crisscross").checked = false;
    document.getElementById("s-lightning").checked = false;
    document.getElementById("s-blinking").checked = false;
    document.getElementById("s-fourways").checked = false;
    document.getElementById("s-snake").checked = false;
    document.getElementById("s-allneons").checked = false;
  }
  else {
    $.post('http://Johnny_Neons/allinoneOFF', JSON.stringify({}));
  };
})

$('#srgbanim').click(function(){
  if (document.getElementById("s-rgbanim").checked == false){
    $.post('http://Johnny_Neons/rgbanimON', JSON.stringify({}));
  }
  else {
    $.post('http://Johnny_Neons/rgbanimOFF', JSON.stringify({}));
  };
})

$('#aspeed-1').click(function(){
  if (document.getElementById("s-aspeed1").checked == false){
    $.post('http://Johnny_Neons/aspeed1ON', JSON.stringify({}));
  }
  else {
    $.post('http://Johnny_Neons/aspeed1OFF', JSON.stringify({}));
  };
  document.getElementById("s-aspeed2").checked = false;
  document.getElementById("s-aspeed3").checked = false;
})

$('#aspeed-2').click(function(){
  if (document.getElementById("s-aspeed2").checked == false){
    $.post('http://Johnny_Neons/aspeed2ON', JSON.stringify({}));
  }
  else {
    $.post('http://Johnny_Neons/aspeed2OFF', JSON.stringify({}));
  };
  document.getElementById("s-aspeed1").checked = false;
  document.getElementById("s-aspeed3").checked = false;
})

$('#aspeed-3').click(function(){
  if (document.getElementById("s-aspeed3").checked == false){
    $.post('http://Johnny_Neons/aspeed3ON', JSON.stringify({}));
  }
  else {
    $.post('http://Johnny_Neons/aspeed3OFF', JSON.stringify({}));
  };
  document.getElementById("s-aspeed1").checked = false;
  document.getElementById("s-aspeed2").checked = false;
})

$('#rgbspeed-1').click(function(){
  if (document.getElementById("s-rgbspeed1").checked == false){
    $.post('http://Johnny_Neons/rgbspeed1ON', JSON.stringify({}));
  }
  else {
    $.post('http://Johnny_Neons/rgbspeed1OFF', JSON.stringify({}));
  };
  document.getElementById("s-rgbspeed2").checked = false;
  document.getElementById("s-rgbspeed3").checked = false;
})

$('#rgbspeed-2').click(function(){
  if (document.getElementById("s-rgbspeed2").checked == false){
    $.post('http://Johnny_Neons/rgbspeed2ON', JSON.stringify({}));
  }
  else {
    $.post('http://Johnny_Neons/rgbspeed2OFF', JSON.stringify({}));
  };
  document.getElementById("s-rgbspeed1").checked = false;
  document.getElementById("s-rgbspeed3").checked = false;
})

$('#rgbspeed-3').click(function(){
  if (document.getElementById("s-rgbspeed3").checked == false){
    $.post('http://Johnny_Neons/rgbspeed3ON', JSON.stringify({}));
  }
  else {
    $.post('http://Johnny_Neons/rgbspeed3OFF', JSON.stringify({}));
  };
  document.getElementById("s-rgbspeed1").checked = false;
  document.getElementById("s-rgbspeed2").checked = false;
})


document.onkeyup = function (data) {
	if (open) {
    if (data.which == 27) {
		$.post('http://Johnny_Neons/escesc', JSON.stringify({}));
    }
  }    
};