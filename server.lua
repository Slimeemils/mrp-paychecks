QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('mrp-paychecks:Register')
AddEventHandler('mrp-paychecks:Register', function()
    local source = source
	local xPlayer = QBCore.Functions.GetPlayer(source)	
	local cid = xPlayer.PlayerData.citizenid
    local payment = xPlayer.PlayerData.job.payment
    if xPlayer.PlayerData.job.onduty then
        exports.oxmysql:fetch("SELECT * FROM `paychecks` WHERE citizenid = '"..cid.."'", function(result)
            if result[1] ~= nil then
                local collectamount = result[1].collectamount+payment
                local currentpaycheck = result[1].collectamount
                exports.oxmysql:execute("UPDATE paychecks SET collectamount = '"..collectamount.."' WHERE citizenid = '"..cid.."'")
                TriggerClientEvent('QBCore:Notify', source, 'Your paycheck has been sent to Life Invader! Head there to collect it at your convenience.')
                Citizen.Wait(1000)
                TriggerEvent("qb-log:server:CreateLog", "paychecks", "Paychecks", "white", " | "..cid.." now has "..collectamount.." waiting as a paycheck")
            else	
                exports.oxmysql:insert("INSERT INTO `paychecks` (`citizenid`, `collectamount`) VALUES ('"..cid.."', '"..payment.."')")
            end
        end)
    else
        TriggerClientEvent('QBCore:Notify', source, 'You aren\'t on duty so you did not receive a paycheck.')
    end
end)

RegisterServerEvent('mrp-paychecks:Collect')
AddEventHandler('mrp-paychecks:Collect', function()
    local source = source
	local xPlayer = QBCore.Functions.GetPlayer(source)	
	local cid = xPlayer.PlayerData.citizenid
    local payment = xPlayer.PlayerData.job.payment
    exports.oxmysql:fetch("SELECT * FROM `paychecks` WHERE citizenid = '"..cid.."'", function(result)
        if result[1] ~= nil then
            local paycheck = result[1].collectamount
            xPlayer.Functions.AddMoney("cash", paycheck)
            exports.oxmysql:execute("UPDATE paychecks SET collectamount = 0 WHERE citizenid = '"..cid.."'")
            TriggerClientEvent('QBCore:Notify', source, 'You received your paycheck of '..paycheck..'!')
            TriggerEvent("qb-log:server:CreateLog", "paychecks", "Paychecks", "white", " | "..cid.." collected "..paycheck.." from their paycheck")
        else
            print('You don\'t have a job?')
        end
    end)
end)