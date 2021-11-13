---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ll.
--- DateTime: 11/11/2021 19:55
---

pfw = {}
pfw.showNotification = function(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(0,1)
end

pfw.Keyboard = function(TextEntry, ExampleText, MaxStringLength)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

pfw.spawVehicule = function(vehicle, coords, heading, cb)
    local model = (type(vehicle) == 'number' and vehicle or GetHashKey(vehicle))
    local vector = type(coords) == "vector3" and coords or vec(coords.x, coords.y, coords.z)
    Citizen.CreateThread(function()
        RequestModel(model)
        while not HasModelLoaded(model)do
            Wait(1)
        end

        local vehicle = CreateVehicle(model, vector.xyz, heading, false, false)


        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetModelAsNoLongerNeeded(model)
        SetVehRadioStation(vehicle, 'OFF')

        RequestCollisionAtCoord(vector.xyz)
        while not HasCollisionLoadedAroundEntity(vehicle) do
            Citizen.Wait(0)
        end

        if cb then
            cb(vehicle)
        end
    end)

end

RegisterNetEvent("pf:showNotificattion")
AddEventHandler("pf:showNotificattion",function(msg)
    pfw.showNotification(msg)
end)