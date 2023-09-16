Config = Config or {}
CraftingItems = CraftingItems or {}


--███████╗██╗░░░██╗███╗░░██╗░█████╗░████████╗██╗░█████╗░███╗░░██╗░██████╗
--██╔════╝██║░░░██║████╗░██║██╔══██╗╚══██╔══╝██║██╔══██╗████╗░██║██╔════╝
--█████╗░░██║░░░██║██╔██╗██║██║░░╚═╝░░░██║░░░██║██║░░██║██╔██╗██║╚█████╗░
--██╔══╝░░██║░░░██║██║╚████║██║░░██╗░░░██║░░░██║██║░░██║██║╚████║░╚═══██╗
--██║░░░░░╚██████╔╝██║░╚███║╚█████╔╝░░░██║░░░██║╚█████╔╝██║░╚███║██████╔╝
--╚═╝░░░░░░╚═════╝░╚═╝░░╚══╝░╚════╝░░░░╚═╝░░░╚═╝░╚════╝░╚═╝░░╚══╝╚═════╝░

Config.Framework = 'esx' -- Set 'esx' or 'qb'.

-- NOTE: If you are using second job you should add the event at the end of the code here and add the check you want on the function below
function IsPlayerAuthorized(data) -- Do not edit this if you don't know what you're doing
    if data.isjob then
        if GetJobName() == data.isjob or GetGang() == data.isjob then
            if data.grades == 'all' then
                return true
            else
                for k,v in pairs(data.grades) do
                    if GetJobGrade() == v or GetGangLevel() == v then
                        return true
                    end
                end
            end
        end
    else
        return true
    end
    return false
end

--██╗░░░██╗██╗░██████╗██╗░░░██╗░█████╗░██╗░░░░░
--██║░░░██║██║██╔════╝██║░░░██║██╔══██╗██║░░░░░
--╚██╗░██╔╝██║╚█████╗░██║░░░██║███████║██║░░░░░
--░╚████╔╝░██║░╚═══██╗██║░░░██║██╔══██║██║░░░░░
--░░╚██╔╝░░██║██████╔╝╚██████╔╝██║░░██║███████╗
--░░░╚═╝░░░╚═╝╚═════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝

Config.Marker = { --Modify the Stash marker as you like.
    enablemarker = true,
    type = 2, 
    scale = {x = 0.2, y = 0.2, z = 0.1}, 
    colour = {r = 71, g = 181, b = 255, a = 120},
    movement = 1 --Use 0 to disable movement.
}

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end