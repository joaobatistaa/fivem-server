--████████╗██████╗░░█████╗░███╗░░██╗░██████╗██╗░░░░░░█████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
--╚══██╔══╝██╔══██╗██╔══██╗████╗░██║██╔════╝██║░░░░░██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
--░░░██║░░░██████╔╝███████║██╔██╗██║╚█████╗░██║░░░░░███████║░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
--░░░██║░░░██╔══██╗██╔══██║██║╚████║░╚═══██╗██║░░░░░██╔══██║░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
--░░░██║░░░██║░░██║██║░░██║██║░╚███║██████╔╝███████╗██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
--░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

Config.Language = 'en' --You can choose between 'en', 'es' or create your own language.

Config.Languages = {
  ['en'] = {
      ["ENTER_LABS"] = "[E] - Entrar no Laboratório",
      ["EXIT_LABS"] = "[E] - Sair do Laboratório",
      ["SELL_DRUGS"] = "[E] - Vender Drogas",
      ["DRUG_DEALER"] = "[E] - Traficante de Drogas",
      ["SEE_COCAINE"] = "[E] - Coletar Cocaína",
      ["SEE_MARIHUANA"] = "[E] - Coletar Marijuana",
      ["SEE_METH"] = "[E] - Coletar Meta",
      ["NO_POLICE"] = "Não há policiais suficientes",
      ["SELECT_OPTION"] = "Que tipo de venda queres fazer?",
      ["YOU_CHOOSE"] = "Temos duas opções de venda, tu escolhes campeão...",
      ["INTERESTED_BUYER"] = "[E] - Wholesaler | [G] - Retailer",
      ["BUY_CAR"] = "Se quiseres vender tanto, deves comprar um carro para ~g~€",
      ["BUY_CUSTOMER"] = "Posso dar-lhe as informações de um comprador para ~g~€",
      ["ACCEPT_REJECT"] = "[E] - Aceitar | [G] - Rejeitar",
      ["CANCEL_MISSION"] = "[E] - Cancelar entrega",
      ["SAVE_VEHICLE"] = "[E] - Guardar veiculo",
      ["OPEN_TRUNK"] = "[E] - Abrir a mala",
      ["CLOSE_GIVE"] = "[E] - Fechar a mala | [G] - Retirar drogas",
      ["CUSTOMER_STEAL"] = "[E] - Dar drogas | [G] - Tentar escapar",
      ["SAVE_DRUGS"] = "[E] - Guardar drogas na bagageira",
      ["PARK_VEHICLE"] = "[E] - Guardar",
      ["UNPARK_VEHICLE"] = "[E] - Retirar Veículo",
      ["DRUG_TRUNK_TEXT"] = "Retirar as drogas da bagageira",
      ["CUSTOMER_GIVE"] = "[E] - Entregar drogas",
      ["GENERAL_PROCESS"] = "[E] - Processar drogas",
      ["POLICE_NOTIFY"] = "Está a ocorrer venda de drogas em",
      ["INSUFFICIENT_ITEM"] = "Não tens o suficiente ",
      ["CUSTOMER_ON_DRUGS"] = "O cliente ficou muito contente e pagou o dobro",
      ["NO_DRUGS"] = "Não tens drogas suficientes!",
      ["INSUFFICIENT_DRUG"] = "Não tens droga suficiente, precisas de um mínimo ",
      ["YOU_CANCEL"] = "Cancelas-te uma missão de drogas!",
      ["POLICE_ALERT"] = "O vendedor chamou a polícia!",
      ["SAVE_CAR"] = "Primeiro deixe o veículo na garagem!",
      ["SELL_DONE"] = "Não tens mais drogas, o pedido está feito",
      ["WAITING_ORDER"] = "Estás esperando o pedido do distribuidor...",
      ["FAKE_CUSTOMER"] = "O comprador acabou por ser um ladrão!",
      ["NO_CAR"] = "Este veículo não é seu",
      ["ORDER_CANCELED"] = "Pedido cancelado",
      ["STEAL_DRUGS"] = "Todas as suas drogas foram roubadas",
      ["NO_MONEY"] = "Não tens dinheiro suficiente",
      ["YOU_NEED_ITEM_REQ"] = "Não tens componentes ...",
      ["LEAVE_CAR"] = "Desça do veículo!",
      ["NO_DRUGS_TRUNK"] = "Aqui não tem drogas",
      ["FIND_CUSTOMER"] = "Encontrei um cliente, vá conhecê-lo",
      ["CUSTOMER_PURCHASE"] = "Procure o comprador para vender as drogas",
      ["RETURN_VEHICLE"] = "Terminas-te a missão, retorna à base para devolver o veículo",
      ["YOU_NO_DRUGS"] = "Não tens drogas, volta para a base e devolve o veículo.",
      ["VEHICLE_SPAWN"] = "O veículo está esperando perto do armazém perto das escadas, dirija-se ao local designado...",
      ["YOU_NEED"] = "Precisas de ter no mínimo: ",
      ["SELL_WEED"] = "Vendeste marijuana por €",
      ["SELL_METH"] = "Vendeste metanfetamina para €",
      ["SELL_COCAINE"] = "Vendeste cocaína por €",
      ["REWARD_ITEM"] = "Consegues",
      ["CANT_CARRY"] = "Não podes levar mais",
      ["NO_BLACK_MONEY"] = "Não tens dinheiro sujo...",
      ["REWARD_MONEY"] = "Ganhaste dinheiro lavando",
      ["DOESNT_KNOW_YOU"] = "Não te conheço, sai daqui garoto.",
      ["YOU_NEED_BLACK_MONEY"] = "Não tens dinheiro sujo",

      ["OPEN_TRUNK_BAR"] = "A abrir a mala...",
      ["CLOSE_TRUNK_BAR"] = "A fechar a mala...",
      ["TAKE_DRUGS_BAR"] = "A retirar drogas da panela...",
      ["SAVE_DRUGS_BAR"] = "Salvando as drogas do traficante...",
      ["TALKING_BAR"] = "Conversando com o comprador...",
      ["COLLECT_MARIHUANA"] = "Apanhando marijuana...",
      ["COLLECT_METH"] = "Apanhando metafetamina...",
      ["COLLECT_COCAINE"] = "Apanhando cocaina...",
  },

  ['es'] = {
      ["ENTER_LABS"] = "[E] - Entrar al laboratorio",
      ["EXIT_LABS"] = "[E] - Salir del laboratorio",
      ["GENERAL_PROCESS"] = "[E] - Procesar drogas",
      ["SELL_DRUGS"] = "[E] - Vender drogas",
      ["DRUG_DEALER"] = "[E] - Narcotraficante",
      ["SEE_COCAINE"] = "[E] - Recolectar cocaina",
      ["SEE_MARIHUANA"] = "[E] - Recolectar marihuana",
      ["SEE_METH"] = "[E] - Recolectar quimicos",
      ["NO_POLICE"] = "No hay policias suficientes",
      ["SELECT_OPTION"] = "¿Que tipo de venta quieres hacer?",
      ["YOU_CHOOSE"] = "Tenemos dos opciones de venta, tu eliges campeon...",
      ["INTERESTED_BUYER"] = "[E] - Mayorista | [G] - Minorista",
      ["BUY_CAR"] = "Si quieres vender tanta cantidad, debes comprar un coche por ~g~€",
      ["BUY_CUSTOMER"] = "Puedo darte la informacion de un comprador por ~g~€",
      ["ACCEPT_REJECT"] = "[E] - Aceptar | [G] - Rechazar",
      ["CANCEL_MISSION"] = "[E] - Cancelar entrega",
      ["SAVE_VEHICLE"] = "[E] - Guardar vehículo",
      ["OPEN_TRUNK"] = "[E] - Abrir maletero",
      ["CLOSE_GIVE"] = "[E] - Cerrar maletero | [G] - Sacar las drogas",
      ["CUSTOMER_STEAL"] = "[E] - Dar drogas | [G] - Intentar escapar",
      ["SAVE_DRUGS"] = "[E] - Guardas drogas en el maletero",
      ["PARK_VEHICLE"] = "[E] - Estacionar",
      ["UNPARK_VEHICLE"] = "[E] - Salir del estacionamiento",
      ["DRUG_TRUNK_TEXT"] = "Saca las drogas del maletero",
      ["CUSTOMER_GIVE"] = "[E] - Entregar drogas",

      ["POLICE_NOTIFY"] = "Ha habido ventas de drogas en ",
      ["INSUFFICIENT_ITEM"] = "No tiene suficiente ",
      ["CUSTOMER_ON_DRUGS"] = "El cliente estaba muy drogado y pago el doble",
      ["NO_DRUGS"] = "No tienes drogas suficientes",
      ["INSUFFICIENT_DRUG"] = "No tiene suficiente droga, necesitas minimo ",
      ["YOU_CANCEL"] = "¡Cancelaste un recado de drogas!",
      ["POLICE_ALERT"] = "¡El vendedor llamo a la policia!",
      ["SAVE_CAR"] = "¡Primero deja el vehiculo en el garaje!",
      ["SELL_DONE"] = "No tienes más drogas, el pedido está hecho",
      ["WAITING_ORDER"] = "Estás esperando el pedido del distribuidor...",
      ["FAKE_CUSTOMER"] = "¡El comprador resulto ser un ladron!",
      ["NO_CAR"] = "Este vehiculo no es tuyo",
      ["ORDER_CANCELED"] = "Orden cancelada",
      ["STEAL_DRUGS"] = "Todas tus drogas fueron robadas",
      ["NO_MONEY"] = "No tienes dinero suficiente",
      ["YOU_NEED_ITEM_REQ"] = "Te faltan componentes...",
      ["LEAVE_CAR"] = "¡Bajate del vehiculo!",
      ["NO_DRUGS_TRUNK"] = "No hay drogas aqui",
      ["FIND_CUSTOMER"] = "Encontre un cliente, ve a reunirte con el",
      ["CUSTOMER_PURCHASE"] = "Busca al comprador para vender las drogas",
      ["RETURN_VEHICLE"] = "Terminaste el mandado, regresa a la base para devolver el vehículo",
      ["YOU_NO_DRUGS"] = "No tienes drogas, regrese a la base y devuelva el vehículo.",
      ["VEHICLE_SPAWN"] = "El vehículo está esperando cerca del almacén cerca de las escaleras, conduzca hasta el lugar designado...",
      ["YOU_NEED"] = "Necesitas tener mínimo: ",
      ["SELL_WEED"] = "Vendiste marihuana por €",
      ["SELL_METH"] = "Vendiste metanfetaminas por €",
      ["SELL_COCAINE"] = "Vendiste cocaina por €",
      ["REWARD_ITEM"] = "Obtienes",
      ["CANT_CARRY"] = "No puedes tomar más",
      ["NO_BLACK_MONEY"] = "No tienes dinero negro...",
      ["REWARD MONEY"] = "Te lavas dinero", 
      ["DOESNT_KNOW_YOU"] = "No te conozco, sal de aquí niño",
      ["YOU_NEED_BLACK_MONEY"] = "Te falta dinero negro",

      ["OPEN_TRUNK_BAR"] = "Abriendo el maletero...",
      ["CLOSE_TRUNK_BAR"] = "Cerrando el maletero...",
      ["TAKE_DRUGS_BAR"] = "Sacando las drogas del meltero...",
      ["SAVE_DRUGS_BAR"] = "Guardando las drogas del meltero...",
      ["TALKING_BAR"] = "Hablando con el comprador...",
      ["COLLECT_MARIHUANA"] = "Recolectando marihuana...",
      ["COLLECT_METH"] = "Recolectando metanfetamina...",
      ["COLLECT_COCAINE"] = "Recolectando cocaína...",
	},
}