--[[
local id = PlayerId()
local serverID = GetPlayerServerId(PlayerId())
players = {}
for i = 0, 500 do
    if NetworkIsPlayerActive( i ) then
        table.insert( players, i )
    end
end

function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  AddTextEntry('FE_THDR_GTAO', '~s~Bem Vindo ao ~g~WTRP~r~RP~w~ | ~b~ID: ' ..GetPlayerServerId(PlayerId()).. ' ~u~')
 -- AddTextEntry('PM_PANE_LEAVE', 'Retourner sur la liste des serveurs')
 -- AddTextEntry('PM_PANE_QUIT', 'Quitter FiveM et retourner sur le bureau')
 -- AddTextEntry('PM_SCR_MAP', 'Carte de Los Santos')
 -- AddTextEntry('PM_SCR_GAM', 'Prendre l\'avion')
 -- AddTextEntry('PM_SCR_INF', 'Logs')
 -- AddTextEntry('PM_SCR_SET', 'Configuration')
 -- AddTextEntry('PM_SCR_STA', 'Statistiques')
 -- AddTextEntry('PM_SCR_GAL', 'Galerie')
 -- AddTextEntry('PM_SCR_RPL', 'Éditeur ∑')
end)
--]]