RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    SendNUIMessage({
        action = "UPDATE_JOB",
        payload = {
            job = job.label,
            job_grade_name = job.grade_label,
        }
    })
end)

RegisterNetEvent("QBCore:Player:SetPlayerData")
AddEventHandler("QBCore:Player:SetPlayerData", function(data)
    SendNUIMessage({
        action = "UPDATE_MONEY",
        payload = {
            cash = data.money.cash or 0,
            bank = data.money.bank or 0,
        }
    })

    SendNUIMessage({
        action = "UPDATE_JOB",
        payload = {
            job = data.job.label,
            job_grade_name = data.job.grade.name,
        }
    })

end)

function LoadMoneyAndJob()
    WaitNui()
    WaitPlayer()
    local cash = nil
    local bank = nil
    local job = 'UNEMPLOYED'
    local job_grade = 'Civil'
    local loopCounter = 0
    while true do
        if Core ~= nil then
            local Player = GetPlayerData()
            if Player then
                if Config.Framework == 'esx' then
                    for _,v in pairs(Player.accounts) do
                        if v.name == 'bank' then
                            bank = v.money
                        end
                    end
                    cash = TriggerCallback('codem-pausemenu:GetPlayerCash')
                    job = Player.job.label
                    job_grade = Player.job.grade_label
                    break
                else
                    cash = Player.money.cash
                    bank = Player.money.bank
                    job = Player.job.label
                    job_grade = Player.job.grade.name
                    break
                end
            end
            loopCounter = loopCounter + 1
            if loopCounter >= 3 then
                break
            end
        end
        Citizen.Wait(1000)
    end


    SendNUIMessage({
        action = "UPDATE_MONEY",
        payload = {
            cash = cash or 0,
            bank = bank or 0,
        }
    })

    SendNUIMessage({
        action = "UPDATE_JOB",
        payload = {
            job = job,
            job_grade_name = job_grade,
        }
    })
end