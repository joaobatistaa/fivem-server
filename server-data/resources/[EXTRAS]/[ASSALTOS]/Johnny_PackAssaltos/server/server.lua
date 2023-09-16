ESX = nil

ESX = exports['es_extended']:getSharedObject()

discord = {
    ['webhook'] = 'https://discord.com/api/webhooks/1078114384745865318/ATy6TFC_jRCHaDq_kHC0qT3qllCAcdQABTg46rFVhJNeKF80dzS9QOSqHj0Zd_7ZYRrA',
    ['name'] = 'Johnny Logs',
    ['image'] = 'https://i.ibb.co/CvkTJjN/worldtuga.gif'
}

function discordLog(name, message)
    local data = {
        {
            ["color"] = '3553600',
            ["title"] = "**".. name .."**",
            ["description"] = message,
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end