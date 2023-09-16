Config, Locales = {}, {}

Config.Debug = false -- This help find the source of a problem 

Config.OnlyUnpaidCityInvoices = true

Config.OnlyUnpaidSocietyInvoices = false

Config.EventPrefix = 'okokBilling'

Config.Locale = 'pt'

Config.DatabaseTable = 'okokbilling'

Config.OpenMenuKey = 168 -- Default 168 (F7)

Config.OpenMenuCommand = 'faturas' -- Command to open the menu

Config.InvoiceDistance = 15

Config.AllowPlayersInvoice = false -- if players can create Player to Player invoices

Config.okokRequests = false -- Player to Player invoices only, to avoid abuse

Config.UseOKOKBankingTransactions = true -- If set to true it will register the bills to okokBanking transactions

Config.AuthorReceivesAPercentage = false -- When sending a society invoice

Config.AuthorPercentage = 5 -- Percentage that the invoice author receives

Config.VATPercentage = 23

Config.SocietyReceivesLessWithVAT = false

Config.AddonAccount = true -- If set to true it will use the addon_account_data table in the database, if set to false it will use the okokBanking tables

Config.SocietyHasSocietyPrefix = true -- *Do not touch this if the resource is working correctly* If set to true it'll search for `society_police` (example) when paying a society invoice

Config.AutoDeletePaidInvoices = true -- true: Deletes unpaid invoices (to reduce lag) | false: Doesn't delete unpaid invoices.

Config.DeletePaidInvoicesEvery = 60 -- How often it should delete the unpaid invoices (in minutes)

-- Autopay

Config.UseAutoPay = false

Config.DefaultLimitDate = 7 -- Days for limit pay date

Config.CheckForUnpaidInvoicesEvery = 60 -- minutes

Config.FeeAfterEachDay = true

Config.FeeAfterEachDayPercentage = 5

-- Autopay

Config.JobsWithCityInvoices = { -- Which jobs have City Invoices (They will be allowed to delete any invoice) | Admins will have access by default
	'juiz'
}

Config.CityInvoicesAccessRanks = { -- Which jobs have City Invoices (They will be allowed to delete any invoice)
	'police', -- All of them have access
	'juiz', -- All of them have access
}

Config.AllowedSocieties = { -- Which societies can access the Society Invoices
	"police",
	"ambulance",
	"redline",
	"bahamas",
	"juiz",
	"mechanic",
	"remax",
	"vanilla",
	"pear",
	"advogado",
}

Config.InspectCitizenSocieties = { -- Which societies can access the Society Invoices
	'police'
}

Config.SocietyAccessRanks = { -- Which ranks of the society have access to Society Invoices and City Invoices
	'boss',
}

Config.BillsList = {
	['police'] = {
		{'Abuso na utilização da buzina', 2000},
		{'Passagem Linha Contínua', 2000},
		{'Paragem Ilegal', 3000},
		{'Estacionamento não', 4000},
		{'Conduzir um veículo ilegal', 4000},
		{'Obstrução da via publica ', 5000},
		{'Condução desordeira', 5000},
		{'Burnout ', 5000},
		{'Dirigir em sentido contrário ', 6000},
		{'Excesso de velocidade Média', 6000},
		{'Uso de modificações ilegais (neon/fumaça)', 6000},
		{'Uso de modificações ilegais (vidros)', 6000},
		{'Uso de modificações ilegais (rebaixamento)', 6000},
		{'Desacatos / Desordem Pública', 6000},
		{'Condução sem capacete', 6500},
		{'Barulho de motor excessivo ', 6500},
		{'Infração de sinais luminosos', 7000},
		{'Excesso de velocidade leve', 7000},
		{'Excesso de velocidade Grave', 8000},
		{'Circular com as luzes apagadas', 8000},
		{'Dirigir em sentido contrário em autoestrada', 8500},
		{'Má conservação da viatura ', 8500},
		{'Encontrado em lugar ilegal', 8500},
		{'Acidente e fuga ', 10000},
		{'Posse de arma sem licença', 10000},
		{'Furto ', 10000},
		{'Falsa declaração de identidade', 15000},
		{'Furto de um veículo', 15000},
		{'Fuga ao Fisco', 15000},
		{'Condução sem seguro rodoviário', 15000},
		{'Condução sem carta', 20000},
		{'Insultar um civil ', 20000},
		{'Falsas declarações', 20000},
		{'Tentativa de corrupção ', 25000},
		{'Posse de substâncias ilegais / dinheiro sujo', 28000},
		{'Cumplice de fuga às autoridades', 28000},
		{'Invasão de propriedade privada', 28000},
		{'Rapto a um civil ', 30000},
		{'Difamação', 30000},
		{'Agressão a um civil ', 35000},
		{'Fuga às autoridades ', 35000},
		{'Branqueamento de capitais', 35000},
		{'Tráfico de Droga em Baixa', 35000},
		{'Posse de arma branca', 35000},
		{'Tentativo de homicídio a um civil', 35000},
		{'Posse de objetos ilegais', 35000},
		{'Desrespeitar um Agente /Guarda', 40000},
		{'Obstrução a justiça', 40000},
		{'Insultar um Agente / Guarda', 40000},
		{'Destruição de Património', 40000},
		{'Destruição de Património Particular', 40000},
		{'Posse de arma ilegal', 40000},
		{'Rapto a um Agente / Guarda ', 40000},
		{'Assalto a loja ', 40000},
		{'Assalto a banco ', 45000},
		{'Associação criminosa ', 50000},
		{'Tráfico de Droga de Média', 40000},
		{'Fraude', 40000},
		{'Cumplice de tentativa de homicidio a um Agente / Guarda', 40000},
		{'Tentativa de homicídio a um Agente / Guarda', 45000},
		{'Tomada de reféns', 45000},
		{'Agressão de um Agente / Guarda', 50000},
		{'Tráfico de armas ', 50000},
		{'Tráfico de Droga em Alta', 50000},
		{'Homicídio a um civil ', 60000},
		{'Homicídio a um Agente / Guarda', 80000},
		{'Terrorismo ', 100000},

		{'Personalizada'}, -- If set without a price it'll let the players create a custom invoice (custom price)
	},
	['ambulance'] = {
		{'Transporte Médico', 2000},
		{'Tratamento Médico 1', 2500},
		{'Tratamento Médico 2', 3000},
		{'Tratamento Médico 3', 1000},
		{'Tratamento Médico 4', 1400},
		
		{'Personalizada'}
	},
	['mechanic'] = {
		{'Personalizada'}
	},
	['remax'] = {
		{'Personalizada'}
	},
	['redline'] = {
		{'Personalizada'}
	},
	['bahamas'] = {
		{'Personalizada'}
	},
	['vanilla'] = {
		{'Personalizada'}
	},
	['juiz'] = {
		{'Personalizada'}
	},
	['advogado'] = {
		{'Personalizada'}
	},
	['pear'] = {
		{'Personalizada'}
	},
}

Config.AdminGroups = {
	'superadmin',
	'admin',
}

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to sv_utils.lua, line 5

Config.BotName = 'Johnny Logs' -- Write the desired bot name

Config.ServerName = 'WorldTuga RP' -- Write your server's name

Config.IconURL = 'https://i.ibb.co/ck8hQ7g/worldtuga.png' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.CreatePersonalInvoiceWebhookColor = '65535'

Config.CreateJobInvoiceWebhookColor = '16776960'

Config.CancelInvoiceWebhookColor = '16711680'

Config.PayInvoiceWebhookColor = '65280'

-------------------------- LOCALES (DON'T TOUCH)

function _L(id) 
	if Locales[Config.Locale][id] then 
		return Locales[Config.Locale][id] 
	else 
		print('Locale '..id..' doesn\'t exist') 
	end 
end