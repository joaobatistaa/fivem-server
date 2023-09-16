ESX = exports['es_extended']:getSharedObject()
Config = Config or {}

-- Alerts

Config.Alerts = {
    Blip = true,
    BlipId = 126,
    BlipColor = 38,
    BlipLabel = 'Alerta Polícia',
    BlipFadeOutRate = 25,
    BlipFadeOutInterval = 10000
}

-- Animation

Config.Animation = {
    Anim = 'amb@world_human_seat_wall_tablet@female@base',
    Prop = 'vpad_prop_1',
    BoneIndex = 28422
}

-- Functions

Config.Notify = function(message)
    --ESX.ShowNotification(message)
	exports['Johnny_Notificacoes']:Alert("TABLET POLICIA", "<span style='color:#c7c7c7'>"..message.."</span>!", 5000, 'info')
end

-- Camera / Photo

Config.CameraMinZoom = 80
Config.CameraMaxZoom = 15
Config.CameraZoomSpeed = 3
Config.CameraRotationSpeed = 10
Config.CameraProp = 'prop_pap_camera_01'
Config.CameraExitAnimation = 'amb@world_human_paparazzi@male@exit'
Config.CameraBaseAnimation = 'amb@world_human_paparazzi@male@base'

-- Screenshot

function GetImageURL(callback) -- This works for discord images (modify this if you want to use other image hosting services)
    TriggerCallback('GetImageAPI', function(data) -- This is a custom callback to get the discord webhook url
        if Config.UseDiscordImages then -- Delete this if statement if you don't want to use discord images
            exports['screenshot-basic']:requestScreenshotUpload(data.link, 'files[]', function(response)
                local data = json.decode(response) -- Decode the response to get the image url
                callback(data.attachments[1].proxy_url) -- Return the image url
            end)
        end
    end)
end