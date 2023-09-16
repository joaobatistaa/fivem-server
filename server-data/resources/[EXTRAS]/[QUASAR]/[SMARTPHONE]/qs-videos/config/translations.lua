
--████████╗██████╗░░█████╗░███╗░░██╗░██████╗██╗░░░░░░█████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
--╚══██╔══╝██╔══██╗██╔══██╗████╗░██║██╔════╝██║░░░░░██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
--░░░██║░░░██████╔╝███████║██╔██╗██║╚█████╗░██║░░░░░███████║░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
--░░░██║░░░██╔══██╗██╔══██║██║╚████║░╚═══██╗██║░░░░░██╔══██║░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
--░░░██║░░░██║░░██║██║░░██║██║░╚███║██████╔╝███████╗██║░░██║░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
--░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚══╝╚═════╝░╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

Config.Language = 'en' -- Default 'en', 'es, 'de' and 'pt' but you have more translations in html.

Config.Languages = {
    ['es'] = {
        ["VIDEO_UPLOADED"] = "¡Vídeo subido!",
        ["VIDEO_TOO_LONG"] = "El video es demasiado largo",

        ["VIDEO_HELP_START"] = "Iniciar vídeo: ~INPUT_ATTACK~",
        ["VIDEO_HELP_STOP"] = "Salir del modo camara: ~INPUT_CELLPHONE_CANCEL~",
        ["VIDEO_HELP_POSITION"] = "Fontal/Trasera: ~INPUT_PHONE~",
    },

    ['en'] = {
        ["VIDEO_UPLOADED"] = "Vídeo carregado com sucesso!",
        ["VIDEO_TOO_LONG"] = "O tamanho do vídeo é demasiado grande!",

        ["VIDEO_HELP_START"] = "Começar a gravar: ~INPUT_ATTACK~",
        ["VIDEO_HELP_STOP"] = "Saír do modo câmera: ~INPUT_CELLPHONE_CANCEL~",
        ["VIDEO_HELP_POSITION"] = "Frontal/Traseira: ~INPUT_PHONE~",
    },
}