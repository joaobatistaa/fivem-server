Config = Config or {}

--░██████╗░███████╗███╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░
--██╔════╝░██╔════╝████╗░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░
--██║░░██╗░█████╗░░██╔██╗██║█████╗░░██████╔╝███████║██║░░░░░
--██║░░╚██╗██╔══╝░░██║╚████║██╔══╝░░██╔══██╗██╔══██║██║░░░░░
--╚██████╔╝███████╗██║░╚███║███████╗██║░░██║██║░░██║███████╗
--░╚═════╝░╚══════╝╚═╝░░╚══╝╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝

Config.getSharedObject = 'esx:getSharedObject' --Modify your ESX-based framework here.
Config.playerLoaded = 'esx:playerLoaded' --Modify your ESX-based framework here.


--░██████╗██╗░░██╗░█████╗░░██╗░░░░░░░██╗    ██╗██████╗░
--██╔════╝██║░░██║██╔══██╗░██║░░██╗░░██║    ██║██╔══██╗
--╚█████╗░███████║██║░░██║░╚██╗████╗██╔╝    ██║██║░░██║
--░╚═══██╗██╔══██║██║░░██║░░████╔═████║░    ██║██║░░██║
--██████╔╝██║░░██║╚█████╔╝░░╚██╔╝░╚██╔╝░    ██║██████╔╝
--╚═════╝░╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝░░    ╚═╝╚═════╝░

Config.ShowId = false --If you deactivate this function, the IDs of the nearby players will not appear, nor yours.
Config.Id = "name" --It is recommended to use only the name, but you can see these types of ID: "steam", "steamv2", "license", "licensev2" or "name".
Config.DrawDistance = 4 --This is the distance it takes to see another player's ID.


--░██████╗░█████╗░░█████╗░██████╗░███████╗██████╗░░█████╗░░█████╗░██████╗░██████╗░
--██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗
--╚█████╗░██║░░╚═╝██║░░██║██████╔╝█████╗░░██████╦╝██║░░██║███████║██████╔╝██║░░██║
--░╚═══██╗██║░░██╗██║░░██║██╔══██╗██╔══╝░░██╔══██╗██║░░██║██╔══██║██╔══██╗██║░░██║
--██████╔╝╚█████╔╝╚█████╔╝██║░░██║███████╗██████╦╝╚█████╔╝██║░░██║██║░░██║██████╔╝
--╚═════╝░░╚════╝░░╚════╝░╚═╝░░╚═╝╚══════╝╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═════╝░

Config.OpenKey = "HOME" --This key will open the scoreboard and also the ShowId if it is active.

Config.MaxPlayers = GetConvarInt('sv_maxclients', 128) --Enter the maximum number of users that can enter your server, remember to have 'sv_maxclients' inside your server.cfg.

Config.Jobs = { --Choose the available works from your scoreboard.
    police = 'police',
    ambulance = 'ambulance',
    mechanic = 'mechanic',
	taxi = 'taxi'
}

Config.IllegalActions = { --These are the illegal actions, you can read the GUIDE AND LICENSE.md to see how to install this correctly.
	["lojas"] = {
        minimum = 4, --Minimum of police officers.
        busy = false, --If you activate this, the out of service clock will appear forever.
    },
    ["bancos"] = {
        minimum = 4, --Minimum of police officers.
        busy = false, --If you activate this, the out of service clock will appear forever.
    },
    ["joalharia"] = {
        minimum = 7, --Minimum of police officers.
        busy = false, --If you activate this, the out of service clock will appear forever.
    },
	["comboio"] = {
        minimum = 4, --Minimum of police officers.
        busy = false, --If you activate this, the out of service clock will appear forever.
    },
	["bancoprincipal"] = {
        minimum = 7, --Minimum of police officers.
        busy = false, --If you activate this, the out of service clock will appear forever.
    },
	["casino"] = {
        minimum = 8, --Minimum of police officers.
        busy = false, --If you activate this, the out of service clock will appear forever.
    },
	["humane"] = {
        minimum = 8, --Minimum of police officers.
        busy = false, --If you activate this, the out of service clock will appear forever.
    },
	["art"] = {
        minimum = 4, --Minimum of police officers.
        busy = false, --If you activate this, the out of service clock will appear forever.
    },
	["rapto"] = {
        minimum = 2, --Minimum of police officers.
        busy = false, --If you activate this, the out of service clock will appear forever.
    },
}