ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[
    items
    -----------
    - drkenevir
    - drkokain
    - drpaketlenmiskokain
    - drhuni
--]]

RegisterServerEvent('dr:pisirme2')
AddEventHandler('dr:pisirme2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sans = math.random(1,100)
    local item = xPlayer.getInventoryItem('drkenevir')
    if item.count >=  3 then
        if sans >= Config.pisirmefail then
            xPlayer.removeInventoryItem('drkenevir', 3)
            TriggerClientEvent('dr:pisirmeclient', _source)
        else
            TriggerClientEvent('dr:pisirmeclientfail', _source)
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Üstüne yeterli kenevir yok.', length = 5000 })
    end
end)

RegisterServerEvent('dr:pisirme3')
AddEventHandler('dr:pisirme3', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.addInventoryItem('drkokain', Config.pisirmeadeti)
end)


RegisterServerEvent('dr:isleme2')
AddEventHandler('dr:isleme2', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sans = math.random(1,100)
    local hunicheck = xPlayer.getInventoryItem('phone')
    local item = xPlayer.getInventoryItem('drkokain')
    if item.count >=  3 then
        --TriggerEvent('dr:isleme')
        if hunicheck.count >=  1 then
            if sans >= 5 then
                TriggerClientEvent('dr:islemeclient', _source)
                xPlayer.removeInventoryItem('drkokain', 3)
            else
                TriggerClientEvent('dr:islemeclientfail', _source)
                xPlayer.removeInventoryItem('drkokain', 3)
            end
        else
            if sans >= 40 then
                TriggerClientEvent('dr:islemeclient', _source)
                xPlayer.removeInventoryItem('drkokain', 3)
            else
                TriggerClientEvent('dr:islemeclienthuni', _source)
                xPlayer.removeInventoryItem('drkokain', 3)
            end
        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Üstüne yeterli kokain yok.', length = 5000 })
    end
end)

RegisterServerEvent('dr:islemeprice')
AddEventHandler('dr:islemeprice', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem('drpaketlenmiskokain', Config.islemeadeti)

end)