window.addEventListener('message', function (event) {

    // VEHICLE UPDATES
    if(event.data.showhud == true){
        // $('.huds').fadeIn();
        setProgressSpeed(event.data.speed,'.progress-speed');
    }
    if(event.data.clock == true){
        $('#clock').text(event.data.showclock);
    } else if (event.data.action == "toggleCar") {
        if (event.data.show){
            $('.carStats').fadeIn();
        } else{
            $('.carStats').fadeOut();
        }
    } else if (event.data.action == "seatbelt"){
        if(event.data.status){
            $('#seatbelt').css('stroke','#7fff00');
        }else{
            $('#seatbelt').css('stroke','#ff0000');
        }
    } else if (event.data.action == "lights"){
        if(event.data.status == "off") {
            $('#lights').css('background-image','url(img/vehicle/lowbeam.png)');
            $('#lights2').css('stroke','#98D4E000');
        }else if(event.data.status == "normal") {
            $('#lights').css('background-image','url(img/vehicle/lowbeam.png)');
            $('#lights2').css('stroke','#98D4E0');
        }else if(event.data.status == "high") {
            $('#lights2').css('stroke','#98D4E0');
            $('#lights').css('background-image','url(img/vehicle/highbeam.png)');
        }
    }else if (event.data.action == "updateGas"){
        setProgressFuel(event.data.value,'.progress-fuel');
		if (event.data.value < 20) {
            $('#fuel').css('stroke', '#f03232');
        } else if (event.data.value > 20 && event.data.value < 60) {
            $('#fuel').css('stroke', '#FFFF00');
		} else if (event.data.value > 50) {
            $('#fuel').css('stroke', '#98D4E0');
        }
    }else if (event.data.action == "updateNitro"){
        setProgressNitro(event.data.value,'.progress-nitro');
        if (event.data.value < 300) {
            $('#nitro').css('stroke', '#f03232');
        } else if (event.data.value > 300 && event.data.value < 700) {
            $('#nitro').css('stroke', '#FFFF00');
		} else if (event.data.value > 700) {
            $('#nitro').css('stroke', '#7fff00');
        }
    }

     // PLAYER UPDATES

    switch (event.data.action) {
        case 'updateStatusHud':
            $("body").css("display", event.data.show ? "block" : "none");
            $("#boxSetHealth").css("width", event.data.health + "%");
            $("#boxSetArmour").css("width", event.data.armour + "%");
			$('.time').fadeIn();
            $("#time").addClass("time");
            widthHeightSplit(event.data.hunger, $("#boxSetHunger"));
            widthHeightSplit(event.data.thirst, $("#boxSetThirst"));
            widthHeightSplit2(event.data.oxygen, $("#boxSetOxygen"));
			widthHeightSplit(event.data.stamina, $("#boxSetStamina"));
            widthHeightSplit(event.data.stress, $("#boxSetStress"));
    }
});

function widthHeightSplit(value, ele) {
    let height = 26.0;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("height", eleHeight + "px");
    ele.css("top", leftOverHeight + "px");
};

function widthHeightSplit2(value, ele) {
    let height = 26.0;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("height", eleHeight + "px");
    ele.css("top", leftOverHeight + "px");
};

function Left(value, ele) {
    let height = 25.0;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("right", eleHeight + "px");
    ele.css("right", leftOverHeight + "px");
};

function formatCurrency(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function setProgressSpeed(value, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');
    var percent = value*100/220;

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/130) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(value);
  }

function setProgressFuel(percent, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value;
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-percent*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));
}

function setProgressNitro(percent, element){
    var circle = document.querySelector(element);
    var radius = circle.r.baseVal.value; 
    var circumference = radius * 2 * Math.PI;
    var html = $(element).parent().parent().find('span');

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = `${circumference}`;

    const offset = circumference - ((-(percent/10)*73)/100) / 100 * circumference;
    circle.style.strokeDashoffset = -offset;

    html.text(Math.round(percent));

}