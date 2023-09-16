QSScoreboard = {}

$(document).ready(function(){
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case "open":
                QSScoreboard.Open(event.data);
                break;
            case "close":
                QSScoreboard.Close();
                break;
        }
    })
});

QSScoreboard.Open = function(data) {
    $(".scoreboard-block").fadeIn(150);
    $("#total-players").html("<p>"+data.players+"/"+data.maxPlayers+"</p>");
    $('#total-police').html(`<p>${data.currentCops}</p>`);
    $('#total-ambulance').html(`<p>${data.currentAmbulance}</p>`);
    $('#total-mechanic').html(`<p>${data.currentMechanic}</p>`);


    $.each(data.requiredCops, function(i, category){
        var beam = $(".scoreboard-info").find('[data-type="'+i+'"]');
        var status = $(beam).find(".info-beam-status");


        if (category.busy) {
            $(status).html('<i class="fas fa-clock"></i>');
        } else if (data.currentCops >= category.minimum) {
            $(status).html('<i class="fas fa-check"></i>');
        } else {
            $(status).html('<i class="fas fa-times"></i>');
        }
    });
}

QSScoreboard.Close = function() {
    $(".scoreboard-block").fadeOut(150);
}