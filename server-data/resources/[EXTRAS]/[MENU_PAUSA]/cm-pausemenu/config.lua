Config = {}

--[[---------------------------------------------------------------------------
░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░
██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░
██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░
██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░
╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗
░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝
---------------------------------------------------------------------------]]--

Config.Framework = 'esx' -- esx, newqb, oldqb or autodetect
Config.MySQL = 'oxmysql' -- oxmysql, ghmattimysql, mysql-async
Config.ReOpenPausemenu = false -- if this is enabled it'll open the pausemenu again after player opened and closed settings/map
Config.SpamCheck = true -- this option prevents players from constantly opening and closing the menu
Config.SpamCount = 2 --  This option determines how many times players can spam to open menu before the cooldown is activated
Config.BotToken = 'NzQwODg2NjQ3MjY0MTE2Nzc2.GErOuq.zrFTiqStnOL_95HxDL_c40iUuiscGlfs-QpVGc'  -- How to create a bot token https://www.youtube.com/watch?v=-m-Z7Wav-fM
Config.Theme = 'blue' -- purple, red, green, blue, white
Config.UseRegisterKeyMappingSystem = false -- if this option set to true the script will use the RegisterKeyMapping system or false will use the traditional system
--[[
    if you set the option above to true you can reference here if you want to change MenuOpenKey
    https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

    if false you can reference here to change MenuOpenKey
    https://docs.fivem.net/docs/game-references/controls/

    Note : If Config.UseRegisterKeyMappingSystem is set to true, even if you change the Config.MenuOpenKey value after logging into the server it will still be the same in-game. You can do a few things to fix this
    1- Change the script name
    This will reset the key for everyone and new key you've written in Config.MenuOpenKey will be apply to everyone

    2- Change the key from settings/keybinds/fivem
    This will be only apply to you and other players also need to change from settings

    3- Set Config.UseRegisterKeyMappingSystem to false
    This is not the recommend way because script may consume more resmon value
]]--
Config.MenuOpenKey = 200
Config.MapOpenKey = 199
Config.StoreURL = 'https://worldtuga.tebex.io/' -- URL of store button
Config.LogoURL = 'https://cdn.discordapp.com/attachments/582219191587962891/1093945141112348833/worldtugarp-bg.png'


Config.MenuOpen = function() -- This Executed when the menu is opened (useful to show hud or any other elements on the screen)
    --TriggerEvent('codem-blackhudv2:SetForceHide', true, true)
    --TriggerEvent('codem-venicehud:SetForceHide', true)
    TriggerEvent('johnny_core:toggleHud2', false)
end

Config.MenuClose = function() -- This Executed when the menu is opened (useful to hide hud again or any other elements on the screen)
    --TriggerEvent('codem-blackhudv2:SetForceHide', false, false)
    --TriggerEvent('codem-venicehud:SetForceHide', false)
	TriggerEvent('johnny_core:toggleHud2', true)
end

Config.DisplayPage = {
    ['AWARDSPAGE'] = true,
    ['BATTLEPASSPAGE'] = true,
    ['LIVECALLPAGE'] = false,
    ['OOCCHATPAGE'] = false
}


Config.Locale = {
    ["PING"] = 'Ping',
    ["CASHMONEY"] = 'Dinheiro',
    ["BANK"] = 'Banco',
    ['ONLINEPLAYER'] = 'Jogadores Online',
    ['OCCCHAT'] = 'OCC CHAT',
    ['STORE'] = 'LOJA',
    ['WELCOME'] = 'Bem vindo',
    ['ROLEPLAY'] = 'Estás a jogar à ',
    ['CLAIMYOURDAILY'] = 'Resgata a tua recompensa diária!',
    ['DAY'] = 'Dia',
    ['VIEWALLAWARDS'] = 'Ver todas as recompensas',
    ['BATTLEPASS'] = 'Passe de Batalha',
    ['VIEWYOURPROGRESS'] = 'Ver o teu progresso',
    ["TYPE_SOMETHING"] = 'Escreve algo para o Chat [ OOC ]...',
    ["XP_REQUIRED"] = 'XP necessário para o próximo nível.',
    ["LEVEL"] = 'Nível',
    ["ENTER_TBX_ID"] = 'Por favor, indica o tbx-id aqui...',
    ["CLICK_ITEM"] = 'Clica no item para resgatar!',
    ["LV"] = 'Nvl.',
    ["REQUIRED"] = 'Necessário!',
    ["EXPIRED"] = 'Expirado',
    ["CLAIMED"] = 'Resgatada',
    ["EXITED"] = 'Saiu',

    ['BATTLEPASSPROGRESS'] = 'Progresso do Passe de Batalha',
    ['DAYSLEFT'] = 'Dias restantes',
    ['CONTACTLIVEASSISTAN'] = 'Chat ao Vivo com Staff',
    ['ADMINSAREONLINE'] = 'Staff Online',
    ['CREATECALL'] = 'Criar Chamada',
    ['CALL'] = 'Chamada',
    ['PATCHNOTES'] = 'Notas de Atualização',
    ['UPDATE'] = 'Atualização',
    ['BATTLEPASSTEXT'] = '20 min em jogo vale',
    ['1000XP'] = '1000 XP',
    ['BATTLEPASSMISSION'] = 'Missões do Passe',
    ['GOBACK'] = 'Voltar',
    ['MISSIONAWARD'] = 'Recompensa da Missão',
    ['TEBEXLINK'] = 'O teu tbx-id vai para o teu e-mail vinculado ao Tebex. Verifica o e-mail e encontra o tbx-id. Depois copia e cola aqui...',
    ['SURETEXT'] = 'Tenho a certeza que pretendo comprar este conteúdo do jogo. Eu aceito as políticas.',
    ['ALREADYTEXT'] = 'O Passe de Batalha está grátis.',
    ['FREE'] = 'Grátis',
    ['PREMIUM'] = 'Premium',

    ['UNLOCK_BATTLEPASS'] = 'Comprar Passe de Batalha',
    ['ALREADYUNLOCKED'] = 'Já tens o Passe de Batalha',
    ['UNLOCKED'] = 'Desbloqueado',
    ['READ_LESS'] = 'Ver menos',
    ['READ_MORE'] = 'Ver mais',

    ['ALLDAILYAWARDS'] = 'Recompensas Diárias',
    ['WELCOMETOLIVE'] = 'Bem vindo ao Chat de Assistência',
    ['SEND'] = 'Enviar',
    ['CALLS'] = 'Chamadas',
    ['SETTINGS'] = 'Definições',
    ['MAP'] = 'Mapa',
    ['RESUME'] = 'Jogar',
    ['KEYBINDS'] = 'Teclas',
    ['EXIT']='Sair',
    ['DISABLED']='Desativado',
}


Config.NotificationText = {
    ["CLAIMED_VEHICLE"] = {
        text = 'Resgatado %s',
        timeout = 3000,
    },
    ["CLAIMED_ITEM"] = {
        text = 'Resgatado %sx %s',
        timeout = 3000,
    },
    ["CLAIMED_CASH"] = {
        text = 'Resgatado $%s cash',
        timeout = 3000,
    },
    ["PREMIUM_ITEM"] = {
        text = 'Este é um item premium',
        timeout = 3000,
    },
    ["PURCHASED_BATTLEPASS"] = {
        text = 'Passe de batalha comprado com sucesso',
        timeout = 3000,
    },
    ["ALREADY_PURCHASED"] = {
        text = "Você já comprou o passe de batalha ou é grátis",
        timeout = 3000,
    },
    ["MISSON_COMPLETED"] = {
        text = 'Missão do passe de batalha concluída',
        type = "success",
        timeout = 3000,
    },
    ["ADMIN_ERROR"] = {
        text = 'Não és um administrador ou os parâmetros não estão corretos (%s)',
        type = 'error',
        timeout = 3000,
    },
    ["ADMIN_ERROR_2"] = {
        text = 'Não és um administrador ',
        type = 'error',
        timeout = 3000,
    },
    ["NEW_CALL"] = {
        text = 'Uma nova chamada foi aberta',
        type = 'success',
        timeout = 3000
    },
    ["NEW_MESSAGE"] = {
        text = 'A mensagem chegou.',
        type = 'success',
        timeout = 3000
    },
    ["LIVE_CALL_TERMINATED"] = {
        text = 'Chamada ao vivo encerrada',
        timeout = 3000,
    },
    ["BLACKLISTED_WORD"] = {
        text = 'Sua mensagem contém palavra na lista negra',
        timeout = 3000,
    },
    ["NOT_LOADED"] = {
        text = 'O menu de pausa ainda não foi carregado',
        type = 'error',
        timeout = 3000,
    },
    ["SPAM_CONTROL"] = {
        text = 'O controle de spam está ativado, tente novamente alguns segundos depois',
        type = 'error',
        timeout = 3000,
    },

}

Config.PatchNotes = { -- Each text you write here will show up in the update notes in the pausemenu
    date = '09.04.2023',
    updates = {
		"Empregos legais melhorados, com mais animações...",
		"Novo Sistema de Casas reais com +300 decorações interior/exterior + Remax.",
		"Smartphone (Iphone 14 Pro Max) realístico com várias aplicações e definições que podes personalizar a teu gosto.",
		"Inventário totalmente personalizável a teu gosto, com sistema de controlo de roupas, attachments das armas, Craft, Lojas, Cofres (All in One)...",
		"Novo menu de faturas com muitas mais opções.",
		"Sistema de Banco real com cartão de crédito, PIN e muito mais...",
		"Novo sistema de garagem e novo stand.",
		"Novos assaltos multiplayer, com várias animações.",
		"Cartões únicos com item no inventário (Cartão de Cidadão, Carta de Condução, Licenças de Barco e Avião, Porte de Arma, Licença de Caça).",
		"Novos Carros com handlings melhoradas, Novos mapas e novas Roupas...",
		"Novo design dos menus.",
		"Novo sistema policial com muitas mais interações/informações para a PSP.",
		"Novo design dos menus.",
		"Hud redesenhado, com menu de definições.",
		"Sistema de drogas melhorado.",
		"Novo menu de controlo de portas/luzes/motor do veículo.",
		"Hangar de Aviões adicionado (Agora é possível ter uma aeronave/helicóptero), mas apenas com licença de aviação.",
		"Missão de rapto adicionada.",
		"Menu Néon para Vip's (várias animações e controlo de néons personalizado).",
		"Novo menu de Tunagem.",
		"Seguradora para veículos.",
		"Sistema real de veículos com contagem de quilómetros, revisão e manutenção.",
		"Sistema de rebocamento com corda.",
		"Novos itens adicionados às lojas.",
		"Ilha Cayo Perico e Barcos.",
		"Isto tudo e muito mais, explora o servidor e diverte-te!"
    },
}
Config.EnableClearChat = true
Config.ClearChatCommand = "clearchat"
Config.ChatBlacklistedWords = { -- This prevents players type chat blacklisted words
    'faggot',
    'bitch',
    'b1tch',
}

--[[------------------------------------------------------------------------------------------
██████╗░░█████╗░████████╗████████╗██╗░░░░░███████╗██████╗░░█████╗░░██████╗░██████╗
██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝██║░░░░░██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝
██████╦╝███████║░░░██║░░░░░░██║░░░██║░░░░░█████╗░░██████╔╝███████║╚█████╗░╚█████╗░
██╔══██╗██╔══██║░░░██║░░░░░░██║░░░██║░░░░░██╔══╝░░██╔═══╝░██╔══██║░╚═══██╗░╚═══██╗
██████╦╝██║░░██║░░░██║░░░░░░██║░░░███████╗███████╗██║░░░░░██║░░██║██████╔╝██████╔╝
╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░╚══════╝╚══════╝╚═╝░░░░░╚═╝░░╚═╝╚═════╝░╚═════╝░
------------------------------------------------------------------------------------------]]--

Config.BattlepassDayCountDown = 30 -- When you launch codem-pausemenu on your server, battlepass will be activated and this option determines how many days battlepass should be active before resetting everybody's battlepass data
Config.FreeBattlepass = false -- This option makes battlepass free for everyone (if this set to true you don't have to make tebex integration)
Config.BattlepassMissionsPerDay = 5 -- [[

    -- Missions in codem-pausemenu's battlepass system are created from the Config.BattlepassMissions pool, and this option determines how many missions the system should get from the pool per day.
    -- Note : for example if this option is set to 5 and amount of missions in the pool is less than 5 then the script will generate a random number between 1 and maximum missions amount
--]]

Config.BattlepassMissions = {
    {
        id = 1,
        label = 'Comer',
        desc = 'Coma qualquer comida 65',
        repeatAmount = 65,
        xpAmount = 500,
        func = function(_self)
            if Config.Framework == 'esx' then
                RegisterNetEvent('esx_basicneeds:onEat')
                AddEventHandler('esx_basicneeds:onEat', function()
                    TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id)
                end)
            else
                RegisterNetEvent('consumables:client:Eat')
                AddEventHandler('consumables:client:Eat', function()
                    TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id)
                end)
            end
        end,
    },
    {
        id = 2,
        label = 'Bebida',
        desc = 'Beba algo 70 vezes',
        repeatAmount = 70,
        xpAmount = 500,
        func = function(_self)
            if Config.Framework == 'esx' then
                RegisterNetEvent('esx_basicneeds:onDrink')
                AddEventHandler('esx_basicneeds:onDrink', function()
                    TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id)
                end)
            else
                RegisterNetEvent('consumables:client:Drink')
                AddEventHandler('consumables:client:Drink', function()
                    TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id)
                end)
            end
        end,
    },
    {
        id = 3,
        label = 'Dirigir',
        desc = 'Dirija por 150 km',
        repeatAmount = 150,
        xpAmount = 1500,
        func = function(_self)
            local lastCoords
            Citizen.CreateThread(function()
                while true do
                    local player = PlayerPedId()
                    local veh = GetVehiclePedIsIn(player)
                    if veh ~= 0 then
                        local coords = GetEntityCoords(player)
                        if IsVehicleOnAllWheels(veh) then
                            if not lastCoords then
                                lastCoords = GetEntityCoords(player)
                            end
                            local dst = #(coords - lastCoords)
                            TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id, math.floor(dst*1.33)/1000)
                            lastCoords = GetEntityCoords(player)
                        end
                    end
                    Citizen.Wait(3000)
                end
            end)
        end,
    },
    {
        id = 4,
        label = 'Dirigir',
        desc = 'Dirija por uma hora',
        repeatAmount = 60,
        xpAmount = 1500,
        func = function(_self)
            local drivingSeconds = 0
            Citizen.CreateThread(function()
                while true do
                    local player = PlayerPedId()
                    local veh = GetVehiclePedIsIn(player)
                    if veh ~= 0 then
                        if GetEntitySpeed(veh) > 0 then
                            drivingSeconds = drivingSeconds + 1
                            if drivingSeconds > 60 then
                                drivingSeconds = 0
                                TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id, 1)
                            end
                        end
                    end
                    Citizen.Wait(1000)
                end
            end)
        end,
    },
    {
        id = 5,
        label = 'Dirigir',
        desc = 'Dirija a 140 km/h ou mais por 3 minutos',
        repeatAmount = 3,
        xpAmount = 1000,
        func = function(_self)
            local drivingSeconds = 0

            Citizen.CreateThread(function()
                while true do
                    local player = PlayerPedId()
                    local veh = GetVehiclePedIsIn(player)
                    if veh ~= 0 then
                        local speed = GetEntitySpeed(veh) * 3.6
                        if speed > 140 then
                            drivingSeconds = drivingSeconds + 1
                            if drivingSeconds > 60 then
                                drivingSeconds = 0
                                TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id)
                            end
                        end
                    end
                    Citizen.Wait(1000)
                end
            end)
        end,
    },
    {
        id = 6,
        label = 'Dirigir',
        desc = 'Caminhe ou corra 10km',
        repeatAmount = 10,
        xpAmount = 1000,
        func = function(_self)
            local lastCoords
            Citizen.CreateThread(function()
                while true do
                    local player = PlayerPedId()
                    local coords = GetEntityCoords(player)
                    if IsPedRunning(player) or IsPedWalking(player) or IsPedSprinting(player) and not IsPedInAnyVehicle(player) then
                        if not lastCoords then
                            lastCoords = GetEntityCoords(player)
                        end
                        local dst = #(coords - lastCoords)
                        TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id, math.floor(dst*1.33)/1000)
                        lastCoords = GetEntityCoords(player)
                    end
                    Citizen.Wait(3000)
                end
            end)
        end,
    },
	{
        id = 7,
        label = 'Bebida',
        desc = 'Beba algo 150 vezes',
        repeatAmount = 150,
        xpAmount = 1500,
        func = function(_self)
            if Config.Framework == 'esx' then
                RegisterNetEvent('esx_basicneeds:onDrink')
                AddEventHandler('esx_basicneeds:onDrink', function()
                    TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id)
                end)
            else
                RegisterNetEvent('consumables:client:Drink')
                AddEventHandler('consumables:client:Drink', function()
                    TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id)
                end)
            end
        end,
    },
	{
        id = 8,
        label = 'Dirigir',
        desc = 'Dirija por 250 km',
        repeatAmount = 250,
        xpAmount = 3000,
        func = function(_self)
            local lastCoords
            Citizen.CreateThread(function()
                while true do
                    local player = PlayerPedId()
                    local veh = GetVehiclePedIsIn(player)
                    if veh ~= 0 then
                        local coords = GetEntityCoords(player)
                        if IsVehicleOnAllWheels(veh) then
                            if not lastCoords then
                                lastCoords = GetEntityCoords(player)
                            end
                            local dst = #(coords - lastCoords)
                            TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id, math.floor(dst*1.33)/1000)
                            lastCoords = GetEntityCoords(player)
                        end
                    end
                    Citizen.Wait(3000)
                end
            end)
        end,
    },
	{
        id = 9,
        label = 'Comer',
        desc = 'Coma qualquer 200 comida',
        repeatAmount = 200,
        xpAmount = 2000,
        func = function(_self)
            if Config.Framework == 'esx' then
                RegisterNetEvent('esx_basicneeds:onEat')
                AddEventHandler('esx_basicneeds:onEat', function()
                    TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id)
                end)
            else
                RegisterNetEvent('consumables:client:Eat')
                AddEventHandler('consumables:client:Eat', function()
                    TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id)
                end)
            end
        end,
    },
	{
        id = 10,
        label = 'Dirigir',
        desc = 'Dirija a 160 km/h ou mais por 3 minutos',
        repeatAmount = 3,
        xpAmount = 1000,
        func = function(_self)
            local drivingSeconds = 0

            Citizen.CreateThread(function()
                while true do
                    local player = PlayerPedId()
                    local veh = GetVehiclePedIsIn(player)
                    if veh ~= 0 then
                        local speed = GetEntitySpeed(veh) * 3.6
                        if speed > 160 then
                            drivingSeconds = drivingSeconds + 1
                            if drivingSeconds > 60 then
                                drivingSeconds = 0
                                TriggerServerEvent('codem-pausemenu:AddBattlepassMissionProgress', _self.id)
                            end
                        end
                    end
                    Citizen.Wait(1000)
                end
            end)
        end,
    },
}

Config.BattlepassItem = {
    {
        amount = 10000,
        label = 'Dinheiro',
        image = 'cash.png',
        type = 'money',
        requiredXP = 1000,
        level = 1,
        premium = false,
    },
    {
        name = 'water',
        label = 'Água',
        image = 'water.png',
        amount = 40,
        type = 'item',
        requiredXP = 1500,
        level = 2,
        premium = true,

    },
    {
        name = 'fixtool',
        label = 'Repair Kit',
        image = 'fixtool.png',
        amount = 10,
        type = 'item',
        requiredXP = 2000,
        level = 3,
        premium = true,

    },
    {
        name = 'armor',
        label = 'Colete',
        image = 'armor.png',
        amount = 2,
        type = 'item',
        requiredXP = 5000,
        level = 4,
        premium = true,

    },
    {
        name = 'black_phone',
        label = 'Telemóvel',
        image = 'black_phone.png',
        amount = 2,
        type = 'item',
        requiredXP = 5000,
        level = 5,
        premium = false,
    }, 
	{
        name = 'casino_ticket',
        label = 'Bilhete LuckyWheel',
        image = 'casino_ticket.png',
        amount = 1,
        type = 'item',
        requiredXP = 5000,
        level = 6,
        premium = true,
    }, 
	{
        name = 'hamburguer',
        label = 'Hambúrguer',
        image = 'hamburguer.png',
        amount = 25,
        type = 'item',
        requiredXP = 5000,
        level = 7,
        premium = false,
    },
	{
        name = 'beer',
        label = 'Cerveja',
        image = 'beer.png',
        amount = 35,
        type = 'item',
        requiredXP = 5000,
        level = 8,
        premium = true,
    },
	{
        amount = 50000,
        label = 'Dinheiro',
        image = 'cash.png',
        type = 'money',
        requiredXP = 3000,
        level = 9,
        premium = true,
    },
	{
        name = 'armor',
        label = 'Colete',
        image = 'armor.png',
        amount = 10,
        type = 'item',
        requiredXP = 5000,
        level = 10,
        premium = true,
    },
	{
        name = 'diamond',
        label = 'Diamante',
        image = 'diamond.png',
        amount = 5,
        type = 'item',
        requiredXP = 5000,
        level = 11,
        premium = false,
    },
	{
        name = 'tyrekit',
        label = 'Kit de Pneus',
        image = 'tyrekit.png',
        amount = 30,
        type = 'item',
        requiredXP = 5000,
        level = 12,
        premium = true,
    },
	{
        name = 'fakeid',
        label = 'Identidade Falsa',
        image = 'fakeid.png',
        amount = 2,
        type = 'item',
        requiredXP = 2000,
        level = 13,
        premium = false,
    },
	{
        name = 'medkit',
        label = 'Kit Médico',
        image = 'medkit.png',
        amount = 10,
        type = 'item',
        requiredXP = 5000,
        level = 14,
        premium = false,
    },
	{
        amount = 100000,
        label = 'Dinheiro',
        image = 'cash.png',
        type = 'money',
        requiredXP = 3000,
        level = 15,
        premium = true,
    },
	{
        name = 'fixtool',
        label = 'Repair Kit',
        image = 'fixtool.png',
        amount = 25,
        type = 'item',
        requiredXP = 5000,
        level = 16,
        premium = true,
    },
	{
        name = 'contract',
        label = 'Contrato de Veículos',
        image = 'contract.png',
        amount = 10,
        type = 'item',
        requiredXP = 3000,
        level = 17,
        premium = false,
    },
	{
        name = 'pts14',
        label = '2014 Porsche 911 Turbo S',
        image = 'pts14.png', -- check html/assets/car_images for more car images
        type = 'vehicle',
        requiredXP = 5000,
        level = 18,
        premium = true,
        garage = 'motelgarage', -- Set this option only on qb-core


    },
	{
        name = 'black_phone',
        label = 'Telemóvel',
        image = 'black_phone.png',
        amount = 10,
        type = 'item',
        requiredXP = 3000,
        level = 19,
        premium = false,
    },
	{
        name = 'casino_ticket',
        label = 'Bilhete LuckyWheel',
        image = 'casino_ticket.png',
        amount = 1,
        type = 'item',
        requiredXP = 3000,
        level = 20,
        premium = true,
    },
	{
        name = 'backpack',
        label = 'Mochila',
        image = 'backpack.png',
        amount = 1,
        type = 'item',
        requiredXP = 3000,
        level = 21,
        premium = true,
    },
	{
        name = 'weapon_pistol50',
        label = 'Deagle',
        image = 'recipe_WEAPON_PISTOL50.png',
        amount = 1,
        type = 'weapon',
        requiredXP = 3000,
        level = 22,
        premium = true,
    },
	{
        name = 'casino_chips',
        label = 'Fichas Casino',
        image = 'casino_chips.png',
        amount = 150000,
        type = 'item',
        requiredXP = 4000,
        level = 23,
        premium = true,
    },
	{
        name = 'armor',
        label = 'Colete',
        image = 'armor.png',
        amount = 20,
        type = 'item',
        requiredXP = 3000,
        level = 24,
        premium = true,
    },
    {
        label = 'Items Box',
        image = 'box.png', -- check html/assets/car_images for more car images
        type = 'box',
        requiredXP = 5000,
        level = 25,
        items = {
            {
                name = 'raptor2017',
                label = 'Ford Raptor',
                type = 'vehicle',
                garage = 'motelgarage', -- Set this option only on qb-core
            },
            {
                name = 'armor',
                label = 'Colete',
                amount = 5,
                type = 'item',
            },
            {
                name = 'black_phone',
                label = 'Telemóvel',
                amount = 5,
                type = 'item',
            },
            {
                amount = 40000,
                label = 'Dinheiro',
                type = 'money',
            },
        },
        premium = true,

    },
    {
        amount = 150000,
        label = 'Dinheiro',
        image = 'cash.png',
        type = 'money',
        requiredXP = 3000,
        level = 26,
        premium = true,
    },
}

--[[----------------------------------------------------------------------------------------------
██████╗░░█████╗░██╗██╗░░░░░██╗░░░██╗░█████╗░░██╗░░░░░░░██╗░█████╗░██████╗░██████╗░░██████╗
██╔══██╗██╔══██╗██║██║░░░░░╚██╗░██╔╝██╔══██╗░██║░░██╗░░██║██╔══██╗██╔══██╗██╔══██╗██╔════╝
██║░░██║███████║██║██║░░░░░░╚████╔╝░███████║░╚██╗████╗██╔╝███████║██████╔╝██║░░██║╚█████╗░
██║░░██║██╔══██║██║██║░░░░░░░╚██╔╝░░██╔══██║░░████╔═████║░██╔══██║██╔══██╗██║░░██║░╚═══██╗
██████╔╝██║░░██║██║███████╗░░░██║░░░██║░░██║░░╚██╔╝░╚██╔╝░██║░░██║██║░░██║██████╔╝██████╔╝
╚═════╝░╚═╝░░╚═╝╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░╚═════╝░
----------------------------------------------------------------------------------------------]]--

Config.DailyAwardsItem = {
    {
        name = 'water',
        label = 'Água',
        image = 'water.png',
        amount = 5,
        type = 'item',
    },
    {
        name = 'fixtool',
        label = 'Kit de Reparação',
        image = 'advancedkit.png',
        amount = 3,
        type = 'item',
    },
    {
        amount = 10000,
        label = 'Dinheiro',
        image = 'cash.png',
        type = 'money',
    },
    {
        name = 'black_phone',
        label = 'Telemóvel',
        image = 'wet_black_phone.png',
        amount = 2,
        type = 'item',
    },
    {
        name = 'medkit',
        label = 'Kit Médico',
        image = 'medkit.png',
        amount = 5,
        type = 'item',
    },
    {
        amount = 15000,
        label = 'Dinheiro',
        image = 'cash.png',
        type = 'money',
    },
    {
        name = 'contract',
        label = 'Contrato de Veículos',
        image = 'contract.png',
        amount = 5,
        type = 'item',
    },
    {
        name = 'fixtool',
        label = 'Kit de Reparação',
        image = 'advancedkit.png',
        amount = 10,
        type = 'item',
    },
    {
        name = 'tyrekit',
        label = 'Kit de Pneus',
        image = 'tyrekit.png',
        amount = 4,
        type = 'item',
    },
    {
        name = 'water',
        label = 'Água',
        image = 'water.png',
        amount = 15,
        type = 'item',
    },
    {
        name = 'sandwich',
        label = 'Sandwich',
        image = 'sandwich.png',
        amount = 15,
        type = 'item',
    },
    {
        name = 'black_phone',
        label = 'Telemóvel',
        image = 'wet_black_phone.png',
        amount = 5,
        type = 'item',
    },
    {
        name = 'radio',
        label = 'Rádio',
        image = 'radio.png',
        amount = 3,
        type = 'item',
    },
    {
        name = 'medkit',
        label = 'Kit Médico',
        image = 'medkit.png',
        amount = 5,
        type = 'item',
    },
    {
        amount = 15000,
        label = 'Dinheiro',
        image = 'cash.png',
        type = 'money',
    },
    {
        name = 'gold',
        label = 'Ouro',
        image = 'gold.png',
        amount = 4,
        type = 'item',
    },
    {
        name = 'cordareboque',
        label = 'Corda Reboque',
        image = 'towing_rope.png',
        amount = 3,
        type = 'item',
    },
    {
        name = 'backpack',
        label = 'Mochila',
        image = 'backpack.png',
        amount = 1,
        type = 'item',
    },
    {
        name = 'water',
        label = 'Água',
        image = 'water.png',
        amount = 20,
        type = 'item',
    },
    {
         name = 'cocacola',
        label = 'Coca Cola',
        image = 'cocacola.png',
        amount = 20,
        type = 'item',
    },
    {
        name = 'armor',
        label = 'Colete',
        image = 'armor.png',
        amount = 3,
        type = 'item',
    },
    {
        name = 'diamond',
        label = 'Diamante',
        image = 'diamond.png',
        amount = 1,
        type = 'item',
    },
    {
		name = 'contract',
        label = 'Contrato de Veículos',
        image = 'contract.png',
        amount = 5,
        type = 'item',
    },
    {
        amount = 20000,
        label = 'Dinheiro',
        image = 'cash.png',
        type = 'money',
    },
	{
		name = 'black_phone',
        label = 'Telemóvel',
        image = 'black_phone.png',
        amount = 7,
        type = 'item',
    },
	{
		name = 'fixtool',
        label = 'Kit de Reparação',
        image = 'advancedkit.png',
        amount = 5,
        type = 'item',
    },
    {
        name = 'buffalo',
        label = 'Buffalo',
        image = 'buffalo.png', -- check html/assets/car_images for more car images
        type = 'vehicle',
        garage = 'motelgarage', -- Set this option only on qb-core

    },
    {
        label = 'Items Box',
        image = 'box.png', -- check html/assets/car_images for more car images
        type = 'box',
        items = {
            {
                name = 'adder',
                label = 'Adder',
                type = 'vehicle',
                garage = 'motelgarage', -- Set this option only on qb-core

            },
            {
                name = 'medkit',
                label = 'Kit Médico',
                amount = 1,
                type = 'item',
            },
            {
                name = 'water',
                label = 'Água',
                amount = 10,
                type = 'item',
            },
            {
                amount = 20000,
                label = '~Dinheiro',
                type = 'money',
            },
        }
    },
    {
        label = 'Items Box',
        image = 'box.png', -- check html/assets/car_images for more car images
        type = 'box',
        items = {
            {
                name = 'sultan',
                label = 'Sultan',
                type = 'vehicle',
                garage = 'motelgarage', -- Set this option only on qb-core

            },
            {
                name = 'medkit',
                label = 'Kit Médico',
                amount = 4,
                type = 'item',
            },
            {
                name = 'cocacola',
                label = 'Coca Cola',
                amount = 10,
                type = 'item',
            },
            {
                amount = 30000,
                label = 'Dinheiro',
                type = 'money',
            },
        }
    },
    {
        label = 'Items Box',
        image = 'box.png', -- check html/assets/car_images for more car images
        type = 'box',
        items = {
            {
                name = 'vsci',
                label = 'Volkswagen Sciroco',
                type = 'vehicle',
                garage = 'motelgarage', -- Set this option only on qb-core

            },
            {
                name = 'medkit',
                label = 'Kit Médico',
                amount = 5,
                type = 'item',
            },
            {
                name = 'cocacola',
                label = 'Coca Cola',
                amount = 20,
                type = 'item',
            },
            {
                amount = 40000,
                label = 'Dinheiro',
                type = 'money',
            },
        }
    },
}

--[[---------------------------------------------------------------------------
░█████╗░████████╗██╗░░██╗███████╗██████╗░░██████╗
██╔══██╗╚══██╔══╝██║░░██║██╔════╝██╔══██╗██╔════╝
██║░░██║░░░██║░░░███████║█████╗░░██████╔╝╚█████╗░
██║░░██║░░░██║░░░██╔══██║██╔══╝░░██╔══██╗░╚═══██╗
╚█████╔╝░░░██║░░░██║░░██║███████╗██║░░██║██████╔╝
░╚════╝░░░░╚═╝░░░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═════╝░
---------------------------------------------------------------------------]]--

Config.ClientNotification = function(message, type, length) -- You can change notification event here
    if Config.Framework == "esx" then
		exports['Johnny_Notificacoes']:Alert("INFO", "<span style='color:#c7c7c7'>"..message.."</span>", 5000, 'info')
    else
        TriggerEvent('QBCore:Notify', message, type, length)
    end
end

Config.ServerNotification = function(source, message, type, length) -- You can change notification event here
    if Config.Framework == "esx" then
		TriggerClientEvent('Johnny_Notificacoes:Alert', source, "INFO", "<span style='color:#c7c7c7'>"..message.."</span>", 5000, 'info')
    else
        TriggerClientEvent('QBCore:Notify', source, message, type, length)
    end
end

Config.CheckPermissions = function()
    -- This is required to get admins for livecall system
    if Config.Framework == "esx" then
        Config.AdminPermissions = {
            "superadmin",
            "admin",
            "mod",
        }
    else
        Config.AdminPermissions = {
            "god",
            "admin",
        }
    end

end

