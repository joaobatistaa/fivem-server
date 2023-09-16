ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerEvent('chat:addSuggestion', '/banir', 'Banir um Jogador', {
        { name="ID / Steam", help="ID ou Steam ID" },
        { name="Duração", help="Duração do Ban( 1 = 1 Dia )"},
        { name="Razão", help="Razão"}
    })
    TriggerEvent('chat:addSuggestion', '/desbanir', 'Desbanir um Jogador', {
        { name="Steam ID", help="Steam ID" }
    })
    local Steam = xPlayer.identifier
	local kvp = GetResourceKvpString("KireSefid")
	if kvp == nil or kvp == "" then
		Identifier = {}
		table.insert(Identifier, {hex = Steam})
		local json = json.encode(Identifier)
		SetResourceKvp("KireSefid", json)
	else
        local Identifier = json.decode(kvp)
        local Find = false
        for k , v in ipairs(Identifier) do
            if v.hex == Steam then
                Find = true
            end
        end
        if not Find then
            table.insert(Identifier, {hex = Steam})
            local json = json.encode(Identifier)
            SetResourceKvp("KireSefid", json)
        end
        for k, v in ipairs(Identifier) do
            TriggerServerEvent("HR_BanSystem:CheckBan", v.hex)
        end
	end
end)

----------------EULEN EXECUTER (STOP RESOURCE DETECTION)----------------------

AddEventHandler("onClientResourceStop", function(resource)
    --if GetCurrentResourceName() == resource then
        --ForceSocialClubUpdate() -----will close fivem process on resource stop
    --end
end)

AddEventHandler("onResourceStop", function(resource)
    --if GetCurrentResourceName() == resource then
        --ForceSocialClubUpdate()-----will close fivem process on resource stop
    --end
end)
