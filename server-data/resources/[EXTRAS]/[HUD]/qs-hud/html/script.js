$(function () {
    if (localStorage.default == "false") {
        
    } else {
        localStorage.default = "true";
    }
    
    let defaultValues = {hudtop: "90", hudleft: "5", status1top: "90", status1left: "5", oxytop: "90", oxyleft: "60", jobtop: "3", jobleft: "60", wallettop: "9", walletleft: "60", banktop: "15", bankleft: "60"};

    let checkboxes = $("input[type=checkbox][name=settings]")
    let enabledSettings = [];
    
    const format = (num, decimals) => num.toLocaleString('en-US', {
        minimumFractionDigits: 2,      
        maximumFractionDigits: 2,
    });
    
    $(document).ready(function() {	
        window.addEventListener('message', function(event) {    
            if (event.data.action == "updateHealth") {
                $('#boxHealth').css('width', event.data.value+'%')
                $('#boxArmor').css('width', event.data.valuearmor+'%')
                if(event.data.podvodou == 1){
                    $(".oxygen").fadeIn();
                    zbyva = ((event.data.lefttime / 30) * 100);
                    $('#updateoxy').css('width', zbyva+'%')
                } else if (event.data.podvodou == 0) {
                    $(".oxygen").fadeOut();
                };
            } else if (event.data.action == "update_job") {
				$("#jobbox").html(event.data.joblabel);	
            } else if (event.data.action == "update_money") {
                $("#walletbox").html("$" + event.data.walletmoney);
                $("#bankbox").html("$" + event.data.bankmoney);		
            } else if (event.data.action == "loadui") {
                let root = document.documentElement;
				$('.container').css('display', 'block')
                root.style.setProperty('--color', localStorage.color);
                settings()
                changePosition();
            } else if (event.data.action == "display") {
                displaySettings(event.data.status);
            } else if (event.data.action == "updatestatus1") {
                $('#boxStatus1').css('width', event.data.value+'%')		
            } else if (event.data.action == "updatestatus2") {
                $('#boxStatus2').css('width', event.data.value+'%')						
            } else if (event.data.action == "hudshow") {
                $('#maincontainer').show();	
				$('#status1main').show();	
				$('.container').show();	
				$(".wallet").fadeIn();
				$(".bank").fadeIn();
				$(".job").fadeIn();		
				$(".statuscontainer1").fadeIn();	
            } else if (event.data.action == "hudhide") {
				$('#maincontainer').hide();		
                $('.container').fadeOut();	
				$(".wallet").fadeOut();
				$(".bank").fadeOut();
				$(".job").fadeOut();
				$(".statuscontainer1").fadeOut();	
            }
            
        });
		$(".sp-container").on({
		  click: function(){
		   let root = document.documentElement;
		   var value = $("#color-picker").val();
		   root.style.setProperty('--color', value);
		   $('#updateoxy').css('background', value)
		   $('.settings').css('border-color', value)
		  } 
		});	
		
    });
    
    function displaySettings(boolean) {
        if (boolean == true) {
            $(".settings").fadeIn();
            draggableElements();
            $(".oxygen").show();
        } else {
            $(".settings").fadeOut();
            $(".oxygen").hide();
        }
    };
    
    function changePosition() {
        var top;
        var left;
        var status1top;
        var status1left;		
        var oxytop;
        var oxyleft;
        var jobtop;
        var jobleft;
        var wallettop;
        var walletleft;
        var banktop;
        var bankleft;
        var color;
        
        if (localStorage.default === "true") {
            var top = defaultValues.hudtop + "%";
            var left = defaultValues.hudleft + '%';
            var status1top = defaultValues.status1top + "%";
            var status1left = defaultValues.status1left + '%';				
            var oxytop = defaultValues.oxytop + '%';
            var oxyleft = defaultValues.oxyleft + '%';
            var jobtop = defaultValues.jobtop + '%';
            var jobleft = defaultValues.jobleft + '%';
            var wallettop = defaultValues.wallettop + '%';
            var walletleft = defaultValues.walletleft + '%';
            var banktop = defaultValues.banktop + '%';
            var bankleft = defaultValues.bankleft + '%';
            let color = "#ff0000";
            
            $('.container').css({
                position:'absolute',
                top:top,
                left:left
            });
			
            $('.statuscontainer1').css({
                position:'absolute',
                top:status1top,
                left:status1left
            });				
    
            $('.oxygen').css({
                position:'absolute',
                top:oxytop,
                left:oxyleft
            });
            
            $('.job').css({
                position:'absolute',
                top:jobtop,
                left:jobleft
            });
    
            $('.bank').css({
                position:'absolute',
                top:banktop,
                left:bankleft
            });
    
            $('.wallet').css({
                position:'absolute',
                top:wallettop,
                left:walletleft
            });
            
            $('#updateoxy').css('background-color', color);
            
        } else {
            var top = localStorage.top + 'px';
            var left = localStorage.left + 'px';
            var status1top = localStorage.status1top + 'px';
            var status1left = localStorage.status1left + 'px';				
            var oxytop = localStorage.oxytop + 'px';
            var oxyleft = localStorage.oxyleft + 'px';
            var jobtop = localStorage.jobtop + 'px';
            var jobleft = localStorage.jobleft + 'px';
            var wallettop = localStorage.wallettop + 'px';
            var walletleft = localStorage.walletleft + 'px';
            var banktop = localStorage.banktop + 'px';
            var bankleft = localStorage.bankleft + 'px';
            var color = localStorage.color;
            
            $('.container').css({
                position:'absolute',
                top:top,
                left:left
            });
			
            $('.statuscontainer1').css({
                position:'absolute',
                top:status1top,
                left:status1left
            });				
    
            $('.oxygen').css({
                position:'absolute',
                top:oxytop,
                left:oxyleft
            });
            
            $('.job').css({
                position:'absolute',
                top:jobtop,
                left:jobleft
            });
    
            $('.bank').css({
                position:'absolute',
                top:banktop,
                left:bankleft
            });
    
            $('.wallet').css({
                position:'absolute',
                top:wallettop,
                left:walletleft
            });
            
            $('#updateoxy').css('background-color', color);
        }
        
    };
    
    function draggableElements() {
         
        $(".container").draggable({
            scroll: false,
            axis: "x, y",
            cursor: "move",
            containment: "window"
        });
        $(".statuscontainer1").draggable({
            scroll: false,
            axis: "x, y",
            cursor: "move",
            containment: "window"
        });			
        $(".settings").draggable({
            scroll: false,
            axis: "x, y",
            cursor: "move",
            containment: "window"
        });
        $(".oxygen").draggable({
            scroll: false,
            axis: "x, y",
            cursor: "move",
            containment: "window"
        });
        $(".wallet").draggable({
            scroll: false,
            axis: "x, y",
            cursor: "move",
            containment: "window"
        });
        $(".job").draggable({
            scroll: false,
            axis: "x, y",
            cursor: "move",
            containment: "window"
        });
        $(".bank").draggable({
            scroll: false,
            axis: "x, y",
            cursor: "move",
            containment: "window"
        });
    };
    
    window.addEventListener('message', function(event) {    
        if (event.data.action == "updatejob") {
           settings(event.data.jobgrade);
        
        };
    });
    
    function settings(grade) {
        let job = localStorage.showjob;
        let money = localStorage.showmoney;
		let status1 = localStorage.showstatus1;
        
            if (job === "true") {
                $(".job").fadeIn();
            } else {
                $(".job").fadeOut();
            };
            if (money === "true") {
                $(".wallet").fadeIn();
                $(".bank").fadeIn();
            } else {
                $(".wallet").fadeOut();
                $(".bank").fadeOut();
            };
            if (status1 === "true") {
				$(".statuscontainer1").fadeIn();
	
            } else {
                $(".statuscontainer1").fadeOut();
            };				
    }
    
    checkboxes.change(function() {
        enabledSettings = checkboxes
        
        .filter(":checked")
        .map(function() {
          return this.value;
        }) 
        .get()
        if (typeof enabledSettings == "undefined" && enabledSettings == null && enabledSettings.length == null && enabledSettings.length < 0) {
            localStorage.showjob = "false";
            localStorage.showmoney = "false";
			localStorage.showstatus1 = "false";
        } else {
            if (enabledSettings.includes("1")) {
                localStorage.showjob = "true";
            } else {
                localStorage.showjob = "false";
            };
            if (enabledSettings.includes("2")) {
                localStorage.showmoney = "true";
            } else {
                localStorage.showmoney = "false";
            };
            if (enabledSettings.includes("3")) {
                localStorage.showstatus1 = "true";
            } else {
                localStorage.showstatus1 = "false";
            };				
        };
    });
    
    $("#confirm").click(function(){
        localStorage.default = "false";
        var x = $(".container").position();
		var s1 = $(".statuscontainer1").position();
        var y = $(".oxygen").position();
        var j = $(".job").position();
        var z1 = $(".wallet").position();
        var z2 = $(".bank").position();
        var value = $("#color-picker").val();
        
        localStorage.top = x.top;
        localStorage.left = x.left;
        localStorage.status1top = s1.top;
        localStorage.status1left = s1.left;		
        localStorage.oxytop = y.top;
        localStorage.oxyleft = y.left;
        localStorage.jobtop = j.top;
        localStorage.jobleft = j.left;
        localStorage.wallettop = z1.top;
        localStorage.walletleft = z1.left;
        localStorage.banktop = z2.top;
        localStorage.bankleft = z2.left;
        localStorage.color = value;
        settings();
        changePosition();
		$.post("http://qs-hud/exit", JSON.stringify({}));
    });
         
    $("#close").click(function(){
        $.post("http://qs-hud/exit", JSON.stringify({}));
        return;
    });
        
    $("#default").click(function(){
        localStorage.default = "true";
        changePosition();    
    });
    
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://qs-hud/exit', JSON.stringify({}));
            return;
        }
    };
    
    $('#color-picker').spectrum({
        type: "text",
        showPalette: "false",
        showAlpha: "false",
        showButtons: "false",
        allowEmpty: "false"
    });
})