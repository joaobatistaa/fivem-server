if Config.TextUI ~= "esx_textui" then
    return
end

function TextShow(msg, x, y, z)
    exports["esx_textui"]:TextUI(msg)
end

function TextClose() 
    exports["esx_textui"]:HideUI()
end