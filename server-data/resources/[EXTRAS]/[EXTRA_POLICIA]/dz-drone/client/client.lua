
if Config.Framework == "qbcore" then
	QBCore = exports[Config.QBCoreName]:GetCoreObject()
elseif Config.Framework == "esx" then
	if Config.IsESXLegacy then
		ESX = exports[Config.ESXLegacyName]:getSharedObject()
	else
		ESX = nil
		CreateThread(function()
			while ESX == nil do
				TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
				Citizen.Wait(0)
			end
		end)
	end
end

function Notify(msg, type)
	if (Config.Framework == "qbcore") and (QBCore ~= nil) then -- Notification for QBCore Framework
		local notif = "success"
		if type == 2 then
			notif = "error"
		end
		QBCore.Functions.Notify(msg, notif, 5000)
	elseif (Config.Framework == "esx") and (ESX ~= nil) then -- Notification for ESX Framework

		if type == 2 then 
			exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, 'error')
		else
			exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, 'success')
		end
	else -- Notification for Standalone Framework
		local notif = "~g~"
		if type == 2 then
			notif = "~r~"
		end
		SetNotificationTextEntry('STRING')
		AddTextComponentSubstringPlayerName(notif..""..msg)
		DrawNotification(false, true)
	end
end

RegisterNetEvent("dz-drone:client:InitiateDrone", function()
	InitiateDrone({
		speed		= 2,			-- Drone movement speed - usage: 2.5 / 15 / 100
		range		= 350,			-- Drone max range length before loses signal - usage: 100 / 350 / 1000
		sphere		= true,			-- Drone max range zone red walls sphere - usage: true / false
		health		= 100,			-- Drone health value - usage: 50 / 100 / 250 or "false" if you don't want the drone to have health (invincible)
		explode		= false,		-- Drone explode when its health reaches 0 - usage: true / false
		heatvision	= false,		-- Drone has heatvision option - usage: true / false
		nightvision	= false,		-- Drone has nightvision option - usage: true / false
		spotlight	= false,		-- Drone has spotlight - usage: true / false
		sound		= true,			-- Drone make sound - usage: true / false
		scanner		= false,		-- Using players scanner - usage: true / false
		item		= 'drone'		-- Inventory item name, used to return the item name after the drone is stopped
	})
end)

RegisterNetEvent("dz-drone:client:InitiateDroneLSPD", function()
	InitiateDrone({
		speed		= 4,			-- Drone movement speed - usage: 2.5 / 15 / 100
		range		= 600,			-- Drone max range length before loses signal - usage: 100 / 350 / 1000
		sphere		= true,			-- Drone max range zone red walls sphere - usage: true / false
		health		= 500,			-- Drone health value - usage: 50 / 100 / 250 or "false" if you don't want the drone to have health (invincible)
		explode		= true,			-- Drone explode when its health reaches 0 - usage: true / false
		heatvision	= true,			-- Drone has heatvision option - usage: true / false
		nightvision	= true,			-- Drone has nightvision option - usage: true / false
		spotlight	= true,			-- Drone has spotlight - usage: true / false
		sound		= true,			-- Drone make sound - usage: true / false
		scanner		= true,			-- Using players scanner - usage: true / false
		item		= 'drone_policia'	-- Inventory item name, used to return the item name after the drone is stopped
	})
end)

RegisterNetEvent('dz-drone:client:OnDroneSpawned', function(drone) -- Event triggered when drone has been spawned
	TriggerServerEvent('dz-drone:server:DoSyncDrone', ObjToNet(drone))
end)

RegisterNetEvent('dz-drone:client:DoSyncDrone', function(drone)
	local Drone = NetToObj(drone)
	if DoesEntityExist(Drone) then
		SetEntityLodDist(Drone, 9999)
	end
end)

RegisterNetEvent('dz-drone:client:OnDroneStopped', function(type, item) -- Event triggered when drone has been stopped
	if type == 'destroyed' then -- you functions here when the drone is destroyed
		Notify('O drone foi destruído', 2)
		TriggerServerEvent('dz-drone:server:RemoveItem', item) -- Remove The Drone from inventory
	elseif type == 'exploded' then -- you functions here when the drone is exploded
		Notify('O drone explodiu', 2)
		TriggerServerEvent('dz-drone:server:RemoveItem', item) -- Remove The Drone from inventory
	elseif type == 'signallost' then -- you functions here when the drone's signal is lost
		Notify('O sinal do drone foi perdido', 2)
		TriggerServerEvent('dz-drone:server:RemoveItem', item) -- Remove The Drone from inventory
	elseif type == 'playerdied' then -- you functions here when the player die
		Notify('O jogador morreu, o drone perdeu-se', 2)
	else -- you functions here when the drone is canceled
		Notify('Drone cancelado', 2)
	end
end)

RegisterCommand('drone', function(source,args)
	StopDrone() -- You can use this function to stop the drone. for example when player die
end)

-------------------------------------------------------------------------------------
----------------------------------- Test Command ------------------------------------
--------------- You can comment it or remove it if you use UsableItem ---------------
--[[
RegisterCommand('drone', function(source, args)
	local Argument = tonumber(args[1])
	if args[1] == nil or Argument == 1 then	-- Command: /drone or /drone 1
		InitiateDrone({
			speed		= 2,		-- Drone movement speed - usage: 2.5 / 15 / 100
			range		= 350,		-- Drone max range length before loses signal - usage: 100 / 350 / 1000
			sphere		= true,		-- Drone max range zone red walls sphere - usage: true / false
			health		= 100,		-- Drone health value - usage: 50 / 100 / 250 or "false" if you don't want the drone to have health (invincible)
			explode		= false,	-- Drone explode when its health reaches 0 - usage: true / false
			heatvision	= false,	-- Drone has heatvision option - usage: true / false
			nightvision	= false,	-- Drone has nightvision option - usage: true / false
			spotlight	= false,	-- Drone has spotlight - usage: true / false
			sound		= true,		-- Drone make sound - usage: true / false
			scanner		= false,	-- Using players scanner - usage: true / false
		})
	elseif Argument == 2 then		-- Command: /drone 2
		InitiateDrone({
			speed		= 4,		-- Drone movement speed - usage: 2.5 / 15 / 100
			range		= 600,		-- Drone max range length before loses signal - usage: 100 / 350 / 1000
			sphere		= true,		-- Drone max range zone red walls sphere - usage: true / false
			health		= 500,		-- Drone health value - usage: 50 / 100 / 250 or "false" if you don't want the drone to have health (invincible)
			explode		= true,		-- Drone explode when its health reaches 0 - usage: true / false
			heatvision	= true,		-- Drone has heatvision option - usage: true / false
			nightvision	= true,		-- Drone has nightvision option - usage: true / false
			spotlight	= true,		-- Drone has spotlight - usage: true / false
			sound		= true,		-- Drone make sound - usage: true / false
			scanner		= true,		-- Using players scanner - usage: true / false
		})
	end
end)
--]]