RegisterNetEvent('inventory:client:OpenInventory', function(PlayerAmmo, inventory, other)
    inventory = exports['qs-inventory']:FormatItemsToInfo(inventory)
    if not IsEntityDead(PlayerPedId()) then
        ToggleHotbar(false)
        SetNuiFocus(true, true)
        DisableIdleCamera(true)
        SetPedCanPlayAmbientAnims(PlayerPedId(), false)
        SetResourceKvp("idleCam", "off")

        if other then
            currentOtherInventory = other.name
            SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
        end

        TriggerServerCallback('inventory:server:SetPlayerInfo', function(userName, money, blackMoney, bank)
            DebugPrint("Money:", money, "Bank:", bank, "Black money or Crypto:", blackMoney)

            local hungerValue = hunger
            local thirstValue = thirst
            if Config.Framework == 'qb' then
                local data = GetPlayerData()
                hungerValue = data.metadata and data.metadata.hunger
                thirstValue = data.metadata and data.metadata.thirst
            end

            SendNUIMessage({
                action = "open",
                inventory = inventory,
                slots = Config.InventoryWeight.slots,
                other = other,
                maxweight = Config.InventoryWeight.weight,
                Ammo = PlayerAmmo,
                maxammo = Config.MaximumAmmoValues,
                playerName = userName,
                logo = Config.Logo,
                openAnimation = Config.OpenInventoryAnim,
                optionClothes = Config.InventoryOptions.clothes,
                optionConfiguration = Config.InventoryOptions.configuration,
                optionHealth = Config.InventoryOptions.health,
                optionArmor = Config.InventoryOptions.armor,
                optionHunger = Config.InventoryOptions.hunger,
                optionThirst = Config.InventoryOptions.thirst,
                optionId = Config.InventoryOptions.id,
                optionMoney = Config.InventoryOptions.money,
                optionBank = Config.InventoryOptions.bank,
                optionBlackMoney = Config.InventoryOptions.blackmoney,
                playerhp = GetEntityHealth(PlayerPedId()),
                playerarmor = GetPedArmour(PlayerPedId()),
                playerhunger = hungerValue,
                playerthirst = thirstValue,
                playerId = GetPlayerServerId(PlayerId()),
                playerMoney = money,
                playerBank = bank,
                playerBlackMoney = blackMoney,
                notStolenItems = Config.notStolenItems,
                notStoredStashItems = Config.notStoredStashItems,
                labelChanger = Config.LabelChange
            })

        end, GetPlayerServerId(PlayerId()))

        inInventory = true

        if not Config.Handsup then return end
        checkPlayerRobbery(other)
    end
end)