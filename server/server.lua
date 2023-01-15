ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('devmenu', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.permission_level >= 10 then
        local AllPlayerCount = #ESX.GetPlayers()
        local TableForCl = {
            PlayerCount = AllPlayerCount,
            StatusDuty = xPlayer.get('aduty')
        }
        TriggerClientEvent("KiaN_DevMenu:ShowMenu", source, TableForCl)
    end
end)


local WebHook = ''
RegisterNetEvent("KiaN_DevMenu:SendCoords")
AddEventHandler("KiaN_DevMenu:SendCoords",function(coords)
    PerformHttpRequest(WebHook, function() end, "POST", 
    json.encode({
        content = '```css\n'..coords.x  ..' '..coords.y..' '..coords.z..'\n\n{'..coords.x  ..', '..coords.y..', '..coords.z..'}\n\nvector3('..coords.x..', '..coords.y..', '..coords.z..')\n\n{ x = '..coords.x..', y = '..coords.y..', z = '..coords.z..'}```',
    }), 
    {["Content-Type"] = "application/json"})
end)