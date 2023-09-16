EnableWebhooks = { -- Enable or disable webhooks here.
    takeArea = true,
    collectItem = true,
    airdrop = true,
}

WebhookList = { -- Place your Discord webhooks here.
	["takeArea"] = "https://discord.com/api/webhooks/1078110909425258576/8wq5uUfjkG0D23DcwYFUjTGtq0EgDwSbn4JJGzxjDFEhKPY-Pzegs2pxWT1u9PLve51I",
    ["collectItem"] = "https://discord.com/api/webhooks/1078111088404603021/NmkdAQVa8t3a6a18ViJNvLmtpJEPnWSgAcm754Vek5Yr7Yg396rw_3iyybj6ntYhMoTw",
    ["airdrop"] = "https://discord.com/api/webhooks/1078111013678895225/DdKqmOcB2_R0FnTyxluBIytTJcAwbP1-bQlYuqUd0vc3XSM3_FqgSgMauq5j57ZcIrWI",
}

WebhookTranslates = { --Configure here all the translations of your webhook.
    ["takeArea"] = {
        ["title"] = "Informação da Conquista do Território",
        ["owner"] = "** conquistou um território.\n**Emprego/Gang: **",
        ["area"] = "\n**Área conquistada: **",
    },
    ["collect"] = {
        ["title"] = "Droga Recolhida",
        ["collectDesc"] = "** apanhou drogas.\n**Droga Recolhida: **",
        ["collectItem"] = "\n**Quantidade: **",
    },
    ["airdrop"] = {
        ["title"] = "Pediu um Airdrop",
        ["asked"] = "** pediu por um Airdrop.",
    },
}