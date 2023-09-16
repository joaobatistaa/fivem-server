Config = Config or {}
Locales = Locales or {}

--░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░
--██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░
--██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░
--██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░
--╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗
--░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝

Config.Framework = "esx" -- 'esx' or 'qb'
Config.Language = "pt" -- Set your lang in locales folder
Config.SkinScript = "esx_skin" -- qb-clothing
Config.Menu = 'esx_menu_default' -- 'qb-menu'

-- which slots are your hot bar
Config.Hotbar = {
     1, 2, 3, 4, 5
}

Config.duration = {
     open = 1, --sec
     close = 1
}

Config.PasswordLength = {
     min = 3,
     max = 5
}

Config.Animation = {
     close = { -- Animation when close the backpack
          Dict = 'clothingshirt',
          Anim = 'try_shirt_positive_d',
          Flag = 49
     },

     open = { -- Animation when Open the backpack
          Dict = 'clothingshirt',
          Anim = 'try_shirt_positive_d',
          Flag = 49
     },

     inBackpack = {
          Dict = 'clothingshirt',
          Anim = 'try_shirt_positive_d',
     }
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

function Progressbar(name, label, duration, useWhileDead, canCancel, disableControls, animation, prop, propTwo, onFinish,onCancel)
     exports['progressbar']:Progress({
          name = name:lower(),
          duration = duration,
          label = label,
          useWhileDead = useWhileDead,
          canCancel = canCancel,
          controlDisables = disableControls,
          animation = animation,
          }, function(cancelled)
          if not cancelled then
               if onFinish ~= nil then
                    onFinish()
               end
          else
               if onCancel ~= nil then
                    onCancel()
               end
          end
     end)
end