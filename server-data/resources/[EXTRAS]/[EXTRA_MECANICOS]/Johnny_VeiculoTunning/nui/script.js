let upgrade = []
let fix = []
let history = []
let lang
let notifyOil = false

window.addEventListener('message', function (event) {
	var item = event.data
    if (item.showmenu) {
        lang = item.lang
        upgrade = []
        fix = []
        history = []

        // Gera a tela de histórico
        let c = 0
        for (let k of item.vehicleData.servicesNUI) {
            history[c] = {name: k.name, img: k.img, hour: timeConverter(k.timer,item.format.location)+' ('+new Intl.NumberFormat(item.format.location, { maximumFractionDigits: 0, minimumFractionDigits: 0 }).format(k.km)+' KM)', action: Lang[lang]['service']}
            c++
        }

        // Gera a tela dos itens para manutenção
        c = 0
        for (let k in item.maintenance) {
            if(item.vehicleData.inspectionNUI[k] == undefined) { item.vehicleData.inspectionNUI[k] = [] }
            let percentage = item.vehicleData.inspectionNUI[k].value ?? 100

            let statusColor = 'inspectStatusGreen'
            if(percentage <= 10) {
                statusColor = 'inspectStatusRed'
            }

            fix[item.maintenance[k].interface.index] = {name: item.maintenance[k].interface.name, idname: k, updated: Lang[lang]['last_inspection'].format(item.vehicleData.inspectionNUI[k].km ?? 0), color: item.maintenance[k].interface.icon_color, img: item.maintenance[k].interface.icon, description: item.maintenance[k].interface.description, status: new Intl.NumberFormat(item.format.location, { maximumFractionDigits: 2, minimumFractionDigits: 2 }).format(percentage) + '%', statusColor: statusColor}
            c++
        }

        // Gera a tela dos itens para upgrade
        for (let k in item.upgrade) {
            let installed = ""
            if(item.vehicleData.upgradesNUI[k]) {
                installed = "Instalado"
            }
            upgrade[item.upgrade[k].interface.index] = {name: item.upgrade[k].interface.name, idname: k, installed: installed, color: item.upgrade[k].interface.icon_color, img: item.upgrade[k].interface.icon, description: item.upgrade[k].interface.description}
        }
        
        // Gera os dados da tela de reparo dos danos do veículo
        let percentage = 0
        for (let k in item.repair) {
            c = 0;
            percentage = 0
            for (let kk of item.repair[k].repair) {
                if(kk == "engine"){
                    percentage += item.engineHealth/10
                    c++
                }else if(kk == "body"){
                    percentage += item.bodyHealth/10
                    c++
                }else{
                    if(item.vehiclesHandlingsDamaged[kk] != undefined && (item.vehiclesHandlingsDamaged[kk] < item.vehiclesHandlingsOriginal[kk])) {
                        percentage += (100*item.vehiclesHandlingsDamaged[kk])/item.vehiclesHandlingsOriginal[kk]
                        c++
                    } else {
                        percentage += 100
                        c++
                    }
                }
            }
            let stylewidth = percentage == 0 ? 100 : (percentage/c)
            document.getElementById("progress-"+k).style.width = stylewidth+"%";
            if (stylewidth > 20 && stylewidth < 60) {
                document.getElementById("progress-"+k).style.background = "rgb(143, 117, 0)";
            } else if (stylewidth <= 20) {
                document.getElementById("progress-"+k).style.background = "rgb(255, 0, 0)";
            } else {
                document.getElementById("progress-"+k).style.background = "rgb(16, 141, 0)";
            }
        }

        $('#vehicle-km').empty();
        $('#vehicle-km').append(item.vehicleData.plate + ' - ' + new Intl.NumberFormat(item.format.location, { maximumFractionDigits: 0, minimumFractionDigits: 0 }).format(item.vehicleData.km/1000) + ' KM');

        $('#titleName').empty();
        $('#titleName').append(Lang[lang]['title_services']);
        $('#container-titles').empty();
        $('#container-titles').append(`
            <div class = 'menuUnit-container activeMenu' onclick="changeMenu(event)" data-container="fix-container" data-title="${Lang[lang]['title_services']}" data-img = 'images/wrench.svg'>
                <img src="images/wrench.svg" style = 'height: 35px; opacity: 60%;' alt="">
            </div>
            <div class = 'menuUnit-container' onclick="changeMenu(event)" data-container="upgrade-container" data-title = '${Lang[lang]['title_upgrades']}' data-img = 'images/up.svg'>
                <img src="images/up.svg" style = 'height: 35px; opacity: 60%;' alt="">
            </div>
            <div class = 'menuUnit-container' onclick="changeMenu(event)" data-container = 'history-container' data-title="${Lang[lang]['title_history']}" data-img ="images/history.svg">
                <img src="images/history.svg" style = 'height: 35px; opacity: 60%;' alt="">
            </div>
            <div class = 'menuUnit-container' onclick="changeMenu(event)" data-container = 'car-container' data-title="${Lang[lang]['title_repair']}" data-img ="images/car.svg">
                <img src="images/car.svg" style = 'height: 35px; opacity: 60%;' alt="">
            </div>
            <div class = 'menuUnit-container' onclick="changeMenu(event)" data-container = 'questions-container' data-title="${Lang[lang]['title_questions']}" data-img ="images/question.svg">
                <img src="images/question.svg" style = 'height: 35px; opacity: 60%;' alt="">
            </div>
        `);

        $('#engineFix').empty();
        $('#engineFix').append(Lang[lang]['engine_fix']);
        $('#transmissionFix').empty();
        $('#transmissionFix').append(Lang[lang]['transmission_fix']);
        $('#chassisFix').empty();
        $('#chassisFix').append(Lang[lang]['chassis_fix']);
        $('#suspFix').empty();
        $('#suspFix').append(Lang[lang]['suspension_fix']);
        $('#brakesFix').empty();
        $('#brakesFix').append(Lang[lang]['brakes_fix']);

        $('#questions-page').empty();
        for (let k of item.infoTextsPage) {
            $('#questions-page').append(`
            <div class="featureUnitIns-container">
                <div class="mainInspectUnit" style="align-items: flex-start;">
                    <div class="leftInspectPart">
                        <div class="iconCircle-container" style="background-color: #307EFF;">
                            <img src="${k.icon}" alt="">
                        </div>
                        <div class="inspectText-container" style="height: 100%; overflow: auto;">
                            <h1>${k.title}</h1>
                            <p>${k.text}</p>
                        </div>
                    </div>
                </div>
            </div>`);
        }
        
        renderUnits()
        $(".fix-container").css("display", "flex")
        $(".upgrade-container").css("display", "none")
        $(".history-container").css("display", "none")
        $(".car-container").css("display", "none")
        $(".questions-container").css("display", "none")
        $("main").css("display", "")
    } else if (item.showmenu == false) {
        $("main").css("display", "none")
    } else if (item.km) {
        $('.painel').empty();
        var l = parseInt(item.km).toString().length
        var zero = ''
        for(i=l;i<7;i++) zero+='0'
		$('.painel').append(zero + new Intl.NumberFormat(item.format.location, { maximumFractionDigits: 2, minimumFractionDigits: 2 }).format(item.km) + ' KM');
        $(".status-container").css("display", "")

        if (item.engineHealth < 100) {
            $("#engine-icon").css("display", "")
        } else {
            $("#engine-icon").css("display", "none")
        }
        if (item.oilHealth <= 5) {
            if (notifyOil == false) {
                notifyOil = true
                $.post("http://Johnny_VeiculoTunning/notifyOil");
            }
            $("#oil-icon").css("display", "")
        } else {
            $("#oil-icon").css("display", "none")
        }

        $(".loading-container").css("display", "")
        $('#nitro').empty();
        $('#nitro').append(item.nitroRecharges+'x');
        $('.Loading span').animate({width : item.nitroAmount+'%'},1000);
    } else if (item.km == false) {
        $(".status-container").css("display", "none")
        $(".loading-container").css("display", "none")
        $('.Loading span').animate({width : '0%'},0);
    }
});

function timeConverter(UNIX_timestamp,locale){
	var a = new Date(UNIX_timestamp * 1000);
	var time = a.toLocaleString(locale);
	return time;
}

function openInspectDetails(event) {
    let element = event.currentTarget
    
    let f1 = element.previousSibling.previousSibling
    let f2 = element.nextSibling.nextSibling
    
    let container = element.parentNode
    
    
    container.classList.add('appearHeight')
    container.classList.remove('hideHeight')
	
	container.style.minHeight = '220px'
    
    f1.style.display = 'flex'
    f2.style.display = 'flex'
    
    if (element.dataset.open == '0') {
        element.classList.add('fade')
        setTimeout(() => {
            element.classList.remove('fade')
        }, 590);
    }

    element.dataset.open = '1'
}

function closeInspectDetails(event) {
    let element = event.currentTarget

    let childs = element.childNodes

    let f1 = childs[1]
    let f2 = childs[5]
    let f3 = childs[3]

    f1.style.display = 'none'
    f2.style.display = 'none'

	element.style.minHeight = '120px'

    element.classList.remove('apperHeight')
    
    if (f3.dataset.open == '1') {
        element.classList.add('hideHeight')
        f3.classList.add('fade')
        setTimeout(() => {
            f3.classList.remove('fade')
        }, 590);
    }

    f3.dataset.open = '0'
}

function changeMenu(event) {
    let oldElem = document.querySelector('.activeMenu')
    oldElem.classList.remove('activeMenu')
    document.querySelector(`.${oldElem.dataset.container}`).style.display = 'none'
    

    let element = event.currentTarget
    element.classList.add('activeMenu')
    element.classList.add('fade')


    let container = document.querySelector(`.${element.dataset.container}`)
    container.style.display = 'flex'
    container.classList.add('fade')


    let titleName = document.querySelector('.titleName')
    titleName.textContent = element.dataset.title

    let titleImg = document.querySelector('.titleImg')
    titleImg.src = element.dataset.img

    setTimeout(() => {
        element.classList.remove('fade')
        container.classList.remove('fade')
    }, 590)
}

function renderUnits() {
    let container1 = document.querySelector('.upgrade-container')
    container1.innerHTML = ''
    for (let i in upgrade) {
        container1.innerHTML += `
        <div class = 'featureUnitIns-container' onmouseleave = 'closeInspectDetails(event)' data-feature = '${upgrade[i].name}'  data-img = '${upgrade[i].img}'>
            <div class = 'featuresDescription-container' style="display: none;">
                <p>${upgrade[i].description}</p>
            </div>

            <div class = 'mainInspectUnit' onclick="openInspectDetails(event)" data-open = '0'>
                <div class = 'leftInspectPart'>

                    <div class = 'iconCircle-container' style="background-color: ${upgrade[i].color};">
                        <img src="${upgrade[i].img}" alt="">
                    </div>

                    <div class = 'inspectText-container'>
                        <h1>${upgrade[i].name}</h1>
                    </div>
                </div>

                <p class="inspectStatus inspectStatusGreen">${upgrade[i].installed}</p>
            </div>

            <div class = 'featuresInsActions-container' style="display: none;">
                <p>${Lang[lang]['upgrade']}</p>
                <img src="images/up2.svg" alt="" onclick="makeAction(event)" data-action = 'Upgrade' data-idname = '${upgrade[i].idname}' data-name = '' data-img = ''>
                <img src="images/down.svg" alt="" onclick="makeAction(event)" data-action = 'Downgrade' data-idname = '${upgrade[i].idname}' data-name = '' data-img = ''>
                <p>${Lang[lang]['downgrade']}</p>
            </div>
        </div>
        `
    }

    let container2 = document.querySelector('.fix-container')
    container2.innerHTML = ''
    for (let o in fix) {
    
        container2.innerHTML += `
        <div class = 'featureUnitIns-container' onmouseleave = 'closeInspectDetails(event)' data-feature = '${fix[o].name}' data-img = '${fix[o].img}' >  
            <div class = 'featuresDescription-container' style="display: none;">
                <p>${fix[o].description}</p>
            </div>

            <div class = 'mainInspectUnit' onclick="openInspectDetails(event)" data-open = '0'>
                <div class = 'leftInspectPart'>

                    <div class = 'iconCircle-container' style="background-color: ${fix[o].color};">
                        <img src="${fix[o].img}" alt="">
                    </div>

                    <div class = 'inspectText-container'>
                        <h1>${fix[o].name}</h1>
                        <p>${fix[o].updated}</p>
                    </div>
                </div>
                <p class = 'inspectStatus ${fix[o].statusColor}'>${fix[o].status}</p>
            </div>

            <div class = 'featuresInsActions-container' style="display: none;">
                <p>${Lang[lang]['repair']}</p>
                <img src="images/repair.svg" alt="" onclick="makeAction(event)" data-action = 'Repair' data-idname = '${fix[o].idname}' data-name = '${fix[o].name}' data-img = '${fix[o].img}' >
                <img src="images/inspection.svg" alt="" onclick="makeAction(event)" data-action = 'Inspection' data-idname = '${fix[o].idname}' data-name = '${fix[o].name}' data-img = '${fix[o].img}' >
                <p>${Lang[lang]['inspection']}</p>
            </div>
        </div>
        `
    }

    let container3 = document.querySelector('.history-container')
    container3  .innerHTML = ''
    for (let p in history) {
        container3.innerHTML += `
        <div class = 'featureUnitIns-container'>  
            <div class = 'mainInspectUnit'>
                <div class = 'leftInspectPart'>

                    <div class = 'iconCircle-container' style="background-color: #307EFF;">
                        <img src="${history[p].img}" alt="">
                    </div>

                    <div class = 'inspectText-container'>
                        <h1>${history[p].name}</h1>
                        <p>${Lang[lang]['made_date'].format(history[p].hour)}</p>
                    </div>
                </div>
                <p class = 'hourText'>${history[p].action}</p>
            </div>
        </div>
        `
    }
}

function makeAction(event) {
    let element = event.currentTarget

    let action = element.dataset.action
    let idname = element.dataset.idname
    let name = element.dataset.name
    let img = element.dataset.img

    $.post("http://Johnny_VeiculoTunning/makeAction", JSON.stringify({action:action,idname:idname,name:name,img:img}));
}

function repairCar(repair) {
    $.post("http://Johnny_VeiculoTunning/repairCar", JSON.stringify({repair:repair}));
}

// FUNÇÃO PARA FECHAR A NUI 

function closeNui() {
    $.post("http://Johnny_VeiculoTunning/close");
}
document.onkeyup = function (data) {
    if (data.which == 27) { // ESC
        $.post("http://Johnny_VeiculoTunning/close");
    }
};

if (!String.prototype.format) {
    String.prototype.format = function() {
        var args = arguments;
        return this.replace(/{(\d+)}/g, function(match, number) { 
        return typeof args[number] != 'undefined'
            ? args[number]
            : match
        ;
        });
    };
}