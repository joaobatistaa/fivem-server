local oxygenTank = 25.0
local attachedProp = 0
local attachedProp2 = 0
local lownotify = 0
local toghud = true
local svrId = GetPlayerServerId(PlayerId())

local speed = 0.0
local seatbeltOn = false
local cruiseOn = false
local bleedingPercentage = 0
Fuel = 0



RegisterCommand('hud', function(source, args, rawCommand)

    if toghud then 
        toghud = false
		TriggerEvent('esx:togglehud', toghud)
    else
        toghud = true
		TriggerEvent('esx:togglehud', toghud)
    end

end)

RegisterNetEvent('hud:toggleui')
AddEventHandler('hud:toggleui', function(show)

    if show == true then
        toghud = true
    else
        toghud = false
    end

end)

--- ATUALIZA A FOME E A SEDE A CADA 5 SEGUNDOS

Citizen.CreateThread(function()
    while true do
        TriggerEvent('esx_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('esx_status:getStatus', 'thirst', function(thirst)

                local myhunger = hunger.getPercent()
                local mythirst = thirst.getPercent()

                SendNUIMessage({
                    action = "updateStatusHud",
                    show = true,
                    hunger = myhunger,
                    thirst = mythirst
                })
            end)
        end)
        Citizen.Wait(5000)
    end
end)

--- ATUALIZA A VIDA, COLETE, OXIGENIO E RESPIRACAO A CADA 1 MS

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        local player = PlayerPedId()
        local health = (GetEntityHealth(player) - 100)
        local armor = GetPedArmour(player)
        local oxy = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
        local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId())

        SendNUIMessage({
            action = 'updateStatusHud',
            show = true,
            health = health,
            armour = armor,
            oxygen = oxy,
            stamina = stamina,
			clock = true,
			showclock = curTime
        })
        Citizen.Wait(200)
    end
end)

-- CALCULA HORAS DO SERVIDOR
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1500)
		
		hour = GetClockHours()
		minute = GetClockMinutes()
		
		if minute <= 9 then
			minute = "0" .. minute
		end
		
		if hour <= 9 then
			hour = "0" .. hour
		end
		
		curTime = hour..':'..minute
	end
end)

--- SE FOR PRESSIONADO O ESC DESATIVA O HUD DO CARRO / DESATIVA NATIVOS DO GTA 5 / ATIVA OU DESATIVA RADAR DEPENDENDO DA TOGHUD - ATUALIZA A CADA 1MS

Citizen.CreateThread(function()

    local isPauseMenu = false

	while true do
		Citizen.Wait(1)

		if IsPauseMenuActive() then -- ESC Key
			if not isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'car', show = false })
			end
		else
			if isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'car', show = true })
			end
		end
		
		
		if toghud == true then
            DisplayRadar(1)
        else
            DisplayRadar(0)
        end
		
		
	end
end)
