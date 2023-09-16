--[[  
    Store setup!
    Now we have some news here, such as a new system for 
    the sale of items, you can configure all this here.

    You will also find the vending system and little else :)
]]

Config.SellItems = {
    --[[
	['Seller item'] = {
        coords = vec3(2690.6674804688, 3298.1196289063, 55.603000640869),
        blip = {
            -- https://docs.fivem.net/docs/game-references/blips/
            active = true,
            name = 'Seller',
            sprite = 89,
            color = 1,
            scale = 0.5
        },
        items = {
            {
                name = 'sandwich',
                price = 15,
                amount = 1,
                info = {},
                type = 'item',
                slot = 1
            },
            {
                name = 'tosti',
                price = 25,
                amount = 1,
                info = {},
                type = 'item',
                slot = 2
            },
        }
    }
	--]]
}