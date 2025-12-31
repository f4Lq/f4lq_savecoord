ESX = exports["es_extended"]:getSharedObject()

local filename = "saveCoordAdmin.lua"

-- CALLBACK: SPRAWDZENIE ADMINA (ESX GROUP)
ESX.RegisterServerCallback("savecoord:checkAdmin", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        cb(false)
        return
    end

    local group = xPlayer.getGroup()

    if group == "admin" or group == "superadmin" or group == "mod" then
        cb(true)
    else
        cb(false)
    end
end)

RegisterNetEvent("savecoord:server")
AddEventHandler("savecoord:server", function(name, coords)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local group = xPlayer.getGroup()

    -- ZABEZPIECZENIE ANTY-EXPLOIT
    if group ~= "admin" and group ~= "superadmin" and group ~= "mod" then
        print(("🚨 savecoord exploit | ID: %s | group: %s"):format(source, group))
        return
    end

    local coordsString = string.format(
        "[%s] = {%.2f, %.2f, %.2f}",
        name or "Unknown_f4Lq",
        coords.x,
        coords.y,
        coords.z
    )

    local file = io.open(filename, "a")
    if file then
        file:write(coordsString .. ",\n")
        file:close()

        TriggerClientEvent('f4LqNotify:Alert', source,
            "SaveCoord",
            "Coordy zapisane w pliku (saveCoordAdmin.lua).",
            5000,
            "success"
        )
    else
        TriggerClientEvent('f4LqNotify:Alert', source,
            "SaveCoord",
            "Nie można otworzyć pliku do zapisu.",
            5000,
            "error"
        )
    end
end)

Citizen.CreateThread(function()
	Citizen.Wait(5000)
	local ver = "v2.0"
	print("f4Lq_savecoord "..ver)
end)