Config = Config or {}

-- Misc

Config.UseDiscordImages = true -- Only set this to false if you are using a different image hosting service

-- Mugshot

Config.Mugshot = {
    Enabled = true,
    Name = 'police_mugshot',
    Title = 'PRESO',
    Label = 'Polícia de Segurança Pública',
    Level = 1
}

-- Notifications Messages

Config.Messages = {
    ['player:fine'] = 'Recebeste uma multa no valor de {{amount}}€!',
    ['not_allowed'] = 'Não tens permissão para aceder ao Sistema da PSP!'
}