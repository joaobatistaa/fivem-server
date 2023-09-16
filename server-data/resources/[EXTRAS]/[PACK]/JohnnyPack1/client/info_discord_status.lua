Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(740886647264116776)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('worldtugarp')
		
		-- Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('fivem://connect/cfx.re/join/3lrmvz')
       
        -- Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('discord')

        -- Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('https://discord.gg/APHUfj5u8p')
		
		players = {}
		name = GetPlayerName(PlayerId())
		id = GetPlayerServerId(PlayerId())
		for i = 0, 500 do
			if NetworkIsPlayerActive(i) then
				table.insert(players, i)
			end
		end
		
		SetRichPresence(#players .. "/150 | ID: "..id.." | Nome: "..name)
		
		SetDiscordRichPresenceAction(0, "Entrar no Servidor", "fivem://connect/cfx.re/join/3lrmvz")
		SetDiscordRichPresenceAction(1, "Discord Oficial", "https://discord.gg/APHUfj5u8p")
        

        --It updates every one minute just in case.
		Citizen.Wait(30000)
	end
end)