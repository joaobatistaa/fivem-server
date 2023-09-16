const scrollContainer = document.querySelector(".standart-pass-list");
const scrollContainer_2 = document.querySelector(".premium-pass-list");

scrollContainer.addEventListener("wheel", (evt) => {
    evt.preventDefault();
    scrollContainer.scrollLeft += evt.deltaY;
});

scrollContainer_2.addEventListener("wheel", (evt) => {
    evt.preventDefault();
    scrollContainer_2.scrollLeft += evt.deltaY;
});
const slider = document.querySelector(".standart-pass-list");
const slider_2 = document.querySelector(".premium-pass-list");
let isDown = false;
let startX;
let scrollLeft;

slider.addEventListener('mousedown', (e) => {
    isDown = true;
    slider.classList.add('active');
    startX = e.pageX - slider.offsetLeft;
    scrollLeft = slider.scrollLeft;
});
slider.addEventListener('mouseleave', () => {
    isDown = false;
    slider.classList.remove('active');
});
slider.addEventListener('mouseup', () => {
    isDown = false;
    slider.classList.remove('active');
});
slider.addEventListener('mousemove', (e) => {
    if (!isDown) return;
    e.preventDefault();
    const x = e.pageX - slider.offsetLeft;
    const walk = (x - startX) * 3; //scroll-fast
    slider.scrollLeft = scrollLeft - walk;
});

slider_2.addEventListener('mousedown', (e) => {
    isDown = true;
    slider_2.classList.add('active');
    startX = e.pageX - slider_2.offsetLeft;
    scrollLeft = slider_2.scrollLeft;
});
slider_2.addEventListener('mouseleave', () => {
    isDown = false;
    slider_2.classList.remove('active');
});
slider_2.addEventListener('mouseup', () => {
    isDown = false;
    slider_2.classList.remove('active');
});
slider_2.addEventListener('mousemove', (e) => {
    if (!isDown) return;
    e.preventDefault();
    const x = e.pageX - slider_2.offsetLeft;
    const walk = (x - startX) * 3; //scroll-fast
    slider_2.scrollLeft = scrollLeft - walk;
});


$(function () {
    function display(bool) {
        if (bool) {
            $("body").show();
        } else {
            $("body").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
                $('.user-name').text(item.firstname + ` ` + item.lastname);
                $('.level-text-2').text(item.xp + `/600XP`);
                $('.level-text').text(item.level)

            } else {
                display(false)
            }
        }

        if (item.status == true) {
            display(true)
        }

        if (item.std_1 === true) {
            $(".standart-pass-box-1").css({ "color": "#449AFE" });
            $(".standart-pass-box-1").text("ABGEHOLT");
        }
        if (item.std_2 === true) {
            $(".standart-pass-box-2").css({ "color": "#449AFE" });
            $(".standart-pass-box-2").text("ABGEHOLT");
        }
        if (item.std_3 === true) {
            $(".standart-pass-box-3").css({ "color": "#449AFE" });
            $(".standart-pass-box-3").text("ABGEHOLT");
        }
        if (item.std_4 === true) {
            $(".standart-pass-box-4").css({ "color": "#449AFE" });
            $(".standart-pass-box-4").text("ABGEHOLT");
        }
        if (item.std_5 === true) {
            $(".standart-pass-box-5").css({ "color": "#449AFE" });
            $(".standart-pass-box-5").text("ABGEHOLT");
        }

        if (item.prm_1 === true) {
            $(".premium-pass-box-1").css({ "color": "#449AFE" });
            $(".premium-pass-box-1").text("ABGEHOLT");
        }
        if (item.prm_2 === true) {
            $(".premium-pass-box-2").css({ "color": "#449AFE" });
            $(".premium-pass-box-2").text("ABGEHOLT");
        }
        if (item.prm_3 === true) {
            $(".premium-pass-box-3").css({ "color": "#449AFE" });
            $(".premium-pass-box-3").text("ABGEHOLT");
        }
        if (item.prm_4 === true) {
            $(".premium-pass-box-4").css({ "color": "#449AFE" });
            $(".premium-pass-box-4").text("ABGEHOLT");
        }
        if (item.prm_5 === true) {
            $(".premium-pass-box-5").css({ "color": "#449AFE" });
            $(".premium-pass-box-5").text("ABGEHOLT");
        }

        if (item.xp === 300) {
            $(".ldBar level").attr("data-value", "50");
        }

        if (item.task_1 === true) {
            $("#task-1-passed").css({"background": "linear-gradient(180deg, rgba(68, 254, 139, 0.09) 0%, rgba(68, 254, 108, 0.09) 100%)" });
            $("#task-1-passed").css({"border": "0.915567px solid rgb(71 254 68 / 70%)"});
        }
        if (item.task_2 === true) {
            $("#task-2-passed").css({"background": "linear-gradient(180deg, rgba(68, 254, 139, 0.09) 0%, rgba(68, 254, 108, 0.09) 100%)" });
            $("#task-2-passed").css({"border": "0.915567px solid rgb(71 254 68 / 70%)"});
        }
        if (item.task_3 === true) {
            $("#task-3-passed").css({"background": "linear-gradient(180deg, rgba(68, 254, 139, 0.09) 0%, rgba(68, 254, 108, 0.09) 100%)" });
            $("#task-3-passed").css({"border": "0.915567px solid rgb(71 254 68 / 70%)"});
        }
        if (item.task_4 === true) {
            $("#task-4-passed").css({"background": "linear-gradient(180deg, rgba(68, 254, 139, 0.09) 0%, rgba(68, 254, 108, 0.09) 100%)" });
            $("#task-4-passed").css({"border": "0.915567px solid rgb(71 254 68 / 70%)"});
        }
        if (item.task_5 === true) {
            $("#task-5-passed").css({"background": "linear-gradient(180deg, rgba(68, 254, 139, 0.09) 0%, rgba(68, 254, 108, 0.09) 100%)" });
            $("#task-5-passed").css({"border": "0.915567px solid rgb(71 254 68 / 70%)"});
        }
        if (item.task_6 === true) {
            $("#task-6-passed").css({"background": "linear-gradient(180deg, rgba(68, 254, 139, 0.09) 0%, rgba(68, 254, 108, 0.09) 100%)" });
            $("#task-6-passed").css({"border": "0.915567px solid rgb(71 254 68 / 70%)"});
        }
        if (item.task_7 === true) {
            $("#task-7-passed").css({"background": "linear-gradient(180deg, rgba(68, 254, 139, 0.09) 0%, rgba(68, 254, 108, 0.09) 100%)" });
            $("#task-7-passed").css({"border": "0.915567px solid rgb(71 254 68 / 70%)"});
        }
        if (item.task_8 === true) {
            $("#task-8-passed").css({"background": "linear-gradient(180deg, rgba(68, 254, 139, 0.09) 0%, rgba(68, 254, 108, 0.09) 100%)" });
            $("#task-8-passed").css({"border": "0.915567px solid rgb(71 254 68 / 70%)"});
        }
        if (item.task_9 === true) {
            $("#task-9-passed").css({"background": "linear-gradient(180deg, rgba(68, 254, 139, 0.09) 0%, rgba(68, 254, 108, 0.09) 100%)" });
            $("#task-9-passed").css({"border": "0.915567px solid rgb(71 254 68 / 70%)"});
        }
        if (item.task_10 === true) {
            $("#task-10-passed").css({"background": "linear-gradient(180deg, rgba(68, 254, 139, 0.09) 0%, rgba(68, 254, 108, 0.09) 100%)" });
            $("#task-10-passed").css({"border": "0.915567px solid rgb(71 254 68 / 70%)"});
        }



        if (item.level >= 1) {
            $(".standart-pass-box-1").click(function(e) {
                $(".standart-pass-box-1").css({ "color": "#449AFE" });
                $(".standart-pass-box-1").text("ABGEHOLT");
            });
        }
        if (item.level >= 2) {
            $(".standart-pass-box-2").click(function(e) {
                $(".standart-pass-box-2").css({ "color": "#449AFE" });
                $(".standart-pass-box-2").text("ABGEHOLT");
            });
        }
        if (item.level >= 3) {
            $(".standart-pass-box-3").click(function(e) {
                $(".standart-pass-box-3").css({ "color": "#449AFE" });
                $(".standart-pass-box-3").text("ABGEHOLT");
            });
        }
        if (item.level >= 4) {
            $(".standart-pass-box-4").click(function(e) {
                $(".standart-pass-box-4").css({ "color": "#449AFE" });
                $(".standart-pass-box-4").text("ABGEHOLT");
            });
        }
        if (item.level >= 5) {
            $(".standart-pass-box-5").click(function(e) {
                $(".standart-pass-box-5").css({ "color": "#449AFE" });
                $(".standart-pass-box-5").text("ABGEHOLT");
            });
        }


        if (item.level >= 1) {
            $(".premium-pass-box-1").click(function(e) {
                $(".premium-pass-box-1").css({ "color": "#449AFE" });
                $(".premium-pass-box-1").text("ABGEHOLT");
            });
        }
        if (item.level >= 2) {
            $(".premium-pass-box-2").click(function(e) {
                console.log("test2")
                $(".premium-pass-box-2").css({ "color": "#449AFE" });
                $(".premium-pass-box-2").text("ABGEHOLT");
            });
        }
        if (item.level >= 3) {
            $(".premium-pass-box-3").click(function(e) {
                $(".premium-pass-box-3").css({ "color": "#449AFE" });
                $(".premium-pass-box-3").text("ABGEHOLT");
            });
        }
        if (item.level >= 4) {
            $(".premium-pass-box-4").click(function(e) {
                $(".premium-pass-box-4").css({ "color": "#449AFE" });
                $(".premium-pass-box-4").text("ABGEHOLT");
            });
        }
        if (item.level >= 5) {
            $(".premium-pass-box-5").click(function(e) {
                $(".premium-pass-box-5").css({ "color": "#449AFE" });
                $(".premium-pass-box-5").text("ABGEHOLT");
            });
        }
        
    })



    $(".exit").click(function() {
        $.post('http://luke-battlepass/exit', JSON.stringify({}));
    }); 
    
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://luke-battlepass/exit', JSON.stringify({}));
            return
        }
    };

    $(".premium-pass-box-1").click(function () {
        $.post('http://luke-battlepass/premium-pass-redeem-1', JSON.stringify({}));
        return
    })
    $(".premium-pass-box-2").click(function () {
        $.post('http://luke-battlepass/premium-pass-redeem-2', JSON.stringify({}));
        return
    })
    $(".premium-pass-box-3").click(function () {
        $.post('http://luke-battlepass/premium-pass-redeem-3', JSON.stringify({}));
        return
    })
    $(".premium-pass-box-4").click(function () {
        $.post('http://luke-battlepass/premium-pass-redeem-4', JSON.stringify({}));
        return
    })
    $(".premium-pass-box-5").click(function () {
        $.post('http://luke-battlepass/premium-pass-redeem-5', JSON.stringify({}));
        return
    })

    $(".standart-pass-box-1").click(function () {
        $.post('http://luke-battlepass/standart-pass-redeem-1', JSON.stringify({}));
        return
    })
    $(".standart-pass-box-2").click(function () {
        $.post('http://luke-battlepass/standart-pass-redeem-2', JSON.stringify({}));
        return
    })
    $(".standart-pass-box-3").click(function () {
        $.post('http://luke-battlepass/standart-pass-redeem-3', JSON.stringify({}));
        return
    })
    $(".standart-pass-box-4").click(function () {
        $.post('http://luke-battlepass/standart-pass-redeem-4', JSON.stringify({}));
        return
    })
    $(".standart-pass-box-5").click(function () {
        $.post('http://luke-battlepass/standart-pass-redeem-5', JSON.stringify({}));
        return
    })

})