Config = {}

Config.Debug = false

Config.Framework = 'ESX' -- ESX / QB / STANDALONE

Config.UseNewStaffCheckMethod = false -- **QBCORE and ESX ONLY** true = will check if a player is staff in another way (this could fix problems with /reports command)

Config.QBPermissionsUpdate = false -- **QBCORE ONLY** - set it to true if you have the latest Permissions update

Config.ReportCommand = 'report' -- command for players to create a report

Config.AdminReportCommand = 'reports' -- command for admins to check the reports

Config.NotificationToggleCommand = 'notireports' -- command to toggle the notifications

Config.UseSteamNames = true -- Uses the steam names insted of game names

Config.SaveRespondedReports = true -- This will save how many reports the admins complete in the database (for this you need to use the sql file and set your sql script in the fxmanifest.lua)

Config.Database = 'oxmysql' -- mysql-async / oxmysql / ghmattimysql (Used if Config.SaveRespondedReports is set to true)

Config.NoAdminAssistingText = 'None'

Config.TeleportBackAfterConcluding = true

Config.NewReportNotifyType = 'STANDALONE' -- QB or STANDALONE

Config.LatestSendNotifyToAdmin = true

Config.GetAllPlayersForNotify = false

Config.ReportCategoriesTranslation = { -- Translate report categories
	player = "REPORTAR JOGADOR",
	bug = "BUG",
	question = "QUESTÃO"
}

Config.AdminGroups = { -- Used for ESX and QB
	'superadmin',
	'admin',
	'mod'
}

-- Used to set the admins when using the STANDALONE version
-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.StandaloneStaffIdentifiers = { 
	'license:9asg8d9812g3989as8dy8912398123y89123y221', -- Example, change this
	'license:09asyhhdh8912h389asgdhh912g389asgd98y123' -- Example, change this
}

Config.Notifications = {
    ['success_rep'] = {title = 'REPORT', text = 'Criaste um report com sucesso', time = 5000, type = 'success'},
    ['adm_answered'] = {title = 'REPORT', text = 'Um Staff chegou para atender o teu report', time = 5000, type = 'info'},
    ['player_answered'] = {title = 'REPORT', text = '#${id} - ${name} criou um report', time = 5000, type = 'info'},
    ['adm_assist'] = {title = 'REPORT', text = 'Um Staff está a atender o teu report', time = 5000, type = 'info'},
    ['rep_concluded'] = {title = 'REPORT', text = 'O teu report foi concluido', time = 5000, type = 'success'},
    ['rep_canceled'] = {title = 'REPORT', text = 'Cancelaste o teu report', time = 5000, type = 'error'},
    ['adm_rep_concluded'] = {title = 'REPORT', text = 'O Report #${id} foi concluído', time = 5000, type = 'success'},
    ['new_rep'] = {title = 'REPORT', text = 'Novo report criado!', time = 5000, type = 'info'},
    ['rep_not_on'] = {title = 'REPORT', text = 'Ativaste as notificações de reports!', time = 5000, type = 'success'},
    ['rep_not_off'] = {title = 'REPORT', text = 'Desativaste as notificações de reports!', time = 5000, type = 'error'},
    ['rep_not_exist'] = {title = 'REPORT', text = 'Este report não existe!', time = 5000, type = 'error'},
}

Config.CommandSuggestions = {
    ['report'] = {text = 'Comando para criar ou verificar o teu report'},
    ['adm_report'] = {text = 'Comando para verificar reports abertos'},
    ['adm_notifications'] = {text = 'Comando para ativar/desativar notificação de novos reports'},
}

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to webhook.lua, line 1

Config.BotName = 'Johnny Logs' -- Write the desired bot name

Config.ServerName = 'WorldTuga RP' -- Write your server's name

Config.IconURL = 'https://i.ibb.co/nc4tBJD/1648138277565.jpg' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

Config.ReportTitle = 'REPORT'

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.playerReportWebhookColor = '65280'

Config.bugReportWebhookColor = '16711680'

Config.questionReportWebhookColor = '49151'

Config.playerWebhookColor = '255'

Config.adminWebhookColor = '16746240'

Config.WebhookMessages = {
    -- Player
    ['player_report'] = {action = 'Abriste report'},
    ['bug_report'] = {action = 'Abriu um report'},
    ['question_report'] = {action = 'Abriu um report'},
    ['p_cancel_report'] = {action = 'Cancelaste um report', type = 'Report #${id}'},
    ['p_answer_report'] = {action = 'Report criado pelo jogador', type = 'Report #${id}'},

    -- Admin
    ['a_answer_report'] = {action = 'Report atendido pelo Staff', type = 'Report #${id}'},
    ['a_bring_report'] = {action = 'Staff deu bring ao jogador', type = 'Report #${id}'},
    ['a_goto_report'] = {action = 'Staff foi para o jogador', type = 'Report #${id}'},
    ['a_closed_report'] = {action = 'O Staff fechou um Report', type = 'Report #${id}'},
}