if Config.TextUI ~= "ox_lib" then
    return
end

function TextShow(msg, x, y, z)
    lib.showTextUI(msg)
end

function TextClose() 
    lib.hideTextUI()
end