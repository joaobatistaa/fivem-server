Config.Webhooks = { -- Place your Discord webhooks here.
    ["createhouse"] = 'https://discord.com/api/webhooks/1077720411615285359/qJPCroTuZQ4KRjro7_EKEUSMuE1Ln9f4IA7ESbhPlMTA-GEdp6wKL7f45Cueo9pCDscy',
    ["deletehouse"] = 'https://discord.com/api/webhooks/1077720597167100034/H5aosSpIx-qkjhrgQE45szZmDINrt9xehbegjbNCLFPbiknapW3SaHUwo6GDXHshBGCv',
    ["buyhouse"] = 'https://discord.com/api/webhooks/1077720312533241907/pJ-_ztv4voZyekiMvVL8EhBd2oqLYcoV3jw7nrZ2cnPav0DX5Fsb_sRjV0BUjPXCa6CM',
}

Config.WebhookMark = 'Johnny Logs'

Config.WebhookTranslates = { --Configure here all the translations of your webhook.
    ["createhouse"] = {
        ["title"] = "Uma nova Casa foi criada",
        ["creator"] = "**Nome do Criador:**",
        ["license"] = "\n**Identificador do Criador:**",
        ["price"] = "\n**Preço:**",
        ["street"] = "\n**Morada:**",
        ["coords"] = "\n**Coordenadas:**",
    },

    ["deletehouse"] = {
        ["title"] = "Um jogador apagou uma casa",
        ["player"] = "**Jogador:**",
        ["license"] = "\n**Identificador do Dono da Casa:**",
        ["coords"] = "\n**Coordenadas:**",
        ["house"] = "**\nCasa Removida:**",
    },

    ["buyhouse"] = {
        ["title"] = "Foi comprada uma Casa",
        ["player"] = "**Nome do Comprador:**",
        ["license"] = "\n**Identificador do Comprador:**",
        ["coords"] = "\n**Coordenadas:**",
        ["price"] = "\n**Preço:**",
        ["realestateMoney"] = "\n**Ganhos da Remax:**",
    },
}