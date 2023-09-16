if Config.EnableEngineControl then
    RegisterKeyMapping('engine', "Ligar/Desligar Motor Veículo", 'keyboard', Config.EngineControlKey)
    RegisterCommand('engine', function()
        TriggerEvent(Config.Eventprefix..":client:ToggleEngine")
    end)
end