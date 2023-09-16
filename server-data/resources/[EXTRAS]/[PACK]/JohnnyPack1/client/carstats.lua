local VehicleLimit = {
    [0] = 40000, --Compact
    [1] = 40000, --Sedan
    [2] = 60000, --SUV
    [3] = 40000, --Coupes
    [4] = 30000, --Muscle
    [5] = 40000, --Sports Classics
    [6] = 25000, --Sports
    [7] = 25000, --Super
    [8] = 10000, --Motorcycles
    [9] = 60000, --Off-road
    [10] = 150000, --Industrial
    [11] = 70000, --Utility
    [12] = 120000, --Vans
    [13] = 0, --Cycles
    [14] = 50000, --Boats
    [15] = 20000, --Helicopters
    [16] = 0, --Planes
    [17] = 40000, --Service
    [18] = 40000, --Emergency
    [19] = 0, --Military
    [20] = 80000, --Commercial
    [21] = 0 --Trains
}

RegisterNetEvent('carstats')
AddEventHandler('carstats', function()
local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsIn(ped, false)
		local model = GetEntityModel(veh, false)
		local hash = GetHashKey(model)
		local nomecarro = GetDisplayNameFromVehicleModel(model)
		local class = GetVehicleClass(veh)
		local modCount = GetNumVehicleMods(veh, 12)
		if modCount > 1 then motor = "Disponíveis" else motor = "Limitadas" end
		TriggerEvent('chatMessage', "CARRO", {255, 0, 0}, "^3Nome:^7 ".. nomecarro)
		TriggerEvent('chatMessage', "CARRO", {255, 0, 0}, "^3Lugares:^7 ".. GetVehicleMaxNumberOfPassengers(veh) + 1)
		TriggerEvent('chatMessage', "CARRO", {255, 0, 0}, "^3Bagageira:^7 ".. VehicleLimit[class] / 1000 .."kg")
		TriggerEvent('chatMessage', "CARRO", {255, 0, 0}, "^3Modificações:^7 "..motor)
	end
end)

function round(num, numDecimalPlaces)
  local mult = 100^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end