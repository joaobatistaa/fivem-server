$('body, .settings-menu, .car-hud, .cinematic-top, .cinematic-bottom').hide();

/////////////////////////////////////////////////////////////////////////////////////////
// VARIABLES'S //
/////////////////////////////////////////////////////////////////////////////////////////

let notifId = 0;
let cooldown = false;
let editorMode = false;
let progbarsLoad = false;
let micSet = false;
let hideAmmos = false;
let hideLastGear = false;
let hideHightGear = false;
let beltState = false;
let changedStamina = false;
let clockType;
let stressHided = false;

let sound;
let playerInCar = false;
let alarm = false;
let beltstates = false;

let stressValue = 0, healValue = 0, armourValue = 0, hungerValue = 0, thirstValue = 0, staminaValue = 0, playerInWeater = false;

let hudType      = localStorage.getItem('hudtype') ? localStorage.getItem('hudtype') : localStorage.setItem('hudtype', "square") ? localStorage.getItem('hudtype') : localStorage.getItem('hudtype') ;
let healColor    = localStorage.getItem('healcolor') ? localStorage.getItem('healcolor') : localStorage.setItem('healcolor', undefined) ? localStorage.getItem('healcolor') : localStorage.getItem('healcolor');
let armourColor  = localStorage.getItem('armourcolor') ? localStorage.getItem('armourcolor') : localStorage.setItem('armourcolor', undefined) ? localStorage.getItem('armourcolor') : localStorage.getItem('armourcolor') ;
let hungerColor  = localStorage.getItem('hungercolor') ? localStorage.getItem('hungercolor') : localStorage.setItem('hungercolor', undefined) ? localStorage.getItem('hungercolor') : localStorage.getItem('hungercolor') ;
let thirstColor  = localStorage.getItem('thirstcolor') ? localStorage.getItem('thirstcolor') : localStorage.setItem('thirstcolor', undefined) ? localStorage.getItem('thirstcolor') : localStorage.getItem('thirstcolor');
let staminaColor = localStorage.getItem('staminacolor') ? localStorage.getItem('staminacolor') : localStorage.setItem('staminacolor', undefined) ? localStorage.getItem('staminacolor') : localStorage.getItem('staminacolor') ;

let mapType      = localStorage.getItem('maptype') ? localStorage.getItem('maptype') : localStorage.setItem('maptype', "round") ? localStorage.getItem('maptype') : localStorage.getItem('maptype');
let speedType    = localStorage.getItem('speedtype') ? localStorage.getItem('speedtype') : localStorage.setItem('speedtype', "kmh") ? localStorage.getItem('speedtype') : localStorage.getItem('speedtype') ;

let cashBankShow = localStorage.getItem('showmoney') ? localStorage.getItem('showmoney') : localStorage.setItem('showmoney', "show") ? localStorage.getItem('showmoney') : localStorage.getItem('showmoney') ;
let keybindShow  = localStorage.getItem('showkeybind') ? localStorage.getItem('showkeybind') : localStorage.setItem('showkeybind', "hide");
let jobShow      = localStorage.getItem('showjob') ? localStorage.getItem('showjob') : localStorage.setItem('showjob', "show") ? localStorage.getItem('showjob') : localStorage.getItem('showjob') ;
let clockShow    = localStorage.getItem('showClock') ? localStorage.getItem('showClock') : localStorage.setItem('showClock', "show") ? localStorage.getItem('showClock') : localStorage.getItem('showClock') ;

let healPosition   = localStorage.getItem('heal-position') ? localStorage.getItem('heal-position')        : localStorage.setItem('heal-position', undefined) ? localStorage.getItem('heal-position') : localStorage.getItem('heal-position') ;
let armourPosition = localStorage.getItem('armour-position') ? localStorage.getItem('armour-position')    : localStorage.setItem('armour-position', undefined) ? localStorage.getItem('armour-position') : localStorage.getItem('armour-position');
let hungerPosition = localStorage.getItem('hunger-position') ? localStorage.getItem('hunger-position')    : localStorage.setItem('hunger-position', undefined) ? localStorage.getItem('hunger-position') : localStorage.getItem('hunger-position') ;
let thirstPosition = localStorage.getItem('thirst-position') ? localStorage.getItem('thirst-position')    : localStorage.setItem('thirst-position', undefined) ? localStorage.getItem('thirst-position') : localStorage.getItem('thirst-position') ;
let staminaPosition = localStorage.getItem('stamina-position') ? localStorage.getItem('stamina-position') : localStorage.setItem('stamina-position', undefined) ? localStorage.getItem('stamina-position') : localStorage.getItem('stamina-position') ;

let streetPosition = localStorage.getItem('street-position') ? localStorage.getItem('street-position')    : localStorage.setItem('street-position', undefined) ? localStorage.getItem('street-position') : localStorage.getItem('street-position') ;
let carhudPosition = localStorage.getItem('carhud-position') ? localStorage.getItem('carhud-position')    : localStorage.setItem('carhud-position', undefined) ? localStorage.getItem('carhud-position') : localStorage.getItem('carhud-position') ;

const barTypes = {
    circle: ProgressBar.Circle,
    square: ProgressBar.Square
}

let progbarColor = {
    trail: "#00000035",
    color: "#00a967",
}

let rootColors = {
    primarygreen: "#00a967",
    primaryorange: "#e7bd88",
    primarygreenrgba: "rgba(0, 169, 104, 0.3)",
    primaryorangergba: "rgba(231, 188, 136, 0.75)",
    stathealt: "#f4c574",
    statarmour: "#b8a8ff",
    stathunger: "#56e8f2",
    statthirst: "#6fd485",
    statstamina: "#ffffff",
    text: "#fff",
    textsönük: "#a4a5a6",
    notificationinfotext: "rgba(0, 169, 104, 1)",
    notificationinfoborder: "rgba(0, 169, 104, 0.75)",
    notificationwarningtext: "rgba(231, 188, 136, 1)",
    notificationwarningborder: "rgba(231, 188, 136, 0.75)",
    micgradient: "linear-gradient(0deg, rgba(0,0,0,0) 0%, rgba(0,0,0,0.75) 100%)",
    statstress: "#c50707",
}

/////////////////////////////////////////////////////////////////////////////////////////
// PROG BAR'S //
/////////////////////////////////////////////////////////////////////////////////////////

var mic = new ProgressBar.Circle(`.mic-progbar`, {
    strokeWidth: 7,
    easing: 'easeInOut',
    duration: 250,
    color: progbarColor.color,
    trailColor: progbarColor.trail,
    trailWidth: 7,
    svgStyle: null
});

let heal, armour, hunger, thirst, stamina, stress;

/////////////////////////////////////////////////////////////////////////////////////////
// LISTENER AND SECOND BUILD FUNCTION'S //
/////////////////////////////////////////////////////////////////////////////////////////

window.addEventListener('message', function (event) {
    let e = event.data;
    switch (e.type) {
        case "OPEN_UI":
            $('body').show();
            $('#player-id').html(`${e.playerId}`);
            break; 
        case "OPEN_SETTINGS":
            $('.settings-menu').fadeIn(250);
            break;
        case "CLOSE_SETTINGS":
            $('.settings-menu').fadeOut(250);
            break;
        case "UPDATE_MONEY":
            updateMoneys(e.cash, e.bank, e.cashItem);
            break;
        case "UPDATE_MONEY_2":
            updateMoneys2(e.cash);
            break;
        case "ADD_NOTIFICATION":
            addNotification(e.text, e.types, e.duration);
            break;
        case "UPDATE_STATUS":
            updateStats(e.heal, e.armour, e.hunger, e.thirst, e.stamina, e.weather, e.streetTitle, e.streetName);
            break;
        case "PLAYER_INCAR":
            playerInCar = true;
            $('.car-hud').fadeIn(250);
            break;
        case "PLAYER_OUTCAR":
            playerInCar = false;
            $('.car-hud').fadeOut(250);
            break;
        case "UPDATE_MIC":
            if (e.state) {
                if (!micSet) {
                    micSet = true;
                    $('#player-mic-muted').fadeOut(100)
                    if (!e.radio) {
                        $('#player-mic-activeted').fadeIn(150);
                    }else {
                        $('#player-radio').fadeIn(150);
                    }
                }
            }else {
                if (micSet) {
                    micSet = false;
                    $('#player-mic-muted').fadeIn(150);
                    $('#player-radio').fadeOut(150);
                    $('#player-mic-activeted').fadeOut(100);
                }
            }
            break;
        case "UPDATE_MIC_DISTANCE":
            updateMicDistance(e.distance);
            break;
        case "PAUSEMENU_STATE":
            if (e.state) {
                $('body').hide();
            }else {
                $('body').show();
            }
            break;
        case "UPDATE_PLAYERS":
            updateServerInformation(e.online, e.max);
            break;
        case "UPDATE_WEAPON":
            updateWeapon(e.weapon, e.ammo, e.ammoclip);
            break;
        case "UPDATE_VEHICLE_STATUS":
            updateVehicleStatus(e.gear, parseInt(e.speed), e.belt, e.door, e.light, e.engine, e.hbreake, e.limiter, e.damage, e.rpm, e.maxGear, parseInt(e.fuel));
            break;
        case "DEFAULT_MAP_LOADED":
            sendClientMapType();
            sendSpeedType();
            break;
        case "HUD_STATE":
            if (e.state) {
                $('body').fadeOut(250);
            }else {
                $('body').fadeIn(250);
            }
            break;
        case "UPDATE_JOB":
            buildJob(e.job, e.grade);
            break;
        case "LOAD_KEYBINDS":
            loadKeybinds(e.keybinds);
            break;
        case "CLOK_TYPE":
            clockType = e.clock;
            break;
        default: break;
    }
});

document.onkeyup = function(data){
    if (data.key == "Escape"){
        if (!cooldown && !editorMode) {
            $.post('http://Johnny_Hud/close', JSON.stringify({}));
        }else if (editorMode) {
            editorMode = false;
            $('.editing-mode').attr('data-state', 'deactive');
            setTimeout(() => {
                $('.information, .keybind-list').fadeIn(250);
                $('.editing-mode').animate({ "top": "-15vh", "opacity": "0"}, { duration: 500 });
                setTimeout(() => {
                    setTimeout(() => {
                        $('.settings-menu').fadeIn(250);
                        $('body').css({
                            "background": "none",
                        })
                    }, 500);
                }, 250);
            }, 250);
        }
    }
}

$('input').change(function (e) { 
    if (e.target.type == "checkbox") {
        let id = e.target.id;
        let value = e.target.checked;
        if (id == "speed-type") {
            if (value) {
                $(`#speed-type-texts[data-type="kmh"]`).attr("data-state", "false");
                $(`#speed-type-texts[data-type="mph"]`).attr("data-state", "true");
                speedType = "mph";
                localStorage.setItem('speedtype', "mph");
            }else {
                $(`#speed-type-texts[data-type="kmh"]`).attr("data-state", "true");
                $(`#speed-type-texts[data-type="mph"]`).attr("data-state", "false");
                speedType = "kmh";
                localStorage.setItem('speedtype', "kmh");
            }
            sendSpeedType();
        }else if (id == "cashandbank") {
            if (value) {
                $(`#cashandbank-texts[data-type="hide"]`).attr("data-state", "false");
                $(`#cashandbank-texts[data-type="show"]`).attr("data-state", "true");
                cashBankShow = "show";
                localStorage.setItem('showmoney', "show");
                $('.cash, .bank').fadeIn(250);
            }else {
                $(`#cashandbank-texts[data-type="hide"]`).attr("data-state", "true");
                $(`#cashandbank-texts[data-type="show"]`).attr("data-state", "false");
                cashBankShow = "hide";
                localStorage.setItem('showmoney', "hide");
                $('.cash, .bank').fadeOut(250);
            }
        }else if (id == "keybind") {
            if (value) {
                $(`#keybind-texts[data-type="hide"]`).attr("data-state", "false");
                $(`#keybind-texts[data-type="show"]`).attr("data-state", "true");
                keybindShow = "show";
                localStorage.setItem('showkeybind', "show");
                $('.keybind-list').fadeIn(250);
            }else {
                $(`#keybind-texts[data-type="hide"]`).attr("data-state", "true");
                $(`#keybind-texts[data-type="show"]`).attr("data-state", "false");
                keybindShow = "hide";
                localStorage.setItem('showkeybind', "hide");
                $('.keybind-list').fadeOut(250);
            }
        }else if (id == "cinematic") {
            if (value) {
                $(`#cinematic-texts[data-type="hide"]`).attr("data-state", "false");
                $(`#cinematic-texts[data-type="show"]`).attr("data-state", "true");
                $('.cinematic-top, .cinematic-bottom').fadeIn(250);
                cinematicMode(true);
                $.post('http://Johnny_Hud/cinematic', JSON.stringify({cinematic: true}));
            }else {
                $(`#cinematic-texts[data-type="hide"]`).attr("data-state", "true");
                $(`#cinematic-texts[data-type="show"]`).attr("data-state", "false");
                $('.cinematic-top, .cinematic-bottom').fadeOut(250);
                cinematicMode(false);
                $.post('http://Johnny_Hud/cinematic', JSON.stringify({cinematic: false}));
            }
        }else if (id == "jobitem") {
            if (value) {
                $(`#job-texts[data-type="hide"]`).attr("data-state", "false");
                $(`#job-texts[data-type="show"]`).attr("data-state", "true");
                jobShow = "show";
                localStorage.setItem('showjob', "show");
                $('.job').fadeIn(250);
            }else {
                $(`#job-texts[data-type="hide"]`).attr("data-state", "true");
                $(`#job-texts[data-type="show"]`).attr("data-state", "false");
                jobShow = "hide";
                localStorage.setItem('showjob', "hide");
                $('.job').fadeOut(250);
            }
        }else if (id == "clock") {
            if (value) {
                $(`#clock-texts[data-type="hide"]`).attr("data-state", "false");
                $(`#clock-texts[data-type="show"]`).attr("data-state", "true");
                clockShow = "show";
                localStorage.setItem('showClock', "show");
                $('.date').fadeIn(250);
            }else {
                $(`#clock-texts[data-type="hide"]`).attr("data-state", "true");
                $(`#clock-texts[data-type="show"]`).attr("data-state", "false");
                clockShow = "hide";
                localStorage.setItem('showClock', "hide");
                $('.date').fadeOut(250);
            }
        }
        return;
    }

    $(`.container-prog[data-hud="${$(this).attr('id')}"]`).children('svg').find('path').eq(1).css({
        "stroke": $(this).val()
    });

    $(`.container-prog[data-hud="${$(this).attr('id')}"]`).css({
        "background": `linear-gradient(0deg, ${$(this).val() + "50"} 0%, rgba(0,0,0,0) 100%)`
    })

    $(`.color[data-name="${$(this).attr('id')}"]`).css({
        "background": `${$(this).val()}`,
    })

    $(`.container-icon[data-hud="${$(this).attr('id')}"]`).css({
        "color": `${$(this).val()}`
    })

    localStorage.setItem(`${$(this).attr('id') + "color"}`, $(this).val());
});

$('.container').draggable({
    stop : function( event, ui ) {
        if (event.target.dataset.hud == "stamina") {

            $('.container[data-hud="pstress"]').attr('style', $(`.container[data-hud="${event.target.dataset.hud}"]`).attr('style'))
            localStorage.setItem(`stamina-position`, $(`.container[data-hud="${event.target.dataset.hud}"]`).attr('style'))
        }else {
            localStorage.setItem(`${event.target.dataset.hud}-position`, $(`.container[data-hud="${event.target.dataset.hud}"]`).attr('style'))
        }
    }
});

$('.street-mic').draggable({
    stop : function( event, ui ) {
        localStorage.setItem(`street-position`, $(`.street-mic`).attr('style'))
    }
});

// $('.car-hud').draggable({
//     stop : function( event, ui ) {
//         localStorage.setItem(`carhud-position`, $(`.car-hud`).attr('style'))
//     }
// });

/////////////////////////////////////////////////////////////////////////////////////////
// UI CONTROL'S //
/////////////////////////////////////////////////////////////////////////////////////////

$(document).on('click', '.item-selection-button', function(){
    if (!cooldown) {
        cooldown = true;
        let type = $(this).attr('data-hud-type');
        $('.item-selection-button[data-state="true"]').children('i').eq(0).fadeOut(250);
        $('.item-selection-button').attr('data-state', 'false');
        $(this).attr('data-state', 'true');
        $('.item-selection-button[data-state="true"]').children('i').eq(0).fadeIn(250);
        $(`#hudtype-texts[data-name=${type == "square" ? "round" : "square"}]`).attr('data-state', 'false');
        $(`#hudtype-texts[data-name=${type}]`).attr('data-state', 'true');
        changeHudType(type);
        cooldown = false
    }
});

$(document).on('click', '.map-select-button', function(){
    if (!cooldown) {
        cooldown = true;
        let type = $(this).attr('data-mapname');
        $(`.map-select-button[data-mapname="${type == "circle" ? "round" : "circle"}"]`).children('span').eq(0).html('Select')
        $(`.map-select-button[data-mapname="${type == "circle" ? "round" : "circle"}"]`).children('i').eq(0).eq(0).fadeOut(250);
        $(`.map-type[data-state="active"]`).attr('data-state', 'deactive');
        $(`.map-type[data-type="${type}"]`).attr('data-state', 'active');
        $(`.map-select-button[data-mapname="${type}"]`).children('span').eq(0).html('Selected')
        $(`.map-select-button[data-mapname="${type}"]`).children('i').eq(0).fadeIn(250);
        changeMapType(type);
        cooldown = false
    }
});

$(document).on('click', '.close-button', function(){
    $('.settings-menu').fadeOut(250);
    $.post('http://Johnny_Hud/close', JSON.stringify({}));
});

$(document).on('click', '.reset-default', function(){
    resetDefault();
});

$(document).on('click', '.item-button.editor', function(){
    if (!cooldown) {
        editorMode = true;
        $('.settings-menu').fadeOut(250)
        setTimeout(() => {
            $('.information, .keybind-list').fadeOut(250);
            $('body').css({"background": "rgba(0,0,0,0.5)",});
            $('.editing-mode').animate({ "top": "5vh", "opacity": "1"}, { duration: 500 });
            setTimeout(() => {
                $('.editing-mode').attr('data-state', 'active');
            }, 500);
        }, 250);
    }
});

window.onload = loaded

/////////////////////////////////////////////////////////////////////////////////////////
// MAIN BUILD UI FUNCTION'S //
/////////////////////////////////////////////////////////////////////////////////////////

function loaded() {

    if (hudType == undefined || hudType == null || hudType == "undefined") {
        setTimeout(() => {
            loaded();
        }, 5000);
    }

    renderProgBras();
    buildSettings();
    writeDate();
    writeClock();
    $.post('http://Johnny_Hud/nuiloaded', JSON.stringify({}));

    sound = new Audio('noBelt.mp3');
    sound.volume = 0.5;
}

function updateStats(pheal, parmor, phunger, pthirst, pstamina, pweather, streetTitle, streetName) {
    if (pheal > 100) {
        pheal = 100;
    }

    healValue = pheal / 100;
    armourValue = parmor / 100;
    hungerValue = phunger / 100;
    thirstValue = pthirst / 100;
    staminaValue = pstamina / 100;
    playerInWeater = pweather;

    if (progbarsLoad) {
        heal.animate(healValue <= 0 ? -0.0 : -healValue);
        armour.animate(-armourValue)
        hunger.animate(-hungerValue)
        thirst.animate(-thirstValue)
        stamina.animate(-staminaValue)

        $('#heal-text').html(`${parseInt(pheal <= 0 ? 0 : pheal)}`);
        $('#armour-text').html(`${parseInt(parmor)}`);
        $('#hunger-text').html(`${parseInt(phunger)}`);
        $('#thirst-text').html(`${parseInt(pthirst)}`);
        $('#stamina-text').html(`${parseInt(pstamina)}`);

        if (pweather) {
            if (!changedStamina) {
                changedStamina = true;
                $('#stamina-icon').hide();
                $('#oxygen-icon').show();
            }
        }else {
            if (changedStamina) {
                changedStamina = false;
                $('#stamina-icon').show();
                $('#oxygen-icon').hide();
            }
        }
		
    }else {
        console.log('Not load progbars .D?')
    }

    $('#street-first').html(`${streetTitle}`);
    $('#street-last').html(`${streetName}`);

}

function updateMicDistance(micDistance) {
	//$('.container-icon[data-hud="heal"]').css({"color": "linear-gradient(0deg, rgba(231,189,136,1) 0%, rgba(0,0,0,0) 100%)"})
    mic.animate(micDistance / 100);
}

function updateServerInformation(online, max){
    $('#now-count').html(`${online}`);
    $('#server-count').html(`/ ${max}`);
}

function updateMoneys(cash, bank, cashItem) {
    if (!cashItem) {
        $('#player-cash').html(`${addCommas(String(cash))}€`);
    }

    $('#player-bank').html(`${addCommas(String(bank))}€`);
}

function updateMoneys2(cash) {
    $('#player-cash').html(`${addCommas(String(cash))}€`);
}
 
function updateWeapon(weapon, ammo, clip) {
    $('.weapon-img').attr('src', `./img/weapons/${weapon}.png`);
    if (weapon == -1569615261) {
        if (!hideAmmos) {
            hideAmmos = true
            $('#weapon-ammo, #weapon-clip, #bullet').fadeOut(250)
        }
    }else {
        if (hideAmmos) {
            hideAmmos = false
            $('#weapon-ammo, #weapon-clip, #bullet').fadeIn(250)
        }
    }
    $('#weapon-ammo').html(`${clip} `);
    $('#weapon-clip').html(` / ${ammo - clip}`);
}

function updateVehicleStatus(gear, speed, belt, door, light, engine, hbreake, limiter, damage, rpm, maxGear, fuel) {
    let nrpm = parseInt(rpm * 9)
    let lastGear = gear-1 == -1 && nrpm > 2;
    let nextGear =  gear == maxGear
    let speedKmh = parseInt(speed * 3.6)
    let speedMph = parseInt(speed * 2.23)
    let speeds = speedType == 'kmh' ? speedKmh : speedMph
    let speedProg = speedType == 'kmh' ? speedKmh * 2 : speedMph * 3

    $('#kmh').html(`${speedType == "kmh" ? "KM/H" : "MP/H"}`);

    if (lastGear) {
        if (!hideLastGear) {
            hideLastGear = true
            $('#last-gear').fadeOut(250)
        }
    }else {
        if (hideLastGear) {
            hideLastGear = false
            $('#last-gear').fadeIn(250)
        }
    }

    if (!lastGear) {
        $('#last-gear').html(`${gear-1 == -1 ? "R" : gear-1 == 0 ? "N" : gear-1}`);
    }

    $('#now-gear').html(`${gear-1 == -1 && nrpm > 2 ? "R" : gear == 0 ? "N" : gear-1 == -1 ? "R" : gear}`);

    if (nextGear) {
        if (!hideHightGear) {
            hideHightGear = true
            $('#next-gear').fadeOut(250)
        }
    }else {
        if (hideHightGear) {
            hideHightGear = false
            $('#next-gear').fadeIn(250)
        }
    }

    if (!nextGear) {
        $('#next-gear').html(`${gear+1 == maxGear ? maxGear : gear+1}`);
    }

    if (speedProg <= 380) {
        $('.speed-prog').animate({
            "stroke-dasharray" : 401 + (speedProg)
        }, 10);
    }
    
    $('#speed').html(`${speeds}`);

    $('.fuel-prog').animate({"stroke-dasharray" : 773 + (parseInt(fuel * 1.15))}, 1);
    
    if (fuel >= 51) {
        $('#fuel').attr('data-fuel', 'good');
    }else if (fuel >= 25) {
        $('#fuel').attr('data-fuel', 'low');
    }else if (fuel <= 20) {
        $('#fuel').attr('data-fuel', 'verylow');
    }

    $('#belt').attr('src', `./img/speedm-images/${belt ? 'belt-on' : 'belt'}.png`);
    $('#door').attr('src', `./img/speedm-images/${door ? 'door-on' : 'door'}.png`);
    $('#lights').attr('src', `./img/speedm-images/${light ? 'lights-on' : 'lights'}.png`);
    $('#engine').attr('src', `./img/speedm-images/${engine ? 'engine-on' : 'engine'}.png`);
    $('#brake').attr('src', `./img/speedm-images/${hbreake ? 'brake-on' : 'brake'}.png`);
    $('#spped-limiter').attr('src', `./img/speedm-images/${limiter ? 'meter-on' : 'meter'}.png`);
    $('#wrench').attr('src', `./img/speedm-images/${parseInt(damage / 10) <= 50 ? 'wrench-on' : 'wrench'}.png`);

    if (!belt) {
        //beltAlarm();
        if (!beltState) {
            beltState = true
            $('#belt').attr('data-state', 'false');
            beltstates = false
        }
    }else {
        if (beltState) {
            beltState = false
            $('#belt').attr('data-state', 'true');
            beltstates = true
        }
    }

}

function writeClock() {
    if (!clockType) {
        setTimeout(() => {
            writeClock(); 
        }, 2000);
    }
    if (clockType == "PM") {
        let date = new Date();
        let hours = date.getHours();
        let minutes = date.getMinutes();
        let seconds = date.getSeconds();
        let ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12;
        minutes = minutes < 10 ? '0'+minutes : minutes;
        seconds = seconds < 10 ? '0'+seconds : seconds;
        let strTime = hours + ':' + minutes + ' ' + ampm;
        $('#clock').html(`${strTime}`);
        setTimeout(() => {
            writeClock();
        }, 1 * 60 * 1000);
    }else if (clockType == "24") {
        let date = new Date();
        let hours = date.getHours();
        let minutes = date.getMinutes();
        let seconds = date.getSeconds();
        hours = hours < 10 ? '0'+hours : hours;
        minutes = minutes < 10 ? '0'+minutes : minutes;
        seconds = seconds < 10 ? '0'+seconds : seconds;
        let strTime = hours + ':' + minutes;
        $('#clock').html(`${strTime}`);
        setTimeout(() => {
            writeClock();
        }, 1 * 60 * 1000);
    }
}

function writeDate() {
    let date = new Date();
    let day = date.getDate();
    let month = date.getMonth() + 1;
    let year = date.getFullYear();
    let strDate = day + '.' + month + '.' + year;
    $('#date').html(`${strDate}`);
    setTimeout(() => {
        writeDate();
    }, 1 * 60 * 1000);
}

function buildSettings(resetSettings) {
    if (resetSettings && resetSettings != undefined) {

        $(`.item-selection-button`).attr('data-state', 'false');
        $(`.item-selection-button`).children('i').eq(0).fadeOut(250);
        $(`#hudtype-texts`).attr('data-state', 'false');
        $('.container-prog').removeClass('square');
        $('.container-prog').removeClass('circle');

        $(`.map-select-button[data-mapname="circle"]`).children('span').eq(0).html('Select')
        $(`.map-select-button[data-mapname="circle"]`).children('i').eq(0).eq(0).fadeOut(250);
        $(`.map-type[data-state="active"]`).attr('data-state', 'deactive');
        setTimeout(() => {
            $(`.map-type[data-type="round"]`).attr('data-state', 'active');
            $(`.map-select-button[data-mapname="round"]`).children('span').eq(0).html('Selected')
            $(`.map-select-button[data-mapname="round"]`).children('i').eq(0).fadeIn(250);
        }, 500);

        $('.street-mic').css({
            "bottom": "20vh"
        });
        $('.notification-list').css({
            "top": "18vh"
        });

        $(`#speed-type-texts`).attr("data-state", "false");
        $(`.speed-selection`)[0].checked = true
		
		/*
        $(`#cashandbank-texts[data-type="hide"]`).attr("data-state", "false");
        $(`#cashandbank-texts[data-type="show"]`).attr("data-state", "true");
        $(`.cashandbank-selection`)[0].checked = true

        $('.cash, .bank').fadeIn(250);
		*/
		
        $(`#keybind-texts[data-type="hide"]`).attr("data-state", "true");
        $(`#keybind-texts[data-type="show"]`).attr("data-state", "false");
        $(`.keybind-selection`)[0].checked = false

        $('.keybind-list').fadeIn(250);

        $(`#cinematic-texts[data-type="hide"]`).attr("data-state", "true");
        $(`#cinematic-texts[data-type="show"]`).attr("data-state", "false");
        $('.cinematic-top, .cinematic-bottom').fadeOut(250);
        $('.cinematic-selection')[0].checked = false
		
		/*
        $(`#job-texts[data-type="hide"]`).attr("data-state", "false");
        $(`#job-texts[data-type="show"]`).attr("data-state", "true");
        $('.jobitem-selection')[0].checked = true
        $('.job').fadeIn(250);
		*/
		
        $(`#clock-texts[data-type="hide"]`).attr("data-state", "false");
        $(`#clock-texts[data-type="show"]`).attr("data-state", "true");
        $('.clock-selection')[0].checked = true
        $('.date').fadeIn(250);

        sendClientMapType();
        sendSpeedType();
    }

    $(`.item-selection-button[data-hud-type=${hudType == "circle" ? "round" : "square"}]`).attr('data-state', 'true');
    $(`.item-selection-button[data-hud-type=${hudType == "circle" ? "round" : "square"}]`).children('i').eq(0).fadeIn(250);
    $(`#hudtype-texts[data-name=${hudType == "circle" ? "round" : "square"}]`).attr('data-state', 'true');
    $('.container-prog').addClass(`${hudType}`);

    $(`.map-select-button[data-mapname="${mapType == "circle" ? "round" : "circle"}"]`).children('span').eq(0).html('Select')
    $(`.map-select-button[data-mapname="${mapType == "circle" ? "round" : "circle"}"]`).children('i').eq(0).eq(0).fadeOut(250);
    $(`.map-type[data-state="active"]`).attr('data-state', 'deactive');
    $(`.map-type[data-type="${mapType}"]`).attr('data-state', 'active');
    $(`.map-select-button[data-mapname="${mapType}"]`).children('span').eq(0).html('Selected')
    $(`.map-select-button[data-mapname="${mapType}"]`).children('i').eq(0).fadeIn(250);

    if (mapType == "circle") {
        if (!streetPosition) {
            $('.street-mic').css({
                "bottom": "25vh"
            });
            $('.notification-list').css({
                "top": "13vh"
            });
        }
    }else if (mapType == "round") {
        if (!streetPosition) {
            $('.street-mic').css({
                "bottom": "20vh"
            });
            $('.notification-list').css({
                "top": "18vh"
            });
        }
    }

    $(`#speed-type-texts[data-type="${speedType}"]`).attr("data-state", "true");
    if (speedType == "mph") {
        $(`.speed-selection`).attr('checked', true);
    }
	
	/*
    if (cashBankShow == "show") {
        $(`#cashandbank-texts[data-type="hide"]`).attr("data-state", "false");
        $(`#cashandbank-texts[data-type="show"]`).attr("data-state", "true");
        $(`.cashandbank-selection`)[0].checked = true
        $('.cash, .bank').fadeIn(250);
    }else {
        $(`#cashandbank-texts[data-type="hide"]`).attr("data-state", "true");
        $(`#cashandbank-texts[data-type="show"]`).attr("data-state", "false");
        $(`.cashandbank-selection`)[0].checked = false
        $('.cash, .bank').fadeOut(250);
    }
	*/

    if (keybindShow == "show") {
        $(`#keybind-texts[data-type="hide"]`).attr("data-state", "false");
        $(`#keybind-texts[data-type="show"]`).attr("data-state", "true");
        $(`.keybind-selection`)[0].checked = true
        $('.keybind-list').fadeIn(250);
    }else {
        $(`#keybind-texts[data-type="hide"]`).attr("data-state", "true");
        $(`#keybind-texts[data-type="show"]`).attr("data-state", "false");
        $(`.keybind-selection`)[0].checked = false
        $('.keybind-list').fadeOut(250);
    }
	
	/*
    if (jobShow == "show") {
        $(`#job-texts[data-type="hide"]`).attr("data-state", "false");
        $(`#job-texts[data-type="show"]`).attr("data-state", "true");
        $('.jobitem-selection')[0].checked = true
        $('.job').fadeIn(250);
    }else {
        $(`#job-texts[data-type="hide"]`).attr("data-state", "true");
        $(`#job-texts[data-type="show"]`).attr("data-state", "false");
        $('.jobitem-selection')[0].checked = false
        $('.job').fadeOut(250);
    }
	

    if (clockShow == "show") {
        $(`#clock-texts[data-type="hide"]`).attr("data-state", "false");
        $(`#clock-texts[data-type="show"]`).attr("data-state", "true");
        $('.clock-selection')[0].checked = true
        $('.date').fadeIn(250);
    }else {
        $(`#clock-texts[data-type="hide"]`).attr("data-state", "true");
        $(`#clock-texts[data-type="show"]`).attr("data-state", "false");
        $('.clock-selection')[0].checked = false
        $('.date').fadeOut(250);
    }
	*/
}

function changeHudType(type) {
    $('.container-prog').removeClass(`${hudType}`);
    hudType = `${type == "round" ? "circle" : "square"}`;
    localStorage.setItem('hudtype', `${type == "round" ? "circle" : "square"}`)
    $('.container-prog').addClass(`${hudType}`);
    renderProgBras();
}

function renderProgBras() {

    if (heal && armour && hunger && thirst && stamina) {
        heal.destroy();
        armour.destroy();
        hunger.destroy();
        thirst.destroy();
        stamina.destroy();
    }

    heal = new barTypes[hudType](`.container-prog[data-hud="heal"]`, {
        strokeWidth: 7,
        easing: 'easeInOut',
        duration: 250,
        color: healColor == "undefined" ? rootColors.stathealt : healColor,
        trailColor: "#00000000",
        trailWidth: 7,
        svgStyle: {
            width: '100%'
        },
    });
    
    armour = new barTypes[hudType](`.container-prog[data-hud="armour"]`, {
        strokeWidth: 7,
        easing: 'easeInOut',
        duration: 250,
        color: armourColor == "undefined" ? rootColors.statarmour : armourColor,
        trailColor: "#00000000",
        trailWidth: 7,
        svgStyle: {
            width: '100%'
        },
    });
    
    hunger = new barTypes[hudType](`.container-prog[data-hud="hunger"]`, {
        strokeWidth: 7,
        easing: 'easeInOut',
        duration: 250,
        color: hungerColor == "undefined" ? rootColors.stathunger : hungerColor,
        trailColor: "#00000000",
        trailWidth: 7,
        svgStyle: {
            width: '100%'
        },
    });
    
    thirst = new barTypes[hudType](`.container-prog[data-hud="thirst"]`, {
        strokeWidth: 7,
        easing: 'easeInOut',
        duration: 250,
        color: thirstColor == "undefined" ? rootColors.statthirst : thirstColor,
        trailColor: "#00000000",
        trailWidth: 7,
        svgStyle: {
            width: '100%'
        },
    });
    
    stamina = new barTypes[hudType](`.container-prog[data-hud="stamina"]`, {
        strokeWidth: 7,
        easing: 'easeInOut',
        duration: 250,
        color: staminaColor == "undefined" ? rootColors.statstamina : staminaColor,
        trailColor: "#00000000",
        trailWidth: 7,
        svgStyle: {
            width: '100%'
        },
    });   

    $('.container[data-hud="heal"]').attr('style', `${healPosition != "undefined" || healPosition != undefined ? healPosition : ""}`);
    $('.container[data-hud="armour"]').attr('style', `${armourPosition != "undefined" || armourPosition != undefined ? armourPosition : ""}`);
    $('.container[data-hud="hunger"]').attr('style', `${hungerPosition != "undefined" || hungerPosition != undefined ? hungerPosition : ""}`);
    $('.container[data-hud="thirst"]').attr('style', `${thirstPosition != "undefined" || thirstPosition != undefined ? thirstPosition : ""}`);
    $('.container[data-hud="stamina"]').attr('style', `${staminaPosition != "undefined" || staminaPosition != undefined ? staminaPosition : ""}`);

    $('.street-mic').attr('style', `${streetPosition != "undefined" || streetPosition != undefined ? streetPosition : ""}`);

    $('.container-prog[data-hud="heal"]').css({
        "background": `linear-gradient(0deg, ${healColor == "undefined" ? "rgba(231,189,136,0.5)" : healColor+'50'} 0%, rgba(0,0,0,0) 100%)`
    })
    
    $('.container-icon[data-hud="heal"]').css({
        "color": `${healColor == "undefined" ? "rgba(231,189,136,1)" : healColor}`
    })
    
    
    $('.container-prog[data-hud="armour"]').css({
        "background": `linear-gradient(0deg, ${armourColor == "undefined" ? "rgba(184,168,255,0.5)" : armourColor+'50'} 0%, rgba(0,0,0,0) 100%)`
    })


    $('.container-icon[data-hud="armour"]').css({
        "color": `${armourColor == "undefined" ? "rgba(184,168,255,1)" : armourColor}`
    })
    
    
    $('.container-prog[data-hud="hunger"]').css({
        "background": `linear-gradient(0deg, ${hungerColor == "undefined" ? "rgba(86,232,242,0.5)" : hungerColor+'50'} 0%, rgba(0,0,0,0) 100%)`
    })

    $('.container-icon[data-hud="hunger"]').css({
        "color": `${hungerColor == "undefined" ? "rgba(86,232,242,1)" : hungerColor}`
    })
    
    
    $('.container-prog[data-hud="thirst"]').css({
        "background": `linear-gradient(0deg, ${thirstColor == "undefined" ? "rgba(111,212,13,0.5)" : thirstColor+'50'} 0%, rgba(0,0,0,0) 100%)`
    })
    
    $('.container-icon[data-hud="thirst"]').css({
        "color": `${thirstColor == "undefined" ? "rgba(111,212,13,1)" : thirstColor}`
    })
    
    
    $('.container-prog[data-hud="stamina"]').css({
        "background": `linear-gradient(0deg, ${staminaColor == "undefined" ? "rgba(255,255,255,0.5)" : staminaColor+'50'} 0%, rgba(0,0,0,0) 100%)`
    })

    $('.container-icon[data-hud="stamina"]').css({
        "color": `${staminaColor == "undefined" ? "rgba(255,255,255,1)" : staminaColor}`
    })

    $(`.color[data-name="heal"]`).css({
        "background": `${healColor == "undefined" ? "rgba(255, 255, 255, 0.02)" : healColor}`,
    })

    $(`.color[data-name="armour"]`).css({
        "background": `${armourColor == "undefined" ? "rgba(255, 255, 255, 0.02)" : armourColor}`,
    })

    $(`.color[data-name="hunger"]`).css({
        "background": `${hungerColor == "undefined" ? "rgba(255, 255, 255, 0.02)" : hungerColor}`,
    })

    $(`.color[data-name="thirst"]`).css({
        "background": `${thirstColor == "undefined" ? "rgba(255, 255, 255, 0.02)" : thirstColor}`,
    })

    $(`.color[data-name="stamina"]`).css({
        "background": `${staminaColor == "undefined" ? "rgba(255, 255, 255, 0.02)" : staminaColor}`,
    })

    mic.animate(0.35)

    progbarsLoad = true;

}

function changeMapType(type) {
    mapType = type;
    localStorage.setItem('maptype', type);

    if (type == "circle") {
        $('.street-mic').css({
            "bottom": "24vh"
        });
        $('.notification-list').css({
            "top": "14vh"
        });
    }else if (type == "round") {
        $('.street-mic').css({
            "bottom": "20vh"
        });
        $('.notification-list').css({
            "top": "18vh"
        });
    }

    sendClientMapType();
}

function addNotification(text, type, duration) {
    let notif = $(`
    <div class="notification ${type == "information" ? "info" : type}">
        <div class="notification-title ${type == "information" ? "info" : type}">
            ${type == "information" ? '<i class="fa-regular fa-circle-exclamation"></i>' : type == "warning" ? '<i class="fa-regular fa-triangle-exclamation"></i>' : type == "error" ? '<i class="fa-regular fa-hexagon-exclamation"></i>' : console.log('Error! this notification type not have.'+type) }
            <span>${type}</span>
        </div>
        <div class="notification-text ${type == "information" ? "info" : type}">
            <span>${text}</span>
        </div>
    </div>
    `);
    console.log(arguments)
    $('.notification-list').append(notif)
    notif.animate({ "margin-right": "0vh" }, { duration: 250 });
    setTimeout(function() {
        notif.animate({ "margin-right": "-100vh" }, { duration: 250 });
        setTimeout(() => {
            notif.fadeOut(250);
            setTimeout(function() {
                notif.remove();
            }, 250);
        }, 250);
    }, duration)
}

function resetDefault() {

    healPosition    = undefined;
    armourPosition  = undefined;
    hungerPosition  = undefined;
    thirstPosition  = undefined;
    staminaPosition = undefined;
    streetPosition  = undefined;

    localStorage.setItem('heal-position', undefined);
    localStorage.setItem('armour-position', undefined);
    localStorage.setItem('hunger-position', undefined);
    localStorage.setItem('thirst-position', undefined);
    localStorage.setItem('stamina-position', undefined);
    localStorage.setItem('street-position', undefined);
    localStorage.setItem('carhud-position', undefined);

    $('.container-prog[data-hud="heal"]').css({"background": "linear-gradient(0deg, rgba(231,189,136,0.5) 0%, rgba(0,0,0,0) 100%)"})
    $('.container-icon[data-hud="heal"]').css({"color": "linear-gradient(0deg, rgba(231,189,136,1) 0%, rgba(0,0,0,0) 100%)"})
    $('.container-prog[data-hud="armour"]').css({"background": "linear-gradient(0deg, rgba(184,168,255,0.5) 0%, rgba(0,0,0,0) 100%)"})
    $('.container-icon[data-hud="armour"]').css({"color": "linear-gradient(0deg, rgba(184,168,255,1) 0%, rgba(0,0,0,0) 100%)"})
    $('.container-prog[data-hud="hunger"]').css({"background": "linear-gradient(0deg, rgba(86,232,242,0.5) 0%, rgba(0,0,0,0) 100%)"})
    $('.container-icon[data-hud="hunger"]').css({"color": "linear-gradient(0deg, rgba(86,232,242,1) 0%, rgba(0,0,0,0) 100%)"})
    $('.container-prog[data-hud="thirst"]').css({"background": "linear-gradient(0deg, rgba(111,212,13,0.5) 0%, rgba(0,0,0,0) 100%)"})
    $('.container-icon[data-hud="thirst"]').css({"color": "linear-gradient(0deg, rgba(111,212,13,1) 0%, rgba(0,0,0,0) 100%)"})
    $('.container-prog[data-hud="stamina"]').css({"background": "linear-gradient(0deg, rgba(255,255,255,0.5) 0%, rgba(0,0,0,0) 100%)"})
    $('.container-icon[data-hud="stamina"]').css({"color": "linear-gradient(0deg, rgba(255,255,255,1) 0%, rgba(0,0,0,0) 100%)"})

    hudType = "square";
    mapType = "round";
    speedType = "kmh";
    cashBankShow = "show";
    keybindShow = "hide"
    jobShow = "show";
    clockShow = "show";

    localStorage.setItem('hudtype',   "square");
    localStorage.setItem('healcolor', undefined);
    localStorage.setItem('armourcolor', undefined);
    localStorage.setItem('hungercolor', undefined);
    localStorage.setItem('thirstcolor', undefined);
    localStorage.setItem('staminacolor', undefined);
    localStorage.setItem('maptype', "round");
    localStorage.setItem('speedtype', "kmh");
    localStorage.setItem('showmoney', "show");
    localStorage.setItem('showkeybind', "show");
    localStorage.setItem('showjob', "show");
    localStorage.setItem('showClock', "show");

    healColor = "undefined"
    armourColor = "undefined"
    hungerColor = "undefined"
    thirstColor = "undefined"
    staminaColor = "undefined"

    buildSettings(true);
    renderProgBras();
    setTimeout(() => {
        $('.container').removeAttr('style');
        $('.street-mic').removeAttr('style');
    }, 500);
}

function addCommas(inputText) {
    const commaPattern = /(\d+)(\d{3})(\.\d*)*$/g;
    const callback = (match, p1, p2, p3) => `${p1.replace(commaPattern, callback)}.${p2}${p3 ? p3 : ''}`;  
    return inputText.replace(commaPattern, callback);
}

function sendClientMapType() {
    $.post('http://Johnny_Hud/setMapSelection', JSON.stringify({
        map: mapType
    }));
}

function cinematicMode(boolean) {
    if (boolean) {
        $('.cinematic-top, .cinematic-bottom').fadeIn(250);
        $('.container, .clock, .information, .keybind-list, .notification-list, .street-mic, .car-hud').css({"opacity": "0","pointer-events": "none"});
    } else {
        $('.cinematic-top, .cinematic-bottom').fadeOut(250);
        $('.container, .clock, .information, .keybind-list, .notification-list, .street-mic, .car-hud').css({"opacity": "1","pointer-events": "all"});
    }
}

function buildJob(job, grade) {
    $('#player-job').html(`${job} - ${grade}`);
}

function sendSpeedType() {
    $.post('http://Johnny_Hud/speedType', JSON.stringify({
        type: speedType
    }));
}

function loadKeybinds(list) {
    $('.keybind-list').html('');
    for (let i = 0; i < list.length; i++) {
        let item = `
        <div class="keybind">
            <div class="keybind-text">
                <span>${list[i].name}</span>
            </div>
            <div class="keybind-bind">
                <span>${list[i].key}</span>
            </div>
        </div>
        `;
        $('.keybind-list').append(item);
    }
}

function beltAlarm() {
    if (!beltstates && !alarm && playerInCar) {
        alarm = true;
        sound.play();
        setTimeout(() => {
            alarm = false;
            beltAlarm();
        }, 2500);
    }
}