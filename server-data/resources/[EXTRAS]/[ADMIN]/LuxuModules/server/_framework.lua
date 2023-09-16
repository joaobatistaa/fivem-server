FrameworkObj, QBCore, ESX = nil, nil, nil
Luxu = {}
Luxu.utils = Lutils

local function GenerateFrameworkObject()
      local prom = promise.new()
      local OBJ

      if Config.Framework == 'qb' then
            OBJ = exports['qb-core']:GetCoreObject()
            prom:resolve(OBJ)
      elseif Config.Framework == 'esx' then
            if Config.ESX_Version == 'new' then
                  OBJ = exports["es_extended"]:getSharedObject()
                  prom:resolve(OBJ)
            elseif Config.ESX_Version == 'old' then
                  TriggerEvent(Config.ESX_GetSharedObjectEvent, function(obj) prom:resolve(obj) end)
            end
      end
      return Citizen.Await(prom)
end

CreateThread(function()
      FrameworkObj = GenerateFrameworkObject()
      QBCore = FrameworkObj
      ESX = FrameworkObj
end)
