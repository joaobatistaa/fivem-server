exports('GiveKeysAuto', function()
    GiveKeysAuto()
end)

exports('GetKeyAuto', function()
    return GetKeyAuto()
end)

exports('RemoveKeysAuto', function()
    RemoveKeysAuto()
end)

exports('GiveKeys', function(plate, model)
    GiveKeys(plate, model)
end)

exports('RemoveKeys', function(plate, model)
    RemoveKeys(plate, model)
end)

exports('GetKey', function(plate)
    return GetKey(plate)
end)

exports('OpenCar', function(plate, model)
    OpenCar(plate, model)
end)

exports('CloseCar', function(plate, model)
    CloseCar(plate, model)
end)