QBCore = exports['qb-core']:GetCoreObject()

local wait = 60000*15

CreateThread(function()
    for k, pickup in pairs(Config.Location["pickup"]) do
        local blip = AddBlipForCoord(location.coords.x, location.coords.y, location.coords.z)
        SetBlipSprite(605)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, 0.8)
        SetBlipColour(50)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(pickup.label)
        EndTextCommandSetBlipName(blip)
    end
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