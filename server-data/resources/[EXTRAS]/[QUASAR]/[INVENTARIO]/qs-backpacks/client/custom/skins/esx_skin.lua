if Config.SkinScript ~= 'esx_skin' then
    return
end

function putClothes(backpack)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
         if skin.sex == 0 then
              TriggerEvent(Config.SkinChanger, skin, backpack.cloth.male)
         elseif skin.sex == 1 then
              TriggerEvent(Config.SkinChanger, skin, backpack.cloth.female)
         end
    end)
end

function RemoveClothes()
    local cloth = {
         male = { ['bags_1'] = 0 },
         female = { ['bags_1'] = 0 },
    }
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
         if skin.sex == 0 then
              TriggerEvent('skinchanger:loadClothes', skin, cloth.male)
              elseif skin.sex == 1 then
              TriggerEvent('skinchanger:loadClothes', skin, cloth.female)
         end
    end)  
end