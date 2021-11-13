---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ll.
--- DateTime: 11/11/2021 21:08
---

RegisterNetEvent("pf:spawnVehicule")
AddEventHandler("pf:spawnVehicule",function(vehicle)
    local model = (type(vehicle) == 'number' and vehicle or GetHashKey(vehicle))

    if IsModelInCdimage(model) then
        local playerCoords, playerHeading = GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId())

        pfw.spawVehicule(model, playerCoords, playerHeading, function(vehicle)
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        end)
    else
        pfw.showNotification("Model invalide")
    end
end)