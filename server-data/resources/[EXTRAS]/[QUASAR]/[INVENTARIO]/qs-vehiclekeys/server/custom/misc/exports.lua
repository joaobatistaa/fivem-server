exports('GiveKeysServer', function(player, plate, model)
    GiveKeysServer(player, plate, model)
end)

exports('RemoveKeysServer', function(player, plate, model)
    RemoveKeysServer(player, plate, model)
end)

exports('GetKeyServer', function(player, plate)
    return GetKeyServer(player, plate)
end)