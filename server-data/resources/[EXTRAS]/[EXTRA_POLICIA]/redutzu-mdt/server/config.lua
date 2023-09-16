ESX = exports['es_extended']:getSharedObject()
Config = Config or {}

-- If you want other jobs to be able to access the MDT, add it to the list below;
-- Example: { 'police', 'lawyer' }
Config.WhitelistedJobs = { 'police' }

-- If you are not using one of the following scripts, you can leave the default value: default
Config.PhoneScript = 'quasar-phone' -- default, quasar-phone, high-phone, road-phone, lb-phone, gksphone

-- If you are not using one of the following scripts, you can leave the default value: default
-- If you want to disable this feature set the value to: none
Config.HousingSystem = 'quasar-housing' -- default (esx-property 2.0) | esx-property-old (The old one) | quasar-housing | loaf-housing | mf-housing | bcs_housing | myProperties | b-housing

-- If you don't find your dispatch script above, set the value to none
Config.DispatchSystem = 'cd_dispatch' -- none, quasar-phone, linden_outlawalert, cd_dispatch, road-phone

-- If you are not using one of the following scripts, you can set the value to none
Config.LicenseSystem = 'default' -- none, default, bcs_license

-- Enable this if you want to open the MDT using a command
Config.Command = {
    Enabled = false,
    Name = 'mdt',
    Description = 'Abrir o Tablet da Polícia'
}

-- Enable this if you want to open the MDT using an item
Config.Item = {
    Enabled = true,
    Name = 'police_mdt'
    -- If you are using ox_inventory, go to ox_inventory/data/items.lua and add the item there
    -- If you are using the default esx inventory, go to the database and add the item to the items table
}

-- Enable this if you want to open the MDT using a keybind
Config.Keybind = {
    Enabled = false,
    Key = 'J'
}

-- Fines settings
Config.Fines = {
    Enabled = true, -- If you want to use the fine system, set this to true
    Society = 'society_police', -- The society that will receive the fines
    Percent = 70, -- Percentage of the fine that goes to the society
    UseCustomFunction = true, -- If you want to use a custom function to pay the fine, set this to true
    -- ! This is an example of a custom function, you can use it as a reference ! --
    CustomFunction = function(online, identifier, amount, data, creator) -- Custom function to handle the fine 
        if online then -- If the player is online, you can use ESX functions
            local player = ESX.GetPlayerFromIdentifier(identifier)

            if player then
                --player.removeMoney(amount)
				TriggerEvent('okokBilling:CreateCustomInvoice', player.source, amount, 'Incidente - ' .. data.name, 'PSP', 'society_police', 'PSP')
            end
        else
            -- Database updates
        end
    end
}

-- Charges settings
-- By default it uses esx_extendedjail but you can use a custom function
Config.Charges = {
    UseCustomFunction = false, -- If you want to use a custom function to jail the player, set this to true
    -- ! This is an example of a custom function, you can use it as a reference ! --
    CustomFunction = function(online, identifier, months, data, creator) -- Custom function to handle the charges
        if online then -- If the player is online, you can use ESX functions
            local player = ESX.GetPlayerFromIdentifier(identifier)

            if player then
				TriggerClientEvent("esx-qalle-jail:jailPndscfhwechtnbuoiwperylayer", player, months)
				
				MySQL.Async.execute("UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
					{
						['@identifier'] = identifier,
						['@newJailTime'] = tonumber(months)
					}
				)
            end
        else
			playerID = GetPlayerFromIdentifier(identifier)
			
			--TriggerClientEvent("esx-qalle-jail:jailPndscfhwechtnbuoiwperylayer", playerID, months)
			
			MySQL.Async.execute("UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
				{
					['@identifier'] = identifier,
					['@newJailTime'] = tonumber(months)
				}
			)
			
        end
    end
}

-- I highly recommend not modifying if you don't know what you're doing
Config.Tables = {
    -- Players
    ['players'] = 'users',
    ['cops'] = 'users',
    ['citizen'] = 'users',
    ['job'] = 'jobs',
    ['grade'] = 'job_grades',
    ['licenses'] = 'user_licenses',

    -- Vehicles
    ['vehicles'] = 'owned_vehicles',
    ['vehicle'] = 'owned_vehicles',

    -- Incidents / Evidences / Warrants / Fines / Codes / Charges
    ['incidents'] = 'mdt_incidents',
    ['incident'] = 'mdt_incidents',
    ['evidences'] = 'mdt_evidences',
    ['evidence'] = 'mdt_evidences',
    ['warrants'] = 'mdt_warrants',
    ['warrant'] = 'mdt_warrants',
    ['fines'] = 'mdt_fines',
    ['fine'] = 'mdt_fines',
    ['codes'] = 'mdt_codes',
    ['code'] = 'mdt_codes',
    ['charges'] = 'mdt_jail',
    ['charge'] = 'mdt_jail',
    ['jail'] = 'mdt_jail',

    -- Other
    ['announcements'] = 'mdt_announcements',
    ['announcement'] = 'mdt_announcements'
}

-- Should not be modified!
Config.Queries = {
    -- Players
    ['search:players'] = 'CONCAT(firstname, \' \', lastname) LIKE :query OR phone_number LIKE :query',
    ['search:citizen'] = 'identifier = :query',
    ['search:cops'] = '(CONCAT(firstname, \' \', lastname) LIKE :query OR phone_number LIKE :query)',
   
    -- Licenses
    ['search:licenses'] = 'owner = :query',
    ['delete:license'] = 'owner = :owner AND type = :type',
    
    -- Vehicles
    ['search:vehicles'] = 'plate LIKE :query',
    ['search:vehicle'] = 'plate = :query',
    
    -- Incidents
    ['search:incidents'] = 'name LIKE :query',
    ['search:incident'] = 'id = :query',
    ['search:vehicle_incidents'] = 'vehicles LIKE :query',

    -- Evidences
    ['search:evidences'] = 'name LIKE :query OR id = :query',
    ['search:evidence'] = 'id = :query',

    -- Warrants
    ['search:warrants'] = 'reason LIKE :query OR id = :query',
    ['search:warrant'] = 'id = :query',
    ['search:active_warrants'] = 'done = 0',
    ['search:property_warrant'] = 'house = :query',

    -- Fines
    ['search:fines'] = 'name LIKE :query OR code LIKE :query',
    ['search:fine'] = 'id = :query',

    -- Codes
    ['search:codes'] = 'name LIKE :query OR code LIKE :query',
    ['search:code'] = 'id = :query',

    -- Charges
    ['search:charges'] = 'name LIKE :query',
    ['search:charge'] = 'id = :query',
    ['search:jail'] = 'name LIKE :query',

    -- Citizen
    ['search:citizen:incidents'] = 'players LIKE :query',
    ['search:citizen:evidences'] = 'players LIKE :query',
    ['search:citizen:warrants'] = 'players LIKE :query',
    ['search:citizen:vehicles'] = 'owner LIKE :query',
    ['search:citizen:properties'] = 'owner = :query',

    -- Announcements
    ['search:announcements'] = 'title LIKE :query OR content LIKE :query',
    ['search:announcement'] = 'id = :query'
}

Config.Columns = {
    ['incidents'] = 'id, name, createdAt',
    ['evidences'] = 'id, name, createdAt',
    ['warrants'] = 'id, reason, createdAt',
    ['announcements'] = nil,
    ['players'] = nil,
    ['licenses'] = nil,
    ['vehicles'] = 'plate',
    ['properties'] = nil,
    ['fines'] = nil,
    ['codes'] = 'id, name, createdAt',
    ['charges'] = 'id, name, createdAt'
}

if Config.PhoneScript == 'quasar-phone' then
    Config.Queries['search:players'] = 'CONCAT(firstname, \' \', lastname) LIKE :query OR charinfo LIKE :query'
    Config.Queries['search:cops'] = '(CONCAT(firstname, \' \', lastname) LIKE :query OR charinfo LIKE :query)'
elseif Config.PhoneScript == 'high-phone' then
    Config.Queries['search:players'] = 'CONCAT(firstname, \' \', lastname) LIKE :query OR phone LIKE :query'
    Config.Queries['search:cops'] = '(CONCAT(firstname, \' \', lastname) LIKE :query OR phone LIKE :query)'
elseif Config.PhoneScript == 'lb-phone' then
    Config.Queries['search:players'] = 'CONCAT(firstname, \' \', lastname) LIKE :query'
    Config.Queries['search:cops'] = '(CONCAT(firstname, \' \', lastname) LIKE :query)'
end

if Config.HousingSystem == 'esx-property-old' then
    Config.Tables['properties'] = 'properties'
    Config.Tables['property'] = 'properties'
    Config.Tables['owned_properties'] = 'owned_properties'

    Config.Queries['search:properties'] = 'label LIKE :query'
    Config.Queries['search:property'] = 'id = :query'
    Config.Queries['search:property_name'] = 'name = :query'
    Config.Queries['search:owned_property'] = 'name = :query'
    Config.Queries['search:property_owner'] = 'owner = :query'
    Config.Queries['search:multiple_properties'] = 'name IN (:query)'
elseif Config.HousingSystem == 'quasar-housing' then
    Config.Tables['properties'] = 'houselocations'
    Config.Tables['property'] = 'houselocations'
    Config.Tables['owned_properties'] = 'player_houses'

    Config.Queries['search:properties'] = 'label LIKE :query'
    Config.Queries['search:property'] = 'name LIKE :query'
    Config.Queries['search:property_name'] = 'name = :query'
    Config.Queries['search:owned_property'] = 'house = :query'
    Config.Queries['search:property_owner'] = 'identifier = :query'
    Config.Queries['search:multiple_properties'] = 'name IN (:query)'
elseif Config.HousingSystem == 'loaf-housing' then
    Config.Tables['properties'] = 'loaf_properties'
    Config.Tables['property'] = 'loaf_properties'
    Config.Tables['owned_properties'] = 'loaf_properties'

    Config.Queries['search:properties'] = 'id LIKE :query'
    Config.Queries['search:property'] = 'id = :query'
    Config.Queries['search:property_name'] = 'id = :query'
    Config.Queries['search:owned_property'] = 'name = :query'
    Config.Queries['search:property_owner'] = 'owner = :query'
elseif Config.HousingSystem == 'mf-housing' then
    Config.Tables['properties'] = 'housing_v3'
    Config.Tables['property'] = 'housing_v3'
    Config.Tables['owned_properties'] = 'housing_v3'

    Config.Queries['search:properties'] = 'JSON_VALUE(houseInfo, \'$.addressLabel\') LIKE :query'
    Config.Queries['search:property'] = 'houseId = :query'
    Config.Queries['search:property_name'] = 'JSON_VALUE(houseInfo, \'$.addressLabel\') = :query'
    Config.Queries['search:owned_property'] = 'JSON_VALUE(houseInfo, \'$.addressLabel\') = :query'
    Config.Queries['search:property_owner'] = 'JSON_VALUE(ownerInfo, \'$.identifier\') = :query'
elseif Config.HousingSystem == 'bcs_housing' then
    Config.Tables['properties'] = 'house'
    Config.Tables['property'] = 'house'
    Config.Tables['owned_properties'] = 'house_owned'

    Config.Queries['search:properties'] = 'name LIKE :query'
    Config.Queries['search:property'] = 'identifier = :query'
    Config.Queries['search:property_name'] = 'identifier = :query'
    Config.Queries['search:owned_property'] = 'identifier = :query'
    Config.Queries['search:property_owner'] = 'owner = :query'
    Config.Queries['search:multiple_properties'] = 'identifier IN (:query)'
elseif Config.HousingSystem == 'myProperties' then
    Config.Tables['properties'] = 'prop'
    Config.Tables['property'] = 'prop'
    Config.Tables['owned_properties'] = 'prop_owner'

    Config.Queries['search:properties'] = 'label LIKE :query'
    Config.Queries['search:property'] = 'id = :query'
    Config.Queries['search:property_name'] = 'name = :query'
    Config.Queries['search:owned_property'] = 'property = :query'
    Config.Queries['search:property_owner'] = 'owner = :query'
    Config.Queries['search:multiple_properties'] = 'name IN (:query)'
elseif Config.HousingSystem == 'b-housing' then
    Config.Tables['properties'] = 'housing'
    Config.Tables['property'] = 'housing'
    Config.Tables['owned_properties'] = 'housing'

    Config.Queries['search:properties'] = 'name LIKE :query'
    Config.Queries['search:property'] = 'name = :query'
    Config.Queries['search:property_name'] = 'name = :query'
    Config.Queries['search:owned_property'] = 'name = :query'
    Config.Queries['search:property_owner'] = 'owner = :query'
    Config.Queries['search:multiple_properties'] = 'name IN (:query)'
end

if Config.LicenseSystem == 'bcs_license' then
    Config.Tables['licenses'] = 'licenses'
    Config.Columns['licenses'] = 'owner, license as type'

    Config.Queries['search:licenses'] = 'owner = :query'
    Config.Queries['delete:license'] = 'owner = :owner AND license = :type'
end

-- Custom Functions
Config.Notify = function(source, message, type)
    --TriggerClientEvent('esx:showNotification', source, message, type)
	TriggerClientEvent('Johnny_Notificacoes:Alert', source, "TABLET POLÍCIA", "<span style='color:#c7c7c7'>"..message.."</span>", 5000, 'info')
end

-- Commands
Config.UseESXCommands = true -- If you want to use ESX commands, set this to true
Config.RegisterCommand = function(name, description, callback)
    if Config.UseESXCommands then
        ESX.RegisterCommand(name, 'user', function(player, args, error)
            callback(player)
        end, false, { help = description })    
    else
        RegisterCommand(name, function(source, args, raw)
            local player = ESX.GetPlayerFromId(source)
            callback(player)
        end, false)
    end
end

-- Items
Config.RegisterItem = function(name, callback)
    ESX.RegisterUsableItem(name, function(source)
        local player = ESX.GetPlayerFromId(source)
        callback(player)
    end)
end

-- ESX Functions

-- This works for ESX Legacy, If you are using an older version of ESX, you will need to change this
Config.GetPlayerName = function(player) -- player = ESX.GetPlayerFromId(source)
    return {
        firstname = player.variables.firstName,
        lastname = player.variables.lastName
    }
end

-- Permissions
Config.Permissions = {
    -- Template:
    -- [job] = { ...grades = { ...permissions } }
    ['police'] = {
        -- You can find these in the database (databse.job_grades)
        -- [grade] = { ...permissions }
        [1] = {
            'dashboard.view',
            'config.view',
            'alerts.view',
            'alerts.create',
            'alerts.take',
            'charges.view',
            'citizens.view',
            'citizens.edit',
            'codes.view',
            'evidences.view',
            'evidences.edit',
            'evidences.create',
            'fines.view',
            'houses.view',
            'incidents.view',
            'incidents.create',
            'incidents.edit',
            'officers.view',
            'vehicles.view',
            'vehicles.edit',
            'announcements.view'
        },
        -- You have the same permissions as grade 0 + these
        [2] = {
            'charges.create',
            'codes.create',
            'fines.create',
            'warrants.view',
            'warrants.create',
            'warrants.edit'
        },
        [5] = {
            'charges.edit',
            'charges.delete',
            'codes.edit',
            'codes.delete',
            'fines.edit',
            'fines.delete'
        },
        [7] = {
            'incidents.delete',
            'evidences.delete',
            'warrants.delete'
        },
        [11] = {
            'officers.edit',
            'announcements.create',
            'announcements.edit',
            'announcements.delete'
        }
    }
}

-- Discord Webhooks
Config.Webhooks = {
    -- Format: ['incidents'] = "WEBHOOK_LINK",
    -- Leave it false if you don't want to send data to discord
    ['incidents'] = 'https://discord.com/api/webhooks/1093663065205125240/T4E_XjMsDGu8HlLco2ikcPd_ms2qNkgAHf8i5WPy2dEwxa3lmZA4qgf0DDazLh0SA4tF',
    ['evidences'] = 'https://discord.com/api/webhooks/1093663157521760316/BFFSMkXwquYZMX71aV5Qf5gRHH3prRpRJ0ka5VehhnDJFE74yHuAyxuuK5nAcQDDAHEY',
    ['warrants'] = 'https://discord.com/api/webhooks/1093664112703176814/-mfmA78XioFXU21qBsd3G5IiLmGW4cIusM0aH_Phlp8ofcJ40hfTl9EFWIhNlvnBp33x',
    ['fines'] = 'https://discord.com/api/webhooks/1093662889388298270/IsI7WCk7SIMvTsCqvVPh1kBkE59vEn--2eZ0pFPKvOru7AOKSheNcFrocLynidYKeKLv',
    ['codes'] = 'https://discord.com/api/webhooks/1093664207402192896/vu5mNzb71Ht3VAgbw_J-iPytDYYG1FI2dUaGbrNps9kGDP7nuzjLmjijS3W0LL5-fUK_',
    ['charges'] = 'https://discord.com/api/webhooks/1093663608438800425/_ovSlXGUqj3LBIpcys4nwtY0w0tD-mgc3CXYVEYWMQL6RrrB2x0oXDeLR0W5UaZEN9AA',
    ['announcements'] = 'https://discord.com/api/webhooks/1093662801656021074/VPn07m3QFqR7WfnDuOn8SnUJVlJJmfiFYTAd1OynrPhZ-0PYS14Lan-ZYYCHDdSVcVL6',
    ['images'] = 'https://discord.com/api/webhooks/1093567830697464028/yhertJNrEs4zQxP6P6I1Q4-pOPap-NPWIMCSgci61_1ho1g8gVf3ub9lzwsfeYl4KW8L', -- SET THE WEBHOOK, OTHERWISE YOU WON'T BE ABLE TO TAKE PICTURES
    ['chat'] = 'https://discord.com/api/webhooks/1093662689869439067/mDH2zM8C3ISd3867uqLUtRimo4yGRDzKx8X9E3545VNde_MMUjbWwKzu2_ItRZm2MbSs'
}
