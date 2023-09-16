$(function () {
    function display(bool) {
    if (bool) {
        $("body").show();
        $("#johnny").show();
    } else {
        $("body").hide();
        $("#johnny").hide();
    }
}

display(false)


window.addEventListener('message', function(event) {

        var item = event.data;

        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }

        JohnnyCoords(event.data);
        johnnyNormalCoords(event.data);
        johnnyVector3Coords(event.data);
        johnnyVector4Coords(event.data);

    })
})

function johnnyClose(){
    $.post('http://Johnny_Coords/johnnyCloseButton');
}

function JohnnyCoordsCopy(){
    const copyText = document.getElementById("johnnyCoords").textContent;
    const textArea = document.createElement('textarea');
    textArea.textContent = copyText;
    document.body.append(textArea);
    textArea.select();
    document.execCommand("copy");
}

function JohnnyNormalCoordsCopy(){
    const copyText = document.getElementById("johnnyNormalCoords").textContent;
    const textArea = document.createElement('textarea');
    textArea.textContent = copyText;
    document.body.append(textArea);
    textArea.select();
    document.execCommand("copy");
}

function JohnnyVector3CoordsCopy(){
    const copyText = document.getElementById("johnnyVector3Coords").textContent;
    const textArea = document.createElement('textarea');
    textArea.textContent = copyText;
    document.body.append(textArea);
    textArea.select();
    document.execCommand("copy");
}

function JohnnyVector4CoordsCopy(){
    const copyText = document.getElementById("johnnyVector4Coords").textContent;
    const textArea = document.createElement('textarea');
    textArea.textContent = copyText;
    document.body.append(textArea);
    textArea.select();
    document.execCommand("copy");
}

function JohnnyCoords(data) {

	if (data.type === 'johnny') {
        JohnnyCoordsStart(data);
    }

}

function johnnyNormalCoords(data) {

	if (data.type === 'normal') {
        JohnnyCoordsNormalStart(data);
    }

}

function johnnyVector3Coords(data) {

	if (data.type === 'vector3') {
        JohnnyCoordsVector3Start(data);
    }

}

function johnnyVector4Coords(data) {

	if (data.type === 'vector4') {
        JohnnyCoordsVector4Start(data);
    }

}

function JohnnyCoordsStart(data){
    document.querySelector("#johnnyCoords").textContent = data.text;
}

function JohnnyCoordsNormalStart(data){
    document.querySelector("#johnnyNormalCoords").textContent = data.text;
}

function JohnnyCoordsVector3Start(data){
    document.querySelector("#johnnyVector3Coords").textContent = data.text;
}

function JohnnyCoordsVector4Start(data){
    document.querySelector("#johnnyVector4Coords").textContent = data.text;
}