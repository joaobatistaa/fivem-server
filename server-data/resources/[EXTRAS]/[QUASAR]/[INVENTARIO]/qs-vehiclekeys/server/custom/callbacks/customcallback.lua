RegisterServerCallback('keys:CustomCallback', function(source, cb)
    local src = source
    local Player = GetPlayerFromIdFramework(src)
    local Item = 'lockpick'
    if GetItem(Player, Item) then
        if GetItemCount(Player, Item) > 0 then
            cb(true)
        end
    end
    cb(false)
end)