RegisterCommand('me', function(source, args)
    local text = "* " .. table.concat(args, " ") .. " *"
	TriggerEvent('DiscordBot:chatgeral2', source, text)
    TriggerClientEvent('3dme:shareDisplay', -1, text, source)
end)