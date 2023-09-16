Config.Framework = 'ESX' -- Set 'ESX' or 'QBCore'.

Config.CustomFrameworkExport = true -- Do you want to add your own export?
function CustomFrameworkExport() -- Add the export here, as in the following example.
    ESX = exports["es_extended"]:getSharedObject()
    -- QBCore = exports['qb-core']:GetCoreObject()
end

-- ESX Config.
Config.getSharedObject = 'esx:getSharedObject' -- Modify your ESX-based framework here.

-- QBCore Config.
Config.QBCoreGetCoreObject = 'qb-core' -- Choose the name of your qb-core export.