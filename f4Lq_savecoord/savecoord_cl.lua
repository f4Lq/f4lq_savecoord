ESX = exports["es_extended"]:getSharedObject()

RegisterCommand("savecoord", function(source, args)

    ESX.TriggerServerCallback("savecoord:checkAdmin", function(isAdmin)
        if not isAdmin then
            exports['f4lqNotify']:Alert(
                "SaveCoord",
                "Nie masz uprawnień do użycia tej komendy.",
                5000,
                "error"
            )
            return
        end

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        TriggerServerEvent("savecoord:server", args[1], coords)
    end)

end, false)
