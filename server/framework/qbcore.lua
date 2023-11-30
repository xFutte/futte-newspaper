CreateThread(function()
    if Config.Framework == 'QBCORE' then
        --- @param playerId number
        --- @return any
        Framework.getPlayer = function(playerId)
            if not playerId then return nil end
            if not FrameworkObject then return nil end

            local p = promise.new()
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

            return Citizen.Await(p)
        end

        Framework.DoesItemExist = function(itemName)
            if not itemName then return false end
            if not FrameworkObject then return false end

            local itemList = FrameworkObject.Shared.Items
    
            return itemList and itemList[itemName] ~= nil
        end

        Framework.DoesJobExist = function(jobName)
            if not jobName then return false end

            local jobList = FrameworkObject.Shared.Jobs

            return jobList and jobList[jobName] ~= nil
        end

        Framework.showNotify = function(playerId, message, type)
            TriggerClientEvent('QBCore:Notify', playerId, message, type or NOTIFY_TYPES.SUCCESS)
        end

        Framework.GetItemCount = function(serverId, name)
            local player = Framework.getPlayer(serverId)
            local item = player.Functions.GetItemByName(name)
        
            if not item then
                return 0, {}
            end
        
            return item.amount or 0, item
        end

        Framework.GetInventoryItem = function(serverId, name)
            local player = Framework.getPlayer(serverId)
            local item = player.Functions.GetItemByName(name)

            if not item then
                return nil
            end

            return item
        end

        Framework.RemoveInventoryItem = function(serverId, name, count)
            local itemName = name:lower()
            local player = Framework.getPlayer(serverId)

            if not player then return end

            if itemName == 'money' then
                player.Functions.RemoveMoney('cash', count)
            else
                player.Functions.RemoveItem(name, count)
                TriggerClientEvent("inventory:client:ItemBox", serverId, FrameworkObject.Shared.Items[name], "remove", count) 
            end
        end

        Framework.AddInventoryItem = function(serverId, name, count, metadata)
            if not metadata then
                metadata = {}
            end

            local itemName = name:lower()
            local player = Framework.getPlayer(serverId)

            if not player then return end

            if itemName == 'money' then
                player.Functions.AddMoney('cash', count)
            else
                player.Functions.AddItem(name, count, nil, metadata)
                TriggerClientEvent("inventory:client:ItemBox", serverId, FrameworkObject.Shared.Items[name], "add", count) 
            end
        end

        Framework.RegisterUsableItem = function(itemName, callBack)
            if not FrameworkObject then return end
            FrameworkObject.Functions.CreateUseableItem(itemName, callBack)
        end
    end
end)