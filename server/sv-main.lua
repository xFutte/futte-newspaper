Framework.RegisterUsableItem(Config.Items and Config.Items.NEWSPAPER or 'futte-newspaper', function(source, item)
    local playerId = source
    local itemCount = Framework.GetItemCount(playerId, item.name)

    if itemCount > 0 then
        TriggerClientEvent('futte-newspaper:client:openNewspaper', playerId)
    end
end)

RegisterNetEvent('futte-newspaper:server:requestBuyNewsPaper', function(type)
    -- local Player = QBCore.Functions.GetPlayer(source)
    -- local cash = Player.PlayerData.money['cash']

    -- if type then
    --     if cash >= Config.Price then

    --         Player.Functions.RemoveMoney("cash", Config.Price)
    --         TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['futte-newspaper'], "add")
    --         Player.Functions.AddItem(type, 1)
    --     else
    --         TriggerClientEvent('QBCore:Notify', source, '$' .. Config.Price .. ' required for buying a futte-newspaper',
    --             'error')
    --     end
    -- end
end)

RegisterNetEvent('futte-newspaper:server:updateStory', function(data)
    local playerId = source
    local player = Framework.getPlayer(playerId)

    if player then
        Database.UpdateStory(data)
        SyncStories(-1, STORIES_CACHE)
    end
end)

RegisterNetEvent('futte-newspaper:server:publishStory', function(data)
    local playerId = source
    local player = Framework.getPlayer(playerId)

    if player then
        Database.PublishStory(data, player.charName)
        SyncStories(-1, STORIES_CACHE)
    end
end)

RegisterNetEvent('futte-newspaper:server:deleteStory', function(data)
    local playerId = source
    local player = Framework.getPlayer(playerId)
    local storyId = data and data.id

    if player and storyId then
        Database.DeleteStory(storyId)
        SyncStories(-1, STORIES_CACHE)
    end
end)

function CreateJailStory(name, time)
    Database.CreateJailStory(name, time)
end

function SyncStories(target, data)
    TriggerLatentClientEvent('futte-newspaper:client:syncStories', target, 10000, data)
end

exports('CreateJailStory', CreateJailStory)