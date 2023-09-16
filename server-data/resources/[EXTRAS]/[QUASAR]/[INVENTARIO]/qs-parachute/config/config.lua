Config = {}

Config.Framework = 'esx' -- Set 'esx' or 'qb'.
Config.Language = "en" --You can choose between 'en', 'es' or create your own language.

Config.ParachuteItem = 'parachute' -- Name of item
Config.ResetParachute = 'paraquedas' -- Name of the command to remove your parachute.
Config.ParachuteType = 1 -- Type of parachute that you will have on your back.

Config.Progressbar = { -- Times of the progressbar.
    ['UseParachute'] = 5000, -- Use parachute.
    ['ResetParachute'] = 5000, -- Remove parachute.
}

Config.Languages = { --You can copy one of these translations and create your own with another language.
    ['en'] = {
        ["PARACHUTE_NO_PARACHUTE"] = "Não tens um paraquedas equipado!",
        ["PARACHUTE_USE_PARACHUTE"] = "A equipar paraquedas...",
        ["PARACHUTE_RESET_PARACHUTE"] = "A retirar paraquedas...",
        ["PARACHUTE_ALREADY_HAVE_PARACHUTE"] = "Já tens um paraquedas!",
    },
    ['es'] = {
        ["PARACHUTE_NO_PARACHUTE"] = "¡No tienes un paracaidas equipado!",
        ["PARACHUTE_USE_PARACHUTE"] = "Equipando paracaidas...",
        ["PARACHUTE_RESET_PARACHUTE"] = "Quitando paracaidas...",
        ["PARACHUTE_ALREADY_HAVE_PARACHUTE"] = "Ya tienes un paracaidas!",
    },
}

function SendTextMessage(msg, type)
    if type == 'inform' then 
        exports['Johnny_Notificacoes']:Alert("INFORMAÇÃO", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, 'info')
    end
    if type == 'error' then 
        exports['Johnny_Notificacoes']:Alert("ERRO", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, 'error')
    end
    if type == 'success' then 
        exports['Johnny_Notificacoes']:Alert("SUCESSO", "<span style='color:#c7c7c7'>"..msg.."</span>", 5000, 'success')
    end
end

function Progresbar(id, label, time, state)
    exports['progressbar']:Progress({
        name = id,
        duration = time,
        label = label,
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
    }, function(status)
        if status then
            if state == 'put' then
                giveParachute()
            elseif state == 'out' then
                removeParachute()
            end
        end
    end)
end

