
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
     end
end)

RegisterNUICallback('NUIFocusOff', function()
	menuopenorclose(false)
end)

RegisterNetEvent('KiaN_DevMenu:ShowMenu')
AddEventHandler('KiaN_DevMenu:ShowMenu', function(Table)
    Table.PlayerCoords = tostring(GetEntityCoords(PlayerPedId()))
	menuopenorclose(true, Table)
end)

RegisterNUICallback('callback', function(data)
    if data ~= nil then
        menuopenorclose(false)
        if data.what == "EnShCo" then
            isDebugMode = not isDebugMode
            local pped = GetPlayerPed(-1)
            while isDebugMode do
                Citizen.Wait(1)
                local pcoords = GetEntityCoords(pped)
                local street = GetStreetNameAtCoord(pcoords.x,pcoords.y,pcoords.z)
                local streetname = GetStreetNameFromHashKey(street)
                text("~r~x: ~w~" .. FormatNumber(pcoords.x) .. " ~r~y: ~w~" .. FormatNumber(pcoords.y) .. " ~r~z: ~w~" .. FormatNumber(pcoords.z) .. " ~r~h~w~: ".. FormatNumber(GetEntityHeading(pped)),0.01,0.7)
                if IsPedInAnyVehicle(pped) then
                    local carspeed = GetEntitySpeed(pped)
                    local veh = GetVehiclePedIsIn(pped,false)
                    local EntityModel = GetEntityModel(veh)
                    local VehicleName = GetDisplayNameFromVehicleModel(EntityModel)
                    local BodyHealth = GetVehicleBodyHealth(veh)
                    local Fuel = GetVehicleFuelLevel(veh)
                    text("~r~Speed: ~w~: " ..FormatNumber(carspeed).."\n~r~Car Model~w~: " .. VehicleName .. "\n~r~Body Health: ~w~" .. FormatNumber(BodyHealth) .. "\n ~r~Fuel: ~w~" .. FormatNumber(Fuel),0.01,0.55)
                end
            end
        elseif data.what == "SeToDi" then
            local pped = GetPlayerPed(-1)
            local pcoords = GetEntityCoords(pped)
            TriggerServerEvent('KiaN_DevMenu:SendCoords',pcoords)
        elseif data.what == "CoToCl" then
            SendNUIMessage({action = "copytext", coords = tostring(GetEntityCoords(PlayerPedId()))})
        elseif data.what == "SpawnVehicle" then
            local m = KeyboardInput("Model", "", 100)
            ExecuteCommand('car '..m)
        elseif data.what == "Teleport" then
            local m = KeyboardInput("ID", "", 100)
            ExecuteCommand('goto '..m)
        elseif data.what == "onoffduty" then
            ExecuteCommand('aa')
        elseif data.what == "Invisible" then
            ExecuteCommand('invis')
        elseif data.what == "DvCar" then
            ExecuteCommand('dv')
        end
    end
end)

KeyboardInput = function(u, v, w)
    AddTextEntry("FMMC_KEY_TIP1", u .. ":")
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", v, "", "", "", w)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        if IsDisabledControlPressed(0, 322) then
            return ""
        end
        Wait(10)
    end
    if GetOnscreenKeyboardResult() then
        local x = GetOnscreenKeyboardResult()
        return x
    end
end
function FormatNumber(Number)
    if Number == nil then
      return "unknown"
    end
    return tonumber(string.format("%.2f", Number))
end
function text(content,x,y) 
  SetTextFont(6)
  SetTextProportional(0)
  SetTextScale(0.4,0.4)
  SetTextEntry("STRING")
  AddTextComponentString(content)
  DrawText(x,y)
end
function menuopenorclose(what, tabl)
    SetNuiFocus(what, what)
    if tabl ~= nil then
        SendNUIMessage({action = "showmenu", show = what, table = tabl})
    else
        SendNUIMessage({action = "showmenu", show = what})
    end
end