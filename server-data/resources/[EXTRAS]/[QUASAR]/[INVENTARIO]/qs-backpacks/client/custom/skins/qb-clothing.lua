if Config.SkinScript ~= 'qb-clothing' then
    return
end

function putClothes(backpack)
    TriggerEvent('qb-clothing:client:loadOutfit', { outfitData = backpack.cloth })
end

function RemoveClothes()
    TriggerEvent('qb-clothing:client:loadOutfit', {
         outfitData = {
              ["bag"] = { item = -1, texture = 0 }
         }
    })
end