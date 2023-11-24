Framework = {}

--- @param playerId number
--- @return any
Framework.getPlayer = function(playerId)
    if not playerId then return nil end
    if not FrameworkObject then return nil end

    local p = promise.new()

    if IsResourceOnServer('qb-core') then
        local tempUser = FrameworkObject.Functions.GetPlayer(playerId)

        if tempUser then
            local playerData = tempUser and tempUser.PlayerData
            local characterData = playerData and tempUser.PlayerData.charinfo
            local characterName = 'UNK_CHAR_NAME'

            if characterData then
                local firstname = characterData.firstname
                local lastname = characterData.lastname

                if firstname and lastname then
                    characterName = ('%s %s'):format(firstname, lastname)
                end
            end

            p:resolve({
                Functions = tempUser.Functions,
                charId = playerData.citizenid or 'UNK_CHAR_ID',
                charName = characterName,
                job = playerData.job or {},
            })
        else
            p:resolve(nil)
        end
    else
        p:resolve(nil)
    end

    return Citizen.Await(p)
end

Framework.showNotify = function(playerId, message, type)
    if IsResourceOnServer('qb-core') then
        TriggerClientEvent('QBCore:Notify', playerId, message, type or NOTIFY_TYPES.SUCCESS)
    end
end

Framework.GetItemCount = function(serverId, name)
    if IsResourceOnServer('qb-core') then
        local player = Framework.getPlayer(serverId)
        local item = player.Functions.GetItemByName(name)
    
        if not item then
            return 0, {}
        end
    
        return item.amount or 0, item
    else
        return 0, {}
    end
end

Framework.GetInventoryItem = function(serverId, name)
    if IsResourceOnServer('qb-core') then
        local player = Framework.getPlayer(serverId)
        local item = player.Functions.GetItemByName(name)

        if not item then
            return nil
        end

        return item
    else
        return nil
    end
end

Framework.RemoveInventoryItem = function(serverId, name, count)
    local itemName = name:lower()
    local player = Framework.getPlayer(serverId)

    if IsResourceOnServer('qb-core') then
       if not player then return end

        if itemName == 'money' then
            player.Functions.RemoveMoney('cash', count)
        else
            player.Functions.RemoveItem(name, count)
            TriggerClientEvent("inventory:client:ItemBox", serverId, FrameworkObject.Shared.Items[name], "remove", count) 
        end
    end
end

Framework.AddInventoryItem = function(serverId, name, count, metadata)
    if not metadata then
        metadata = {}
    end

    local itemName = name:lower()
    local player = Framework.getPlayer(serverId)

    if IsResourceOnServer('qb-core') then
        if not player then return end

        if itemName == 'money' then
            player.Functions.AddMoney('cash', count)
        else
            player.Functions.AddItem(name, count, nil, metadata)
            TriggerClientEvent("inventory:client:ItemBox", serverId, FrameworkObject.Shared.Items[name], "add", count) 
        end
    end
end

Framework.RegisterUsableItem = function(itemName, callBack)
    if not FrameworkObject then return end

    if IsResourceOnServer('qb-core') then
        FrameworkObject.Functions.CreateUseableItem(itemName, callBack)
    end
end
