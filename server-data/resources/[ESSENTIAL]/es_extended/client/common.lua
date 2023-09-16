exports('getSharedObject', function()
	return ESX
end)

if GetResourceState('ox_inventory') ~= 'missing' then
	Config.OxInventory = true
end

if GetResourceState('qs-inventory') ~= 'missing' then
	Config.QSInventory = true
end

AddEventHandler('esx:getSharedObject', function(cb)
  local Invoke = GetInvokingResource()
  print(('[^3WARNING^7] ^5%s^7 used ^5esx:getSharedObject^7, this method is deprecated and should not be used! Refer to ^5https://docs.esx-framework.org/tutorials/sharedevent^7 for more info!'):format(Invoke))
  cb(ESX)
end)

--AddEventHandler("esx:getSharedObject", function()
	--local Invoke = GetInvokingResource()
	--print(("[^1ERROR^7] Resource ^5%s^7 Used the ^5getSharedObject^7 Event, this event ^1no longer exists!^7 Visit https://documentation.esx-framework.org/tutorials/tutorials-esx/sharedevent for how to fix!"):format(Invoke))
--end)
