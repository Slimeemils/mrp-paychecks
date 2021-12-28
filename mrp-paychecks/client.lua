QBCore = exports['qb-core']:GetCoreObject()

local wait = 60000*15

Citizen.CreateThread(function()
    LifeInvader = AddBlipForCoord(-1082.91, -247.99, 37.76)
    SetBlipSprite (LifeInvader, 605)
    SetBlipDisplay(LifeInvader, 4)
    SetBlipScale  (LifeInvader, 0.8)
    SetBlipAsShortRange(LifeInvader, true)
    -- SetBlipColour(LifeInvader, 50)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Life Invader")
    EndTextCommandSetBlipName(LifeInvader)
end) 

Citizen.CreateThread(function()
    while true do
        Wait(wait)
        TriggerServerEvent('mrp-paychecks:Register')
    end
end)

RegisterNetEvent('mrp-paychecks:targetcollect')
AddEventHandler('mrp-paychecks:targetcollect', function()
    TriggerServerEvent('mrp-paychecks:Collect')
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone('paychecks', vector3(-1083.21, -246.95, 37.52), 1.5, 1.6, {
        name = 'paychecks',
        heading = 240,
        debugPoly = false,
    }, {
        options = {
            {
                type = "client",
                event = "mrp-paychecks:targetcollect",
                icon = "fas fa-money-check-alt",
                label = "Collect Paycheck",
            },
        },           
        distance = 2.0
    })
end)