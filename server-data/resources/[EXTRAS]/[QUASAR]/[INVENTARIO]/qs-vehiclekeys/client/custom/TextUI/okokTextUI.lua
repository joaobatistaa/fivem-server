if Config.TextUI ~= "okokTextUI" then
    return
end

function TextShow(msg, x, y, z)
    exports['okokTextUI']:Open(msg, 'lightgreen', 'right')
end

function TextClose() 
    exports['okokTextUI']:Close()
end