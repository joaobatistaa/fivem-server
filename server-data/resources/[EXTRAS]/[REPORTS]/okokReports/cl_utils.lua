RegisterNetEvent('okokReportsV2:Notification')
AddEventHandler('okokReportsV2:Notification', function(text, id)
    exports['Johnny_Notificacoes']:Alert(Config.Notifications[id].title, text, Config.Notifications[id].time, Config.Notifications[id].type)
end)

function createReport(category, title, description)
    TriggerServerEvent('okokReportsV2:createReport', category, title, description)
end