CreateThread(function()
    if Config.Framework == 'ESX' then
        --- @param playerId number
        --- @return any
        Framework.getPlayer = function(playerId)
            if not playerId then return nil end
            if not FrameworkObject then return nil end

            local p = promise.new()
            local tempUser = FrameworkObject.GetPlayerFromId(playerId)

            if tempUser then
                local characterName = 'UNK_NAME'

                if tempUser.variables then
                    local charInfo = tempUser.variables

                    if charInfo then
                        local firstname = charInfo.firstName
                        local lastname = charInfo.lastName

                        if firstname and lastname then
                            characterName = ('%s %s'):format(firstname, lastname)
                        end
                    end
                end

                local charId = tempUser.getIdentifier() or 'UNK_CHAR_ID'

                p:resolve({
                    charId = charId,
                    charName = characterName,
                    job = {
                        type = 'none',
                        onDuty = true,
                        name = tempUser.job.name,
                        payment = 0,
                        isboss = tempUser.job.grade_label == 'Boss',
                        grade = {
                            level = tempUser.job.grade,
                            name = tempUser.job.grade_label,
                        },
                        label = tempUser.job.label
                    } or {},
                })
            else
                p:resolve(nil)
            end

            return Citizen.Await(p)
        end

        Framework.showNotify = function(playerId, message, type)
            TriggerClientEvent('esx:showNotification', playerId, message, type or NOTIFY_TYPES.SUCCESS)
        end


        Framework.DoesItemExist = function(itemName)
            if not itemName then return false end
            if not FrameworkObject then return false end

            local itemList = FrameworkObject.Items

            return itemList and itemList[itemName] ~= nil
        end

        Framework.DoesJobExist = function(jobName)
            if not jobName then return false end
            
            local p = promise.new()
            local jobList = FrameworkObject and FrameworkObject.Jobs and FrameworkObject.Jobs[jobName]

            if jobList and next(jobList) then
                p:resolve(true)
            else
                p:resolve(false)
            end
        
            return Citizen.Await(p)
        end

        if not Config.UseOxInventory then
            Framework.GetItemCount = function(serverId, name)
                local xPlayer = FrameworkObject.GetPlayerFromId(serverId)
                local item = xPlayer.getInventoryItem(name)

                if item and item[1] and item[1].count then
                    return item[1].count
                end

                if item and item.count then
                    return item.count
                end

                return 0
            end

            Framework.AddInventoryItem = function(serverId, name, count)
                local xPlayer = FrameworkObject.GetPlayerFromId(serverId)
                xPlayer.addInventoryItem(name, count)
            end

            Framework.RemoveInventoryItem = function(serverId, name, count)
                local xPlayer = FrameworkObject.GetPlayerFromId(serverId)
                xPlayer.removeInventoryItem(name, count)
            end

            CreateThread(function()
                while not FrameworkObject do Wait(100) end
                RegisterUsableItem = function(itemName, callBack)
                    FrameworkObject.RegisterUsableItem(itemName, callBack)
                end
            end)
        else
            CreateThread(function()
                while not FrameworkObject do Wait(100) end
                RegisterUsableItem = function(itemName, callBack)
                    FrameworkObject.RegisterUsableItem(itemName, callBack)
                end
            end)
        end
    end
end)

