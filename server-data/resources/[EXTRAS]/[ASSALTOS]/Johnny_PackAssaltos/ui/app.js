var sound1 = null;
var sound2 = null;
sound1 = new Howl({src: ["./0x0A83C2F9.ogg"]});
sound2 = new Howl({src: ["./0x02B30C41.ogg"]});

window.addEventListener('message', function(event) {
	if (event.data.transactionType == "sound1") {
		sound1.volume(0.03);
		sound1.play();
	}
	if (event.data.transactionType == "sound2") {
		sound2.volume(0.1);
		sound2.play();
	}
	if (event.data.transactionType == "stopSound") {
		sound1.stop();
		sound2.stop();
	}
});

$(document).ready(function(){
    window.addEventListener("message", function(event){
        if(event.data.action == 'open') {
            $(".mission").css({
                "display":"block"
            });
            for(i = 0; i < event.data.list.length; i++) {
                var element = "<img src ='" + event.data.list[i] + '.png' + "' class = 'missionImage' >";
                $(".mission").append(element);
            }
            sleep(3000).then(() => {        
                $(".mission").fadeOut(2000)
                $(".mission").html("");
            });
        }
    })
});

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}