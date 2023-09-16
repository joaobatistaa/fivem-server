Config = {}
Locales = Locales or {}

Config.Framework = 'esx' -- 'esx' or 'qb'

Config.Language = 'en'

function VehicleKeys(veh) -- Use this function in case of using vehiclekeys, otherwise empty it.
    --TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
	exports['qs-vehiclekeys']:GiveKeysAuto()
end

Config.Blips = { -- Configure your blips here.
    enable = true,
    sprite = 379,
    scale = 0.65,
    color = 3,
}

Config.Marker = {
    enable = true,
    type = 20,
    scaleX = 0.7,
	scaleY = 1.0,
	scaleZ = 0.3,
	red = 255,
	green = 255,
	blue = 255,
	alpha = 100,
    bobUpAndDown = false,
    faceCamera = false,
    rotate = true,
}

Config.RentelVehicles = {
	['tribike3'] = { ['model'] = 'tribike3', ['label'] = 'Tribike', ['price'] = 200, ['icon'] = 'fas fa-biking' },
	['bmx'] = { ['model'] = 'bmx', ['label'] = 'BMX', ['price'] = 300, ['icon'] = 'fas fa-biking' },
    --['panto'] = { ['model'] = 'panto', ['label'] = 'Panto', ['price'] = 250, ['icon'] = 'fas fa-car' },
	--['rhapsody'] = { ['model'] = 'rhapsody', ['label'] = 'Rhapsody', ['price'] = 300, ['icon'] = 'fas fa-car' },
	--['felon'] = { ['model'] = 'felon', ['label'] = 'Felon', ['price'] = 400, ['icon'] = 'fas fa-car' },
	--['bagger'] = { ['model'] = 'bagger', ['label'] = 'Bagger', ['price'] = 400, ['icon'] = 'fas fa-motorcycle' },
    --['biff'] = { ['model'] = 'biff', ['label'] = 'Biff', ['price'] = 500, ['icon'] = 'fas fa-truck-moving' },
}

Config.RentelLocations = {
    ['Courthouse Paystation'] = {
        ['coords'] = vector4(125.5869, -896.135, 30.148599, 166.04177)
    },
    ['Train Station'] = {
        ['coords'] = vector4(-239.324, -988.390, 29.288, 189.20266723633)
    },
    ['Bus Station'] = {
        ['coords'] = vector4(416.98699, -641.6024, 28.500173, 90.011344)
    },    
    ['Morningwood Blvd'] = {
        ['coords'] = vector4(-1274.631, -419.1656, 34.215377, 209.4456)
    },    
    ['South Rockford Drive'] = {
        ['coords'] = vector4(-682.9262, -1112.928, 14.525076, 37.729667)
    },    
    ['Tinsel Towers Street'] = {
        ['coords'] = vector4(-716.9338, -58.31439, 37.472839, 297.83691)
    }        
}