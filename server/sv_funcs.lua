local QBCore = exports['qb-core']:GetCoreObject()
local NotifyType = Config.CoreSettings.Notify.Type
local InvType = Config.CoreSettings.Inventory.Type


--Server Debug function
function SVDebug(msg)
    if Config.CoreSettings.Debug.Prints then
        print(msg)
    end
end


-- Server Notification Function
function SVNotify(src, msg, type, time, title)
    if NotifyType == nil then print('| Lusty94_Shops | DEBUG | ERROR: NotifyType is nil check for errors!') return end
    if not title then title = 'Notification' end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print('Notification Sent With No Message') return end
    if NotifyType == 'qb' then
        TriggerClientEvent('QBCore:Notify', src, msg, type, time)
    elseif NotifyType == 'okok' then
        TriggerClientEvent('okokNotify:Alert', src, title, msg, time, type, Config.CoreSettings.Notify.Sound)
    elseif NotifyType == 'mythic' then
        TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = type, text = msg, style = { ['background-color'] = '#00FF00', ['color'] = '#FFFFFF' } })
    elseif NotifyType == 'ox' then 
        TriggerClientEvent('ox_lib:notify', src, ({ title = title, description = msg, length = time, type = type, style = 'default'}))
    elseif NotifyType == 'custom' then
        -- Insert your own logic for notify functions here
    else
        print('| Lusty94_Shops | DEBUG | ERROR: Unknown notify type set in Config.CoreSettings.Notify.Type! ' .. NotifyType)
    end
end


--Add Item Function
function addItem(src, item, amount, slot, info)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if InvType == 'qb' then
        local canCarry = exports['qb-inventory']:CanAddItem(source, item, amount)
        if canCarry then
            exports['qb-inventory']:AddItem(src, item, amount, slot, info)
            TriggerClientEvent('qb-inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
            SVDebug('^2| Lusty94_Shops | DEBUG | Adding '..amount..'x '..item..' to player ID: '..src..'^7')
        else
            SVNotify(src, Config.Language.Notifications.CantCarry, 'error', 5000)
        end
    elseif InvType == 'ox' then
        if exports.ox_inventory:CanCarryItem(src, item, amount) then
            exports.ox_inventory:AddItem(src, item, amount, info)
            SVDebug('^2| Lusty94_Shops | DEBUG | Adding '..amount..'x '..item..' to player ID: '..src..'^7')
        else
            SVNotify(src, Config.Language.Notifications.CantCarry, 'error', 5000)
        end
    elseif InvType == 'custom' then
        --insert your own logic for adding items here
    else
        print('^1| Lusty94_Shops | DEBUG | ERROR: Unknown inventory type set in Config.CoreSettings.Inventory.Type! ' .. InvType .. '^7')
    end
end



--Get The Label Of An Item
function ItemLabel(label)
	if InvType == 'ox' then
		local Items = exports['ox_inventory']:Items()
		if not Items[label] then SVDebug('^1| Lusty94_Shops | DEBUG | ERROR: Item: '.. tostring(label)..' is missing from ox_inventory/data/items.lua!^7') return '❌ The item: '..tostring(label)..' is missing from your items.lua! ' end
		return Items[label]['label']
    elseif InvType == 'qb' then
		if not QBCore.Shared.Items[label] then SVDebug('^1| Lusty94_Shops | DEBUG | ERROR: Item: '.. tostring(label)..' is missing from qb-core/shared/items.lua!^7') return '❌ The item: '..tostring(label)..' is missing from your items.lua! ' end
		return QBCore.Shared.Items[label]['label']
    elseif InvType == 'custom' then
        -- Insert your own logic for obtaining item labels here
	else
        print('| Lusty94_Shops | DEBUG | ERROR: Unknown inventory type set in Config.CoreSettings.Inventory.Type! ' .. InvType)
	end
end

--bans a player with a reason
local function BanPlayer(src)
    MySQL.insert('INSERT INTO bans (name, license, discord, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        getCharacterName(src),
        QBCore.Functions.GetIdentifier(src, 'license'),
        QBCore.Functions.GetIdentifier(src, 'discord'),
        'Exploiting',
        2147483647,
        GetCurrentResourceName()
    })
    DropPlayer(src, 'You were permanently banned for exploiting!')
end

--Complete Purchase
RegisterNetEvent("lusty94_shops:server:Complete")
AddEventHandler("lusty94_shops:server:Complete", function(shopType, itemName, quantity, itemPrice, paymentMethod)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local playerPed = GetPlayerPed(src)
    local playerCoords = GetEntityCoords(playerPed)
    local shopData = Config.Shops[shopType]
    local totalPrice = itemPrice * quantity
    local paymentSuccess = false
    local isNearShop = false
    local isValidItem = false
    local dropPlayer = Config.CoreSettings.Security.DropPlayer 
    local banPlayer = Config.CoreSettings.Security.BanPlayer
    local maxDist = Config.CoreSettings.Security.MaxDistance
    if not Player then return end
    for _, location in ipairs(shopData.locations) do
        if #(playerCoords - vector3(location.x, location.y, location.z)) < maxDist then
            isNearShop = true
            break
        end
    end
    if not isNearShop then
        if dropPlayer then DropPlayer(src, 'Reason: Failed Security Checks!') end
        if banPlayer then BanPlayer(src) end
        return
    end
    for _, item in ipairs(shopData.inventory) do
        if item.name == itemName then
            isValidItem = true
            break
        end
    end
    if not isValidItem then
        if dropPlayer then DropPlayer(src, 'Reason: Failed Security Checks!') end
        if banPlayer then BanPlayer(src) end
        return
    end
    if paymentMethod == "cash" then
        if InvType == 'qb' then
            if Player.Functions.RemoveMoney('cash', totalPrice, 'shops-purchase') then
                SVDebug('^2| Lusty94_Shops | DEBUG | Removing $'..totalPrice..' cash from player ID: '..src..'^7')
                paymentSuccess = true
            end
        elseif InvType == 'ox' then
            if exports.ox_inventory:RemoveItem(src, 'money', totalPrice) then
                SVDebug('^2| Lusty94_Shops | DEBUG | Removing $'..totalPrice..' from player ID: '..src..'^7')
                paymentSuccess = true
            end
        elseif InvType == 'custom' then
            --insert your own logic for removing cash here
        else
            print('^1| Lusty94_Shops | DEBUG | ERROR: Unknown inventory type set in Config.CoreSettings.Inventory.Type! ' .. InvType .. '^7')
        end
    elseif paymentMethod == "bank" then
        if InvType == 'qb' then
            if Player.Functions.RemoveMoney('bank', totalPrice, 'shops-purchase') then
                SVDebug('^2| Lusty94_Shops | DEBUG | Removing $'..totalPrice..' bank from player ID: '..src..'^7')
                paymentSuccess = true
            end
        elseif InvType == 'custom' then
            --insert your own logic for removing bank here
        else
            print('^1| Lusty94_Shops | DEBUG | ERROR: Unknown inventory type set in Config.CoreSettings.Inventory.Type! ' .. InvType .. '^7')
        end
    end
    if not paymentSuccess then SVNotify(src, Config.Language.Notifications.Failed, 'error', 5000) return end
    addItem(src, itemName, quantity)
    SVNotify(src, Config.Language.Notifications.Success..' '..quantity..'x '..ItemLabel(itemName), 'success', 5000)
end)


--version check
local function CheckVersion()
    PerformHttpRequest('https://raw.githubusercontent.com/Lusty94/UpdatedVersions/main/Shops/version.txt', function(err, newestVersion, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')
        if not newestVersion then
            print('^1[Lusty94_Shops]^7: Unable to fetch the latest version.')
            return
        end
        newestVersion = newestVersion:gsub('%s+', '')
        currentVersion = currentVersion and currentVersion:gsub('%s+', '') or "Unknown"
        if newestVersion == currentVersion then
            print(string.format('^2[Lusty94_Shops]^7: ^6You are running the latest version.^7 (^2v%s^7)', currentVersion))
        else
            print(string.format('^2[Lusty94_Shops]^7: ^3Your version: ^1v%s^7 | ^2Latest version: ^2v%s^7\n^1Please update to the latest version | Changelogs can be found in the support discord.^7', currentVersion, newestVersion))
        end
    end)
end

CheckVersion()