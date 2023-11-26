Framework.RegisterUsableItem(Config.Items and Config.Items.NEWSPAPER or 'newspaper', function(source, item)
    local playerId = source
    local itemCount = Framework.GetItemCount(playerId, item.name)

    if itemCount > 0 then
        TriggerClientEvent('futte-newspaper:client:openNewspaper', playerId)
    end
end)

RegisterNetEvent('futte-newspaper:server:requestBuyNewsPaper', function(paperType)
    local playerId = source
    local player = Framework.getPlayer(source)
    local cash = Framework.GetItemCount(playerId, 'money')

    if paperType then
        if cash >= Config.Price then
            Framework.RemoveInventoryItem(playerId, 'cash', Config.Price)
            Framework.AddInventoryItem(playerId, Config.Items.NEWSPAPER, 1)
        else
            Framework.showNotify(source, l('NOT_ENOUGH_MONEY'), 'error')
        end
    end
end)

RegisterNetEvent('futte-newspaper:server:updateStory', function(data)
    local playerId = source
    local player = Framework.getPlayer(playerId)

    if player and data then
        if not IsReporter(playerId) then
            Framework.showNotify(playerId, l('NOT_ALLOWED'), 'error')
            return
        end

        local storyType = data.type and data.type:upper()

        if storyType then
            if STORIES_CACHE[storyType] then
                local id = #STORIES_CACHE[storyType] + 1

                STORIES_CACHE[storyType][id] = {
                    title = data.title,
                    story_type = storyType,
                    image = data.image,
                    jailed_player = '',
                    jailed_time = 0,
                    id = id,
                    publisher = player.charName,
                    body = data.body,
                    date = data.date,
                }

                table.sort(STORIES_CACHE[storyType], function(a, b)
                    return a.date > b.date
                end)

                Database.UpdateStory(data)

                SyncStories(-1, STORIES_CACHE)

                Framework.showNotify(playerId, l('STORY_UPDATED'), 'success')
            else
                print('futte-newspaper:server:updateStory: storyType is not valid')
            end
        else
            print('futte-newspaper:server:updateStory: storyType is nil')
        end
    end
end)

RegisterNetEvent('futte-newspaper:server:publishStory', function(data)
    local playerId = source
    local player = Framework.getPlayer(playerId)

    if player and data then
        if not IsReporter(playerId) then
            Framework.showNotify(playerId, l('NOT_ALLOWED'), 'error')
            return
        end

        local storyType = data.type and data.type:upper()

        if storyType then
            if STORIES_CACHE[storyType] then
                local id = #STORIES_CACHE[storyType] + 1

                STORIES_CACHE[storyType][id] = {
                    title = data.title,
                    story_type = storyType,
                    image = data.image,
                    jailed_player = '',
                    jailed_time = 0,
                    id = id,
                    publisher = player.charName,
                    body = data.body,
                    date = data.date,
                }

                table.sort(STORIES_CACHE[storyType], function(a, b)
                    return a.date > b.date
                end)

                Database.PublishStory(data, player.charName)

                SyncStories(-1, STORIES_CACHE)

                Framework.showNotify(playerId, l('STORY_PUBLISHED'), 'success')
            else
                print('futte-newspaper:server:publishStory: storyType is not valid')
            end
        else
            print('futte-newspaper:server:publishStory: storyType is nil')
        end
    end
end)

RegisterNetEvent('futte-newspaper:server:deleteStory', function(data)
    local playerId = source
    local player = Framework.getPlayer(playerId)
    local storyId = data and data.id

    if player and storyId then
        if not IsReporter(playerId) then
            Framework.showNotify(playerId, l('NOT_ALLOWED'), 'error')
            return
        end

        if STORIES_CACHE.SENTENCES[storyId] then
            STORIES_CACHE.SENTENCES[storyId] = nil
        end

        if STORIES_CACHE.NEWS[storyId] then
            STORIES_CACHE.NEWS[storyId] = nil
        end

        Database.DeleteStory(storyId)

        SyncStories(-1, STORIES_CACHE)

        Framework.showNotify(playerId, l('STORY_DELETED') ,'success')
    end
end)

function CreateJailStory(name, time)
    local id = #STORIES_CACHE.SENTENCES + 1

    STORIES_CACHE.SENTENCES[id] = {
        title = "",
        jailed_time = time,
        story_type = STORY_TYPES.JAIL,
        jailed_player = name,
        id = id,
        publisher = l('DEFAULT_PUBLISHER_NAME'),
        body = "",
        date = os.date('%Y-%m-%d %H:%M:%S')
    }

    Database.CreateJailStory(name, time)

    SetTimeout(1000, function()
        SyncStories(-1, STORIES_CACHE)
    end)
end

function SyncStories(target, data)
    TriggerLatentClientEvent('futte-newspaper:client:syncStories', target, 10000, data)
end

function IsReporter(playerId)
    local player = Framework.getPlayer(playerId)

    if player then
        return player.job and player.job.name == Config.Job.name
    end

    return false
end

exports('CreateJailStory', CreateJailStory)