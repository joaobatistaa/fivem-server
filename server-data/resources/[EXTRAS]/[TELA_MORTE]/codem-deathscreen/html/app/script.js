
var bar 
var death

let notifications = []


function GenerateNotification(message, type, timeout) {
    let id = notifications.length + 1;
    let colors = {
        ["succes"]: "#2abdc7",
        ["error"]: "#d4423d",
        ["info"]: "#FBD33F",
    }
    if (type == null) {
        type = "succes";
    }
    if (timeout == null) {
        timeout = 5000;
    }
    if (message == null) {
        message = "UNKOWN";
    }
    // audioPlayer = new Audio("./codemnotify.ogg");
    // audioPlayer.volume = 0.9;
    // audioPlayer.play();
    let html = `
       <div style="transform: translateX(-165px)" class="notify" id="notify-${id}">
       <img src="./images/kurukafa.png">
       <div class="notify-container-js">
                <P class="notify-header">Notificação</P>
                <P class="notify-text">${message}</P>
        </div>
       <div class="top-line"></div>
       <div class="notify-dots-${type}"></div>
     </div>
   `
    $('.notify-container').append(html)
    anime({
        targets: `#notify-${id}`,
        translateX: "-165",
        duration: 550,
        easing: "spring(1, 70, 100, 10)",
    });
    notifications[id] = setTimeout(() => {
        anime({
            targets: `#notify-${id}`,
            translateX: "165px",
            duration: 550,
            easing: "spring(1, 70, 100, 10)",
        });
        setTimeout(() => {
            $("#notify-" + id).remove();
            notifications[id] = null;
        }, 150);
    }, timeout)
}



window.addEventListener("message", function (event) {
    var item = event.data;

    switch (item.action) {
        case "OPEN_MENU":
        
           app.showMenu(item.death,item.timer,item.reason,item.weapon);
            
           setTimeout(() =>{
            death = item.death
            if(death){
				
                bar = new ProgressBar.Circle('#progbar', {
                    strokeWidth: 6,
                    easing: 'easeInOut',
                    duration: parseInt(item.giveuptime),
                    color: '#FF0000',
                    trailColor: '#ff000017',
                 
                    trailWidth: 6,
                    svgStyle: null,
                    strokeLinecap : 'round',
                });
                bar.animate(1.0);
            }
            }, 1000);
           

        break;  
        case "KEYBIND":
                app.keybind(item.key);
        break;
        case "send_response":
            app.send_response(item.resourceName);
        break;
        case "NOTIFY":
            GenerateNotification(item.message, 'error');
        break;
        case "LOCALE":
            app.locale(item.locale);
        break;

        
        default: 
        break;

    }
});



const app = new Vue({
    el: "#app",

    data: {
        show: false,
        killerWeapon : '',
        killTimer : 0,
        killTimerMinute :'',
        keyBind : '',
        resource : '',
        reason : '',
        locales : {}
   
            
        
    },
    mounted() {

        document.onkeydown = (evt) => {
            evt = evt || window.event;
            var isEscape = false;
            if ("key" in evt) {
                isEscape = (evt.key === "Escape" || evt.key === "Esc");
            } else {
                isEscape = (evt.keyCode === 27);
            }
            if (isEscape) {
             

            }
        };
        
        this.UpdateTimesKill();
        setInterval(() => {
            this.UpdateTimesKill();
            this.$forceUpdate();

        }, 1000)

      

    },

    methods: {

        locale(locale){
            this.locales = locale;
        },
        send_response(resourceName){
            this.resource = resourceName
            $.post(`https://${this.resource}/GetResponse`, JSON.stringify({}));
        },
        keybind(val){
            this.keyBind = val;
          
        },
        showMenu(val,timer,reas,weapon){
            this.show = val;
            this.killTimer = timer;
            this.reason = reas;
            this.killerWeapon = weapon;
        
        },
        UpdateTimesKill: function () {

            
            if (this.killTimer) {
                if(this.killTimer >= 0 ){
                    this.killTimer =  this.killTimer - 1;
                }
                let seconds = this.killTimer;
                if (seconds <= 0) {
                    this.killTimer = null;
                    this.killTimerMinute = null;
                    $.post(`https://${this.resource}/timeEnable`, JSON.stringify({}));
                }
                seconds = this.toHHMMSSkill(seconds);
                this.killTimerMinute = seconds;
            }
        },

        toHHMMSSkill: function (secs) {

            if(secs >= 0 ) {
                var sec_num = parseInt(secs, 10);
                var hours = Math.floor(sec_num / 3600);
                var minutes = Math.floor(sec_num / 60) % 60;
                var seconds = sec_num % 60;
                return [hours, minutes, seconds]
                .map((v) => (v < 10 ? "0" + v : v))
                .filter((v, i) => v !== "00" || i > 0)
                .join(":");
            }
            
        },
        
      

    
    }


})


