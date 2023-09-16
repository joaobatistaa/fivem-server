RegisterNetEvent("Johnny_Trucker:Notify")
AddEventHandler("Johnny_Trucker:Notify", function(type,msg)
	if type == "negado" then
		exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..msg.."</span>!", 5000, 'error')
    elseif type == "importante" then
		exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>"..msg.."</span>!", 5000, 'info')
    elseif type == "sucesso" then
        exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>"..msg.."</span>!", 5000, 'success')
    end
end)

function DrawText3D2(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function spawnVehicle(name,x,y,z,h,vehbody,vehengine,vehtransmission,vehwheels,blip_sprite,blip_color,blip_name)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		nveh = CreateVehicle(mhash,x,y,z+0.5,h,true,false)
		local netveh = VehToNet(nveh)

		Citizen.InvokeNative(0xAD738C3085FE7E11,NetToVeh(netveh),true,true)
		Citizen.InvokeNative(0xAD738C3085FE7E11,nveh,true,true)
		SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)
		SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
		SetModelAsNoLongerNeeded(mhash)
		SetVehicleDoorsLocked(nveh,1)
		SetVehicleDoorsLocked(NetToVeh(netveh),1)
		SetVehicleNumberPlateText(NetToVeh(netveh),Lang[Config.lang]['truck_plate'])

		if (vehwheels < 400) then
			local arr = {0,1,2,3,4,5,45,47}
			for k,v in pairs(arr) do
				SetVehicleTyreBurst(nveh,v,true,1000)
			end
		end

		SetVehicleEngineHealth(nveh,vehengine+0.0)
		SetVehicleBodyHealth(nveh,vehbody+0.0)
		SetVehicleFuelLevel(nveh,100.0)
		--DecorSetFloat(nveh, "_FUEL_LEVEL", GetVehicleFuelLevel(nveh))
		exports["Johnny_Combustivel"]:SetFuel(nveh, 100)
	
		blip = AddBlipForEntity(nveh)
		SetBlipSprite(blip,blip_sprite)
		SetBlipColour(blip,blip_color)
		SetBlipAsShortRange(blip,false)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(blip_name)
		EndTextCommandSetBlipName(blip)
	end
	return nveh,blip
end