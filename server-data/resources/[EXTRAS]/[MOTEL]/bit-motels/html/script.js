var selectedRoom = null
var selectbutton = null
var managebutton = null
var selectedCustomer = null

$(function () {
    function display(bool) {
        if (bool) {
            document.getElementById("body").style.display="block";
            $(".motels-buymotel").hide()
            $(".motels-manage").hide()
            $(".motels-managestorage").hide()
            $(".motels-managecustomers").hide()
            $(".motels-b-o-x-r-e-n-t").hide()
            $(".motels-b-o-x-d-u-p-l-i-c-a-t-e-k-e-y").hide()
            $(".motels-b-o-x-c-h-e-c-k-o-u-t").hide()
            $(".motels-b-u-t-t-o-n-manage").hide()
        } else {
            document.getElementById("body").style.display="none";
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
                $(".motels-b-u-t-t-o-n-b-u-y").show()
                $(".motels-text40").text(item.actualmotel)
                $(".motels-roomslist").html(item.rooms)
                $(".motels-text12").text(item.buyprice+item.currency)
                $(".motels-text49").text(item.buyprice+item.currency)
                $(".motels-text10").text(item.buybutton)
                $(".motels-text15").text(item.yourboss)
                $(".motels-text20").html("<br><br><br>"+item.buymotel+"<br>")
                selectbutton = item.selectbutton
                managebutton = item.managebutton
                $(".motels-text53").text(item.yes)
                $(".motels-text55").text(item.no)
                $(".motels-text45").text(item.buyconfirmtitle)
                $(".motels-text48").text(item.youhavetopay)
                $(".motels-text50").text(item.confirmdesc)
                $(".motels-text69").text(item.balance+item.currency)
                $(".motels-text79").text(item.langgeneral)
                $(".motels-text81").text(item.langemployees)
                $(".motels-text83").text(item.langstorage)
                $(".motels-text85").text(item.langcustomers)
                $(".motels-text71").html(item.langearned)
                $(".motels-text59").html(item.langselldesc)
                $(".motels-text57").text(item.langsell)
                $(".motels-customerslist").html(item.customers)
                if (item.canbuy === false) {
                    $(".motels-text15").text("")
                    $(".motels-text20").html("<br><br><br>"+item.hasanowner)
                    $(".motels-text12").text("")
                    $(".motels-b-u-t-t-o-n-b-u-y").hide()
                }
                if (item.isowner === true) {
                    $(".motels-text102").text(managebutton)
                    $(".motels-b-u-t-t-o-n-manage").show()
                }
                if (item.canbuywithmoney === false) {
                    $(".motels-b-u-t-t-o-n-b-u-y").hide()
                }
            } else {
                display(false)
            }
        }
    })
    
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://bit-motels/exit', JSON.stringify({}));
            return
        }
    };

    
    $(document).on("click", ".motels-b-u-t-t-o-n1", function(){
        selectedRoom = $(this).attr('data-value')
        var selectedOption = $(this).text()
        if (selectedOption === selectbutton) {
            $(".motels-b-o-x-r-e-n-t").show()
            $(".motels-b-o-x-d-u-p-l-i-c-a-t-e-k-e-y").hide()
            $(".motels-b-o-x-c-h-e-c-k-o-u-t").hide()
        } else if (selectedOption === managebutton) {
            $(".motels-b-o-x-r-e-n-t").hide()
            $(".motels-b-o-x-d-u-p-l-i-c-a-t-e-k-e-y").show()
            $(".motels-b-o-x-c-h-e-c-k-o-u-t").show()
        }
    });

    $(document).on("click", ".motels-b-o-x-r-e-n-t", function(){
        $.post('https://bit-motels/rent', JSON.stringify({selectedroom:selectedRoom}));
        $.post('https://bit-motels/exit', JSON.stringify({}));
        return
    });

    $(document).on("click", ".motels-text43", function(){
        $.post('https://bit-motels/exit', JSON.stringify({}));
        return
    });
    
    $(document).on("click", ".motels-b-o-x-d-u-p-l-i-c-a-t-e-k-e-y", function(){
        $.post('https://bit-motels/duplicate', JSON.stringify({value:selectedRoom}));
        $.post('https://bit-motels/exit', JSON.stringify({}));
        return
    });
    
    $(document).on("click", ".motels-b-o-x-c-h-e-c-k-o-u-t", function(){
        $.post('https://bit-motels/checkout', JSON.stringify({value:selectedRoom}));
        $.post('https://bit-motels/exit', JSON.stringify({}));
        return
    });

    $(document).on("click", ".motels-b-u-t-t-o-n-b-u-y", function(){
        $(".motels-buymotel").show()
    });

    $(document).on("click", ".motels-b-u-t-t-o-n-y-e-s", function(){
        $.post('https://bit-motels/buymotel', JSON.stringify({}));
        $.post('https://bit-motels/exit', JSON.stringify({}));
        return
    });

    $(document).on("click", ".motels-b-u-t-t-o-n-n-o", function(){
        $(".motels-buymotel").hide()
    });

    $(document).on("click", ".motels-b-u-t-t-o-n-manage", function(){
        $(".motels-manage").show()
    });

    $(document).on("click", ".motels-text79", function(){
        $(".motels-manage").show()
        $(".motels-managestorage").hide()
        $(".motels-managecustomers").hide()
    });

    $(document).on("click", ".motels-text83", function(){
        $(".motels-manage").hide()
        $(".motels-managecustomers").hide()
        $(".motels-managestorage").show()
    });

    $(document).on("click", ".motels-text85", function(){
        $(".motels-manage").hide()
        $(".motels-managecustomers").show()
        $(".motels-managestorage").hide()
    });
   
    $(document).on("click", ".customer", function(){
        selectedCustomer = $(this).attr('data-value')
        $(".customer").css('border', '1px solid #ffffff')
        $(this).css('border', '1px solid #ff005b'); 
    });

    $(document).on("click", ".kick", function(){
        $.post('https://bit-motels/kickcustomer', JSON.stringify({value:selectedCustomer}));
        $.post('https://bit-motels/exit', JSON.stringify({}));
        return
    });

    $(document).on("click", ".withdrawbutton", function(){
        var value = $(".withdrawinput").val()
        $.post('https://bit-motels/withdraw', JSON.stringify({value:value}));
        $.post('https://bit-motels/exit', JSON.stringify({}));
        return
    });

    $(document).on("click", ".depositbutton", function(){
        var value = $(".depositinput").val()
        $.post('https://bit-motels/deposit', JSON.stringify({value:value}));
        $.post('https://bit-motels/exit', JSON.stringify({}));
        return
    });

    $(document).on("click", ".motels-b-u-t-t-o-n-s-e-l-l", function(){
        $.post('https://bit-motels/sellmotel', JSON.stringify({}));
        $.post('https://bit-motels/exit', JSON.stringify({}));
        return
    });
    
})