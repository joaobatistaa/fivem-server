Config.PermissionsType = 'everyone' -- or licence ONLY CAN USE ONE

---@param If Config.PermissionsType = 'job' 
Config.Jobs = {
	"mechanic"
}

---@param If Config.PermissionsType = 'licence' 
Config.WhitelistedCreators = {
    "steam:110000115708986",
}

function CheckPlayerPermissions(id)
    local havePermissions = false
    if Config.PermissionsType == 'job' then ---@param For job permissions
        for o,p in ipairs(Config.Jobs) do
            print(p, PlayerJob(id))
            if p == PlayerJob(id) then 
                havePermissions = true
                break
            end
        end
    elseif Config.PermissionsType == 'licence' then 
        for o,p in ipairs(Config.WhitelistedCreators) do
            for k,v in ipairs(GetPlayerIdentifiers(id)) do
                if v == p then 
                    havePermissions = true
                    break
                end
            end
        end
	elseif Config.PermissionsType == 'everyone' then 
		havePermissions = true
    else 
        print('Bad config')
    end
    return havePermissions
end

