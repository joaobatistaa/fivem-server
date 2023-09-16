function FormatItemInfo(itemData) {
    if (itemData != null && itemData.info != "") {
        let label = itemData?.info?.label || itemData?.label;
        if (itemData.name == "id_card") {
            var gender = "Man";
            if (itemData.info.gender == 1) {
                gender = "Woman";
            }
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html(
                "</p><p><strong>First Name: </strong><span>" +
                itemData.info.firstname +
                "</span></p><p><strong>Last Name: </strong><span>" +
                itemData.info.lastname +
                "</span></p><p><strong>Birth Date: </strong><span>" +
                itemData.info.birthdate +
                "</span></p><p><strong>Gender: </strong><span>" +
                gender +
                "</span></p><p><strong>Type: </strong><span>" +
                itemData.info.type +
                "</span></p>"
            );
		} else if (itemData.name == "cartao_cidadao") {
			$(".item-info-title").html('<p>'+ `${itemData.info.label|| label}` +'</p>')
			$(".item-info-description").html(
				"<p><strong>Nome: </strong><span>" + 
				itemData.info.firstname + 
				"</span></p><p><strong>Apelido: </strong><span>" + 
				itemData.info.lastname + 
				"</span></p><p><strong>Género: </strong><span>" + 
				itemData.info.gender + 
				"</span></p><p><strong>Data de Nascimento: </strong><span>" + 
				itemData.info.dateofbirth + 
				"</span></p><p><strong>Altura: </strong><span>" + 
				itemData.info.height + 
				"cm</span></p><p><strong>Número ID Civil: </strong><span>" + 
				itemData.info.numero_cc +
				"</span></p>"
			);
		} else if (itemData.name == "vehiclekeys") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html(
                "<p><strong>Matrícula: </strong><span>" +
                itemData.info.plate +
                "</span></p><p><strong>Modelo: </strong><span>" +
                itemData.info.description +
                "</span></p>"
            );
		} else if (itemData.name == "motelkey") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html(
                "<p><strong>Motel: </strong><span>" +
                itemData.info.motel +
                "</span></p><p><strong>Quarto: </strong><span>" +
                itemData.info.room +
				"</span></p><p><strong>Proprietário: </strong><span>" +
                itemData.info.renter +
                "</span></p>"
            );
		} else if (itemData.name == "licenca_arma") {
			$(".item-info-title").html('<p>'+ `${itemData.info.label|| label}` +'</p>')
			$(".item-info-description").html('<p><strong>Nome: </strong><span>' + 
			itemData.info.name + '</span></p><p><strong>Apelido: </strong><span>' + 
			itemData.info.lastname + '</span></p><p><strong>Género: </strong><span>' + 
			itemData.info.gender + '</span></p><p><strong>Data de Nascimento: </strong><span>' + 
			itemData.info.dateofbirth + '</span></p><p><strong>' +
			"Número Porte de Arma: " + '</strong><span>' + 
			itemData.info.numero_licenca + '</span></p><p><strong>Informação: </strong><span>Este civil está apto para ter armas ligeiras.</span></p>');
		} else if (itemData.name == "carta_conducao") {
			$(".item-info-title").html('<p>'+ `${itemData.info.label|| label}` +'</p>')
			$(".item-info-description").html('<p><strong>Nome: </strong><span>' + 
			itemData.info.name + '</span></p><p><strong>Apelido: </strong><span>' + 
			itemData.info.lastname + '</span></p><p><strong>Género: </strong><span>' + 
			itemData.info.gender + '</span></p><p><strong>Data de Nascimento: </strong><span>' + 
			itemData.info.dateofbirth + '</span></p><p><strong>' + 
			'Número da Licença: ' + '</strong><span>' + 
			itemData.info.numero_licenca + '</span></p><p><strong>' + 
			itemData.info.type + '</strong></p>');
		} else if (itemData.name == "licenca_caca") {
			$(".item-info-title").html('<p>'+ `${itemData.info.label|| label}` +'</p>')
			$(".item-info-description").html('<p><strong>Nome: </strong><span>' + 
			itemData.info.name + '</span></p><p><strong>Apelido: </strong><span>' + 
			itemData.info.lastname + '</span></p><p><strong>Género: </strong><span>' + 
			itemData.info.gender + '</span></p><p><strong>Data de Nascimento: </strong><span>' + 
			itemData.info.dateofbirth + '</span></p><p><strong>' + 
			"Número Licença de Caça: " + '</strong><span>' + 
			itemData.info.numero_licenca + '</span></p><p><strong>Informação: </strong><span>Este civil está apto para caçar.</span></p>');
		} else if (itemData.name == "licenca_aviao") {
			$(".item-info-title").html('<p>'+ `${itemData.info.label|| label}` +'</p>')
			$(".item-info-description").html('<p><strong>Nome: </strong><span>' + 
			itemData.info.name + '</span></p><p><strong>Apelido: </strong><span>' + 
			itemData.info.lastname + '</span></p><p><strong>Género: </strong><span>' + 
			itemData.info.gender + '</span></p><p><strong>Data de Nascimento: </strong><span>' + 
			itemData.info.dateofbirth + '</span></p><p><strong>' + 
			"Número Licença de Aviação: " + '</strong><span>' + 
			itemData.info.numero_licenca + '</span></p><p><strong>Informação: </strong><span>Este civil está apto para conduzir aeronaves.</span></p>');
		} else if (itemData.name == "licenca_barco") {
			$(".item-info-title").html('<p>'+ `${itemData.info.label|| label}` +'</p>')
			$(".item-info-description").html('<p><strong>Nome: </strong><span>' + 
			itemData.info.name + '</span></p><p><strong>Apelido: </strong><span>' + 
			itemData.info.lastname + '</span></p><p><strong>Género: </strong><span>' + 
			itemData.info.gender + '</span></p><p><strong>Data de Nascimento: </strong><span>' + 
			itemData.info.dateofbirth + '</span></p><p><strong>' + 
			"Número Licença de Navegação: " + '</strong><span>' + 
			itemData.info.numero_licenca + '</span></p><p><strong>Informação: </strong><span>Este civil está apto para conduzir barcos.</span></p>');
        } else if (itemData.name == "phone" && itemData.info.phoneNumber) {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html(
                "<p><strong>Número de Telemóvel: </strong><span>" +
                itemData.info.phoneNumber +
                "</span></p><p><strong>Nome: </strong><span>" +
                itemData.info.charinfo.firstname +
                "</span></p><p><strong>Apelido: </strong><span>" +
                itemData.info.charinfo.lastname +
                "</span></p>"
            );
        } else if (itemData.name == "photo") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html(
                "<p><span>" +
                itemData.info.location +
                "</span></p><span>" +
                itemData.info.date + "</span></p>"
            );
		} else if (itemData.name == "vehiclekeys") {
			$(".item-info-title").html("<p>" + label + "</p>");
			$(".item-info-description").html(
				"<p><strong>Matrícula: </strong><span>" +
				itemData.info.plate +
				"</span></p><p><strong>Modelo: </strong><span>" +
				itemData.info.description +
				"</span></p>"
			);
        } else if (itemData.name == "plate") {
            $(".item-info-title").html("<p>" + label + "</p>");
            $(".item-info-description").html(
                "<p><strong>Matrícula: </strong><span>" +
                itemData.info.plate +
                "</span></p>"
            );
        } else if (itemData.name == "driver_license") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html(
                "<p><strong>First Name: </strong><span>" +
                itemData.info.firstname +
                "</span></p><p><strong>Last Name: </strong><span>" +
                itemData.info.lastname +
                "</span></p><p><strong>Birth Date: </strong><span>" +
                itemData.info.birthdate +
                "</span></p><p><strong>Licenses: </strong><span>" +
                itemData.info.type +
                "</span></p>"
            );
		} else if (itemData.name == "licenca_arma") {
			$(".item-info-title").html('<p>'+ `${itemData.info.label|| label}` +'</p>')
			$(".item-info-description").html('<p><strong>Nome: </strong><span>' + 
			itemData.info.name + '</span></p><p><strong>Apelido: </strong><span>' + 
			itemData.info.lastname + '</span></p><p><strong>Género: </strong><span>' + 
			itemData.info.gender + '</span></p><p><strong>Data de Nascimento: </strong><span>' + 
			itemData.info.dateofbirth + '</span></p><p><strong>' +
			"Número Porte de Arma: " + '</strong><span>' + 
			itemData.info.numero_licenca + '</span></p><p><strong>Informação: </strong><span>Este civil está apto para ter armas ligeiras.</span></p>');
        } else if (itemData.name == "lawyerpass") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html(
                "<p><strong>Pass-ID: </strong><span>" +
                itemData.info.id +
                "</span></p><p><strong>First Name: </strong><span>" +
                itemData.info.firstname +
                "</span></p><p><strong>Last Name: </strong><span>" +
                itemData.info.lastname +
                "</span></p><p><strong>CSN: </strong><span>" +
                itemData.info.citizenid +
                "</span></p>"
            );
        } else if (itemData.name == "harness") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html(
                "<p>" + itemData.info.uses + " uses left.</p>"
            );
        } else if (itemData.type == "weapon") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            if (itemData.info.ammo == undefined) {
                itemData.info.ammo = 0;
            } else {
                itemData.info.ammo != null ? itemData.info.ammo : 0;
            }
            if (itemData.info.attachments != null) {
                var attachmentString = "";
                $.each(itemData.info.attachments, function (i, attachment) {
                    if (i == itemData.info.attachments.length - 1) {
                        attachmentString += attachment.label;
                    } else {
                        attachmentString += attachment.label + ", ";
                    }
                });
                $(".item-info-description").html(
                    "<p><strong>Número de Série: </strong><span>" +
                    itemData.info.serie +
                    "</span></p><p><strong>Munição: </strong><span>" +
                    itemData.info.ammo +
                    "</span></p><p><strong>Anexos: </strong><span>" +
                    attachmentString +
                    "</span></p>"
                );
            } else {
                $(".item-info-description").html(
                    "<p><strong>Número de Série: </strong><span>" +
                    itemData.info.serie +
                    "</span></p><p><strong>Munição: </strong><span>" +
                    itemData.info.ammo +
                    "</span></p><p>" +
                    itemData.description +
                    "</p>"
                );
            }
        } else if (itemData.name == "filled_evidence_bag") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            if (itemData.info.type == "casing") {
                $(".item-info-description").html(
                    "<p><strong>Evidência: </strong><span>" +
                    itemData.info.label +
                    "</span></p><p><strong>Tipo de Munição: </strong><span>" +
                    itemData.info.ammotype +
                    "</span></p><p><strong>Calibre: </strong><span>" +
                    itemData.info.ammolabel +
                    "</span></p><p><strong>Número de Série: </strong><span>" +
                    itemData.info.serie +
                    "</span></p><p><strong>Cena do Crime: </strong><span>" +
                    itemData.info.street +
                    "</span></p><br /><p>" +
                    itemData.description +
                    "</p>"
                );
                
            } else if (itemData.info.type == "blood") {
                $(".item-info-description").html(
                    "<p><strong>Evidência: </strong><span>" +
                    itemData.info.label +
                    "</span></p><p><strong>Tipo de Sangue: </strong><span>" +
                    itemData.info.bloodtype +
                    "</span></p><p><strong>Código DNA: </strong><span>" +
                    itemData.info.dnalabel +
                    "</span></p><p><strong>Cena do Crime: </strong><span>" +
                    itemData.info.street +
                    "</span></p><br /><p>" +
                    itemData.description +
                    "</p>"
                );
            } else if (itemData.info.type == "fingerprint") {
                $(".item-info-description").html(
                    "<p><strong>Evidência: </strong><span>" +
                    itemData.info.label +
                    "</span></p><p><strong>Impressão Digital: </strong><span>" +
                    itemData.info.fingerprint +
                    "</span></p><p><strong>Cena do Crime: </strong><span>" +
                    itemData.info.street +
                    "</span></p><br /><p>" +
                    itemData.description +
                    "</p>"
                );
            } else if (itemData.info.type == "dna") {
                $(".item-info-description").html(
                    "<p><strong>Evidência: </strong><span>" +
                    itemData.info.label +
                    "</span></p><p><strong>Código DNA: </strong><span>" +
                    itemData.info.dnalabel +
                    "</span></p><br /><p>" +
                    itemData.description +
                    "</p>"
                );
            }
        } else if (
            itemData.info.costs != undefined &&
            itemData.info.costs != null
        ) {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html("<p>" + itemData.info.costs + "</p>");
        } else if (itemData.name == "stickynote") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html("<p>" + itemData.info.label + "</p>");
        } else if (itemData.name == "moneybag") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html(
                "<p><strong>Amount of cash: </strong><span>$" +
                itemData.info.cash +
                "</span></p>"
            );
        } else if (itemData.name == "markedbills") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html(
                "<p><strong>Worth: </strong><span>$" +
                itemData.info.worth +
                "</span></p>"
            );
        } else if (itemData.name == "visa" || itemData.name == "mastercard") {
            $(".item-info-title").html('<p>' + label + '</p>')
            var str = "" + itemData.info.cardNumber + "";
            var res = str.slice(12);
            var cardNumber = "************" + res;
            $(".item-info-description").html('<p><strong>Card Holder: </strong><span>' + itemData.info.name + '</span></p><p><strong>Citizen ID: </strong><span>' + itemData.info.citizenid + '</span></p><p><strong>Card Number: </strong><span>' + cardNumber + '</span></p>');
        } else if (itemData.name == "labkey") {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html("<p>Lab: " + itemData.info.lab + "</p>");
        } else {
            $(".item-info-title").html("<p>" + `${itemData.info.label|| label}` + "</p>");
            $(".item-info-description").html("<p>" + itemData.description + "</p>");
        }
    } else {
        $(".item-info-title").html("<p>" + itemData.label + "</p>");
        $(".item-info-description").html("<p>" + itemData.description + "</p>");
    }
}