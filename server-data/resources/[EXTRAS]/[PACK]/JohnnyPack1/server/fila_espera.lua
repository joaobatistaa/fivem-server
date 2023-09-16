local infoFilaEntrada = {}

----------------------------------------------------
-------- Intervalles en secondes -------------------
----------------------------------------------------

-- Temps d'attente Antispam / Waiting time for antispam
infoFilaEntrada.AntiSpamTimer = 2

-- Vérification et attribution d'une place libre / Verification and allocation of a free place
infoFilaEntrada.TimerCheckPlaces = 3

-- Mise à jour du message (emojis) et accès à la place libérée pour l'heureux élu / Update of the message (emojis) and access to the free place for the lucky one
infoFilaEntrada.TimerRefreshClient = 3

-- Mise à jour du nombre de points / Number of points updating
infoFilaEntrada.TimerUpdatePoints = 6

----------------------------------------------------
------------ Nombres de points ---------------------
----------------------------------------------------

-- Nombre de points gagnés pour ceux qui attendent / Number of points earned for those who are waiting
infoFilaEntrada.AddPoints = 1

-- Nombre de points perdus pour ceux qui sont entrés dans le serveur / Number of points lost for those who entered the server
infoFilaEntrada.RemovePoints = 1

-- Nombre de points gagnés pour ceux qui ont 3 emojis identiques (loterie) / Number of points earned for those who have 3 identical emojis (lottery)
infoFilaEntrada.LoterieBonusPoints = 25

-- Accès prioritaires / Priority access
infoFilaEntrada.Points = {
	 {'steamID', points},
	 {'steam:110000115708986', 5000},  -- johnny
	 {'steam:1100001392aad05', 4500},  -- snorlax  
	 {'steam:11000010dee11b6', 4500},  -- Jesus
     {'steam:110000133750c82', 3500},  -- almeida
	 {'steam:11000010c6f2fee', 3500},  -- shirley
	 {'steam:11000010e8c9c19', 3500},  -- im on fire
	 {'steam:110000119092a46', 3500},  -- pereira
	 {'steam:110000111804188', 3500},  -- xina
	 {'steam:110000116133e68', 3500},  -- helder
	 {'steam:11000011230bcc9', 3500},  -- zilla
	 {'steam:1100001164c488f', 3500},  -- matabixo
	 {'steam:1100001146c21b4', 3500},  -- mix
	 {'steam:110000111e8451f', 2000},  -- crazy (streamer)
	 {'steam:110000134f83146', 2000},  -- novais (streamer)
	 
}

----------------------------------------------------
------------- Textes des messages ------------------
----------------------------------------------------

infoFilaEntrada.NoSteam = "A tua steam não foi detetada. Abre a steam e reinicia o FiveM."

infoFilaEntrada.EnRoute = "Estás na fila de espera. Já percorreste"

infoFilaEntrada.PointsRP = "kms"

infoFilaEntrada.Position = "Estás na posição "

infoFilaEntrada.EmojiMsg = "Se os emojis estiverem parados, reinicia o FiveM : "

infoFilaEntrada.EmojiBoost = "!!! Youpi, " .. infoFilaEntrada.LoterieBonusPoints .. " " .. infoFilaEntrada.PointsRP .. " ganhaste !!!"

infoFilaEntrada.PleaseWait_1 = "Por favor, aguarda "

infoFilaEntrada.PleaseWait_2 = " segundos. A conexão irá começar automaticamente !"

infoFilaEntrada.Accident = "Ops, ocorreu um erro... Se isso acontecer novamente, entra em contacto com um administrador :)"

infoFilaEntrada.Error = " ERRO : REINICIA O BYPASS E ENTRA EM CONTATO COM O SUPORTE DO SERVIDOR "


infoFilaEntrada.EmojiList = {
	'🐌', 
	'🐍',
	'🐎', 
	'🐑', 
	'🐒',
	'🐘', 
	'🐙', 
	'🐛',
	'🐜',
	'🐝',
	'🐞',
	'🐟',
	'🐠',
	'🐡',
	'🐢',
	'🐤',
	'🐦',
	'🐧',
	'🐩',
	'🐫',
	'🐬',
	'🐲',
	'🐳',
	'🐴',
	'🐅',
	'🐈',
	'🐉',
	'🐋',
	'🐀',
	'🐇',
	'🐏',
	'🐐',
	'🐓',
	'🐕',
	'🐖',
	'🐪',
	'🐆',
	'🐄',
	'🐃',
	'🐂',
	'🐁',
	'🔥'
}


-- {steamID, points, source}
local players = {}

-- {steamID}
local waiting = {}

-- {steamID}
local connecting = {}

-- Points initiaux (prioritaires ou négatifs)
local prePoints = infoFilaEntrada.Points;

-- Emojis pour la loterie
local EmojiList = infoFilaEntrada.EmojiList

StopResource('hardcap')

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if GetResourceState('hardcap') == 'stopped' then
			StartResource('hardcap')
		end
	end
end)

-- Connexion d'un client
AddEventHandler("playerConnecting", function(name, reject, def)
	local source	= source
	local steamID = GetSteamID(source)

	-- pas de steam ? ciao
	if not steamID then
		reject(infoFilaEntrada.NoSteam)
		CancelEvent()
		return
	end

	-- Lancement de la rocade, 
	-- si cancel du client : CancelEvent() pour ne pas tenter de co.
	if not Rocade(steamID, def, source) then
		CancelEvent()
	end
end)

-- Fonction principale, utilise l'objet "deferrals" transmis par l'evenement "playerConnecting"
function Rocade(steamID, def, source)
	-- retarder la connexion
	def.defer()

	-- faire patienter un peu pour laisser le temps aux listes de s'actualiser
	AntiSpam(def)

	-- retirer notre ami d'une éventuelle liste d'attente ou connexion
	Purge(steamID)

	-- l'ajouter aux players
	-- ou actualiser la source
	AddPlayer(steamID, source)

	-- le mettre en file d'attente
	table.insert(waiting, steamID)

	-- tant que le steamID n'est pas en connexion
	local stop = false
	repeat

		for i,p in ipairs(connecting) do
			if p == steamID then
				stop = true
				break
			end
		end

	-- Hypothèse: Quand un joueur en file d'attente a un ping = 0, ça signifie que la source est perdue

	-- Détecter si l'user clique sur "cancel"
	-- Le retirer de la liste d'attente / connexion
	-- Le message d'accident ne devrait j'amais s'afficher
		for j,sid in ipairs(waiting) do
			for i,p in ipairs(players) do
				-- Si un joueur en file d'attente a un ping = 0
				if sid == p[1] and p[1] == steamID and (GetPlayerPing(p[3]) == 0) then
					-- le purger
					Purge(steamID)
					-- comme il a annulé, def.done ne sert qu'à identifier un cas non géré
					def.done(infoFilaEntrada.Accident)

					return false
				end
			end
		end

		-- Mettre à jour le message d'attente
		def.update(GetMessage(steamID))

		Citizen.Wait(infoFilaEntrada.TimerRefreshClient * 1000)

	until stop
	
	-- quand c'est fini, lancer la co
	def.done()
	return true
end

-- Vérifier si une place se libère pour le premier de la file
Citizen.CreateThread(function()
	local maxServerSlots = GetConvarInt('sv_maxclients', 32)
	
	while true do
		Citizen.Wait(infoFilaEntrada.TimerCheckPlaces * 1000)

		CheckConnecting()

		-- si une place est demandée et disponible
		if #waiting > 0 and #connecting + #GetPlayers() < maxServerSlots then
			ConnectFirst()
		end
	end
end)

-- Mettre régulièrement les points à jour
Citizen.CreateThread(function()
	while true do
		UpdatePoints()

		Citizen.Wait(infoFilaEntrada.TimerUpdatePoints * 1000)
	end
end)

-- Lorsqu'un joueur est kick
-- lui retirer le nombre de points fourni en argument
RegisterServerEvent("rocademption:playerKicked")
AddEventHandler("rocademption:playerKicked", function(src, points)
	local sid = GetSteamID(src)

	Purge(sid)

	for i,p in ipairs(prePoints) do
		if p[1] == sid then
			p[2] = p[2] - points
			return
		end
	end

	local initialPoints = GetInitialPoints(sid)

	table.insert(prePoints, {sid, initialPoints - points})
end)

-- Quand un joueur spawn, le purger
RegisterServerEvent("rocademption:playerConnected")
AddEventHandler("rocademption:playerConnected", function()
	local sid = GetSteamID(source)

	Purge(sid)
end)

-- Quand un joueur drop, le purger
AddEventHandler("playerDropped", function(reason)
	local steamID = GetSteamID(source)

	Purge(steamID)
end)

-- si le ping d'un joueur en connexion semble partir en couille, le retirer de la file
-- Pour éviter un fantome en connexion
function CheckConnecting()
	for i,sid in ipairs(connecting) do
		for j,p in ipairs(players) do
			if p[1] == sid and (GetPlayerPing(p[3]) == 500) then
				table.remove(connecting, i)
				break
			end
		end
	end
end

-- ... connecte le premier de la file
function ConnectFirst()
	if #waiting == 0 then return end

	local maxPoint = 0
	local maxSid = waiting[1][1]
	local maxWaitId = 1

	for i,sid in ipairs(waiting) do
		local points = GetPoints(sid)
		if points > maxPoint then
			maxPoint = points
			maxSid = sid
			maxWaitId = i
		end
	end
	
	table.remove(waiting, maxWaitId)
	table.insert(connecting, maxSid)
end

-- retourne le nombre de kilomètres parcourus par un steamID
function GetPoints(steamID)
	for i,p in ipairs(players) do
		if p[1] == steamID then
			return p[2]
		end
	end
end

-- Met à jour les points de tout le monde
function UpdatePoints()
	for i,p in ipairs(players) do

		local found = false

		for j,sid in ipairs(waiting) do
			if p[1] == sid then
				p[2] = p[2] + infoFilaEntrada.AddPoints
				found = true
				break
			end
		end

		if not found then
			for j,sid in ipairs(connecting) do
				if p[1] == sid then
					found = true
					break
				end
			end
		
			if not found then
				p[2] = p[2] - infoFilaEntrada.RemovePoints
				if p[2] < GetInitialPoints(p[1]) - infoFilaEntrada.RemovePoints then
					Purge(p[1])
					table.remove(players, i)
				end
			end
		end

	end
end

function AddPlayer(steamID, source)
	for i,p in ipairs(players) do
		if steamID == p[1] then
			players[i] = {p[1], p[2], source}
			return
		end
	end

	local initialPoints = GetInitialPoints(steamID)
	table.insert(players, {steamID, initialPoints, source})
end

function GetInitialPoints(steamID)
	local points = infoFilaEntrada.RemovePoints + 1

	for n,p in ipairs(prePoints) do
		if p[1] == steamID then
			points = p[2]
			break
		end
	end

	return points
end

function GetPlace(steamID)
	local points = GetPoints(steamID)
	local place = 1

	for i,sid in ipairs(waiting) do
		for j,p in ipairs(players) do
			if p[1] == sid and p[2] > points then
				place = place + 1
			end
		end
	end
	
	return place
end

function GetMessage(steamID)
	local msg = ""

	if GetPoints(steamID) ~= nil then
		msg = infoFilaEntrada.EnRoute .. " " .. GetPoints(steamID) .." " .. infoFilaEntrada.PointsRP ..".\n"

		msg = msg .. infoFilaEntrada.Position .. GetPlace(steamID) .. "/".. #waiting .. " " .. ".\n"

		msg = msg .. "[ " .. infoFilaEntrada.EmojiMsg

		local e1 = RandomEmojiList()
		local e2 = RandomEmojiList()
		local e3 = RandomEmojiList()
		local emojis = e1 .. e2 .. e3

		if( e1 == e2 and e2 == e3 ) then
			emojis = emojis .. infoFilaEntrada.EmojiBoost
			LoterieBoost(steamID)
		end

		-- avec les jolis emojis
		msg = msg .. emojis .. " ]"
	else
		msg = infoFilaEntrada.Error
	end

	return msg
end

function LoterieBoost(steamID)
	for i,p in ipairs(players) do
		if p[1] == steamID then
			p[2] = p[2] + infoFilaEntrada.LoterieBonusPoints
			return
		end
	end
end

function Purge(steamID)
	for n,sid in ipairs(connecting) do
		if sid == steamID then
			table.remove(connecting, n)
		end
	end

	for n,sid in ipairs(waiting) do
		if sid == steamID then
			table.remove(waiting, n)
		end
	end
end

function AntiSpam(def)
	for i=infoFilaEntrada.AntiSpamTimer,0,-1 do
		def.update(infoFilaEntrada.PleaseWait_1 .. i .. infoFilaEntrada.PleaseWait_2)
		Citizen.Wait(1000)
	end
end

function RandomEmojiList()
	randomEmoji = EmojiList[math.random(#EmojiList)]
	return randomEmoji
end

-- Helper pour récupérer le steamID or false
function GetSteamID(src)
	local sid = GetPlayerIdentifiers(src)[1] or false

	if (sid == false or sid:sub(1,5) ~= "steam") then
		return false
	end

	return sid
end
