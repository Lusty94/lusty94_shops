local QBCore = exports['qb-core']:GetCoreObject()
local InvType = Config.CoreSettings.Inventory.Type
local TargetType = Config.CoreSettings.Target.Type
local NotifyType = Config.CoreSettings.Notify.Type
local spawnedPeds = {}
local pedBlips = {}
local busy = false

--sends a client debug print
function CLDebug(msg)
    if Config.CoreSettings.Debug.Prints then
        print(msg)
    end
end


--sends a client notification
function CLNotify(msg,type,time,title)
    if NotifyType == nil then print("| Lusty94_Shops | DEBUG | ERROR: NotifyType is nil check for errors!") return end
    if not title then title = 'Notification' end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print('Notification Sent With No Message!') return end
    if NotifyType == 'qb' then
        QBCore.Functions.Notify(msg,type,time)
    elseif NotifyType == 'okok' then
        exports['okokNotify']:Alert(title, msg, time, type, true)
    elseif NotifyType == 'mythic' then
        exports['mythic_notify']:DoHudText(type, msg)
    elseif NotifyType == 'ox' then
        lib.notify({ title = title, description = msg, type = type, duration = time})
    elseif NotifyType == 'custom' then
        --insert your custom notification function here
    else
        print('| Lusty94_Shops | DEBUG | ERROR: Unknown Notify Type Set In Config.CoreSettings.Notify.Type!'..NotifyType)
    end
end


---get an item image for ox_lib menus
function ItemImage(img)
	if InvType == 'ox' then
        if not tostring(img) then CLDebug('^1| Lusty94_Shops | DEBUG | ERROR: Item: '.. tostring(img)..' is missing from ox_inventory/data/items.lua!^7') return "https://files.fivemerr.com/images/54e9ebe7-df76-480c-bbcb-05b1559e2317.png"  end 
		return "nui://ox_inventory/web/images/" .. img .. '.png'
	elseif InvType == 'qb' then
		if not QBCore.Shared.Items[img] then CLDebug('^1| Lusty94_Shops | DEBUG | ERROR: Item: '.. tostring(img)..' is missing from qb-core/shared/items.lua!^7') return "https://files.fivemerr.com/images/54e9ebe7-df76-480c-bbcb-05b1559e2317.png"  end
		return "nui://qb-inventory/html/images/" .. QBCore.Shared.Items[img].image
	elseif InvType == 'custom' then
        -- Insert your own methods for obtaining item images here
	else
        print('| Lusty94_Shops | DEBUG | ERROR: Unknown inventory type set in Config.CoreSettings.Inventory.Type! ' .. InvType)
	end
end


--get an item label
function ItemLabel(label)
	if InvType == 'ox' then
		local Items = exports['ox_inventory']:Items()
		if not Items[label] then CLDebug('^1| Lusty94_Shops | DEBUG | ERROR: Item: '.. tostring(label)..' is missing from ox_inventory/data/items.lua!^7') return '❌ The item: '..tostring(label)..' is missing from your items.lua! ' end
		return Items[label]['label']
    elseif InvType == 'qb' then
		if not QBCore.Shared.Items[label] then CLDebug('^1| Lusty94_Shops | DEBUG | ERROR: Item: '.. tostring(label)..' is missing from qb-core/shared/items.lua!^7') return '❌ The item: '..tostring(label)..' is missing from your items.lua! ' end
		return QBCore.Shared.Items[label]['label']
    elseif InvType == 'custom' then
        -- Insert your own methods for obtaining item labels here
	else
        print('| Lusty94_Shops | DEBUG | ERROR: Unknown inventory type set in Config.CoreSettings.Inventory.Type! ' .. InvType)
	end
end


--lock inventory to prevent exploits
function LockInventory(toggle)
	if toggle then
        LocalPlayer.state:set("inv_busy", true, true)
        CLDebug('^2| Lusty94_Shops | DEBUG | Info: Toggling Inventory Lock: ON ^7')
    else 
        LocalPlayer.state:set("inv_busy", false, true)
        CLDebug('^2| Lusty94_Shops | DEBUG | Info: Toggling Inventory Lock: OFF ^7')
    end
end


--set busy status
function setBusy(toggle)
    busy = toggle
end


-- Spawn shop peds
CreateThread(function()
    for shopType, data in pairs(Config.Shops) do
        if data.locations and #data.locations > 0 then
            for _, location in ipairs(data.locations) do
                local model = data.models[math.random(#data.models)]
                lib.requestModel(model, 30000)
                local shopPed = CreatePed(4, model, location.x, location.y, location.z - 1.0, location.w, false, true)
                SetEntityAsMissionEntity(shopPed, true, true)
                FreezeEntityPosition(shopPed, true)
                SetEntityInvincible(shopPed, true)
                SetBlockingOfNonTemporaryEvents(shopPed, true)
                local scenario = data.info.scenario
                TaskStartScenarioInPlace(shopPed, scenario, 0, true)
                spawnedPeds[shopType] = spawnedPeds[shopType] or {}
                table.insert(spawnedPeds[shopType], shopPed)
                local blipsEnabled = data.blips.enabled
                if blipsEnabled then
                    local blip = AddBlipForCoord(location.x, location.y, location.z)
                    SetBlipSprite(blip, data.blips.id)
                    SetBlipDisplay(blip, 4)
                    SetBlipScale(blip, data.blips.scale)
                    SetBlipColour(blip, data.blips.colour)
                    SetBlipAsShortRange(blip, true)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(data.blips.title)
                    EndTextCommandSetBlipName(blip)
                    pedBlips[shopPed] = blip
                end
                if TargetType == "qb" then
                    exports['qb-target']:AddTargetEntity(shopPed, {
                        options = {
                            {
                                type = "client",
                                event = "lusty94_shops:client:Menu",
                                icon = data.info.targetIcon,
                                label = data.info.targetLabel,
                                args = { shopType = shopType }
                            }
                        },
                        distance = data.info.distance
                    })
                elseif TargetType == "ox" then
                    exports.ox_target:addLocalEntity(shopPed, {
                        {
                            name = shopType,
                            icon = data.info.targetIcon,
                            label = data.info.targetLabel,
                            event = "lusty94_shops:client:Menu",
                            distance = data.info.distance,
                            args = { shopType = shopType }
                        }
                    })
                elseif TargetType == 'custom' then
                    --insert your own logic for targetting the peds here making sure to pass the shopType as args
                else
                    print('| Lusty94_Shops | DEBUG | ERROR: Unknown target type set in Config.CoreSettings.Target.Type! ' .. TargetType)
                end
            end
        end
    end
end)



-- Open Shop Menu
RegisterNetEvent("lusty94_shops:client:Menu", function(data)
    local shopType = data.args and data.args.shopType or nil
    if not shopType or not Config.Shops[shopType] then CLDebug("^1| Lusty94_Shops | DEBUG | ERROR: No shop type data passed!") return end
    CLDebug("^2| Lusty94_Shops | DEBUG | Info: Opening Shop Menu for: " .. shopType)
    local menuOptions = {}
    local playerData = QBCore.Functions.GetPlayerData()
    local playerLicenses = playerData.metadata.licences or {}
    local playerJob = playerData.job and playerData.job.name or "unemployed"
    local playerRank = playerData.job and playerData.job.grade.level or 0
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local shopData = Config.Shops[shopType]
    local isNearShop = false
    local maxDist = Config.CoreSettings.Security.MaxDistance
    for _, location in ipairs(shopData.locations) do
        if #(playerCoords - vector3(location.x, location.y, location.z)) < maxDist then
            isNearShop = true
            break
        end
    end
    if not isNearShop then CLDebug("^1| Lusty94_Shops | DEBUG | ERROR: Failed Security Checks!") return end
    for _, item in ipairs(Config.Shops[shopType].inventory) do
        local items = item.name
        local itemLabel = ItemLabel(items)
        local itemImage = ItemImage(items)
        local price = item.price
        local stock = item.amount
        local requiresLicense = item.requiresLicense
        local hasLicense = requiresLicense and playerLicenses[requiresLicense] or false
        local requiresJob = item.requiresJob
        local hasJob = false
        if requiresJob then
            if type(requiresJob) == "table" then
                for _, job in ipairs(requiresJob) do
                    if playerJob == job then
                        hasJob = true
                        break
                    end
                end
            else
                hasJob = playerJob == requiresJob
            end
        else
            hasJob = true
        end
        local requiresRank = item.requiresRank or 0
        local hasRank = playerRank >= requiresRank
        CLDebug("^5| Lusty94_Shops | DEBUG | Info: Item: "..item.name.." | Requires License: "..tostring(requiresLicense).." | Player Has License: "..tostring(hasLicense).." | Requires Job: "..json.encode(requiresJob).." | Requires Rank: "..tostring(requiresRank))
        table.insert(menuOptions, {
            title = itemLabel,
            description = "Price: $"..price.."\n Stock Available: "..stock,
            event = "lusty94_shops:client:input",
            args = { shopType = shopType, item = item },
            icon = itemImage,
            image = itemImage,
            disabled = (requiresLicense and not hasLicense) or (requiresJob and not hasJob) or (requiresRank and not hasRank)
        })
    end
    lib.registerContext({
        id = 'shop_menu_' .. shopType,
        title = Config.Shops[shopType].info.shopLabel,
        options = menuOptions
    })
    lib.showContext('shop_menu_' .. shopType)
end)


--purchase item
RegisterNetEvent("lusty94_shops:client:input", function(data)
    if busy then CLNotify(Config.Language.Notifications.Busy, 'error', 5000) return end
    local shopType = data.shopType
    local item = data.item
    local playerData = QBCore.Functions.GetPlayerData()
    local cash = playerData.money.cash or 0
    local bank = playerData.money.bank or 0
    local maxAmount = item.amount or 1
    setBusy(true)
    LockInventory(true)
    local input = lib.inputDialog(ItemLabel(item.name)..'\n Price: $'..item.price, {
        {
            type = "slider",
            label = "Select Quantity To Purchase",
            min = 1,
            max = maxAmount,
            required = true,
        },
        {
            type = "select",
            label = "Select Payment Method",
            options = {
                { label = "Cash ($" ..cash..")", value = "cash" },
                { label = "Bank ($" ..bank..")", value = "bank" },
            },
            required = true
        }
    })
    if not input then CLNotify(Config.Language.Notifications.Cancelled, 'error', 5000) setBusy(false) LockInventory(false) return end
    local quantity, paymentMethod = input[1], input[2]
    local totalPrice = item.price * quantity
    if paymentMethod == "cash" and cash < totalPrice then
        CLNotify(Config.Language.Notifications.NoCash, 'error', 5000)
        setBusy(false)
        LockInventory(false)
        return
    elseif paymentMethod == "bank" and bank < totalPrice then
        CLNotify(Config.Language.Notifications.NoBank, 'error', 5000)
        setBusy(false)
        LockInventory(false)
        return
    end
    CLDebug("^3| Lusty94_Shops | DEBUG | Info: Purchasing " .. ItemLabel(item.name).." Quantity: "..quantity.." Price: "..item.price.." Payment Method: "..paymentMethod)
    TriggerServerEvent("lusty94_shops:server:Complete", shopType, item.name, quantity, item.price, paymentMethod)
    setBusy(false)
    LockInventory(false)
end)






--resource cleanup
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        setBusy(false)
        LockInventory(false) 
        if spawnedPeds then
            for k, v in pairs(spawnedPeds) do
                for _, ped in ipairs(v) do
                    if DoesEntityExist(ped) then
                        if TargetType == "qb" then
                            exports['qb-target']:RemoveTargetEntity(ped)
                        elseif TargetType == "ox" then
                            exports.ox_target:removeLocalEntity(ped)
                        end
                        SetEntityAsMissionEntity(ped, false, true)
                        DeletePed(ped)
                        SetEntityAsNoLongerNeeded(ped)
                    end
                end
            end
            spawnedPeds = {}
        end        
        print('^5--<^3!^5>-- ^7| Lusty94 |^5 Shops V1.0.0 Stopped Successfully ^5--<^3!^5>--^7')
    end
end)