local QBCore = exports['qb-core']:GetCoreObject()

function CreateJailStory(name, time)
    exports.oxmysql:execute(
        'INSERT INTO newspaper (story_type, jailed_player, jailed_time, date) VALUES (?, ?, ?, CURRENT_TIMESTAMP)',
        {'jail', name, time})
end

QBCore.Functions.CreateCallback('newspaper:server:getStories', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local isReporter = false
    local reporterLevel = nil
    local amountOfNews = Config.AmountOfNews or 10
    local amountOfSentences = Config.AmountOfSentences or 10
    local playerName = Player.PlayerData.charinfo['firstname'] .. ' ' .. Player.PlayerData.charinfo['lastname']

    local reporterOnDuty = Player.PlayerData.job['onduty']

    if Player.PlayerData.job['name'] == 'reporter' then
        isReporter = true
        reporterLevel = Player.PlayerData.job.grade['level']
    end

    local news = exports.oxmysql:executeSync("SELECT * FROM newspaper WHERE story_type = ? ORDER BY id DESC LIMIT " ..
                                                 amountOfNews .. "", {'news'})

    local sentences = exports.oxmysql:executeSync(
        "SELECT * FROM newspaper WHERE story_type = ? ORDER BY id DESC LIMIT " .. amountOfNews .. "", {'jail'})

    cb(news, sentences, isReporter, reporterLevel, reporterOnDuty, playerName)

    reporterLevel = nil
end)

-- Handle getting papers from stands

QBCore.Functions.CreateUseableItem("newspaper", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Config.Inventory == 'qb' then
        if Player.Functions.GetItemByName(item.name) ~= nil then
            TriggerClientEvent('newspaper:client:openNewspaper', src)
        end
    elseif Config.Inventory == 'ox' then
        local count = exports.ox_inventory:Search(src, 'count', item.name)
        if count > 0 then
            TriggerClientEvent('newspaper:client:openNewspaper', src)
        end
    end
end)

-- Buy a newspaper
RegisterNetEvent('newspaper:buy', function(type)
    local Player = QBCore.Functions.GetPlayer(source)
    local cash = Player.PlayerData.money['bank']

    if type then
        if cash >= Config.Price then
            Player.Functions.RemoveMoney("bank", Config.Price)
            if Config.Inventory == 'qb' then
                TriggerClientEvent('QBCore:Notify', source, Lang:t("success.buy") .. Config.Price .." $",
                    'success')
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['newspaper'], "add")
            elseif Config.Inventory == 'ox' then
                TriggerClientEvent('QBCore:Notify', source, Lang:t("success.buy") .. Config.Price .." $",
                    'success')
                exports.ox_inventory:AddItem(source, type, 1)
            end
        else
            TriggerClientEvent('QBCore:Notify', source, '$' .. Config.Price .. Lang:t("error.money"),
                'error')
        end
    end
end)

RegisterNetEvent('newspaper:server:updateStory', function(data)
    local Player = QBCore.Functions.GetPlayer(source)
    local src = source
    local knownPlayers = {}

    knownPlayers[source] = true;

    if Player.PlayerData.job['name'] == 'reporter' then
        if not knownPlayers[source] then

            knownPlayers[source] = nil;
            DropPlayer(src, "Exploid detected") -- Update this to ban if you feel like it

            return
        else
            exports.oxmysql:insert('UPDATE newspaper SET title = ?, body = ?, image = ? WHERE id = ?',
                {data.title, data.body, data.image, data.id})

            TriggerClientEvent('QBCore:Notify', src, Lang:t("success.storyupdated"), 'success')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.notjobtoupdate"), 'success')
    end

    knownPlayers[source] = nil;

end)

RegisterNetEvent('newspaper:server:publishStory', function(data)
    local Player = QBCore.Functions.GetPlayer(source)
    local src = source
    local knownPlayers = {}

    local playerName = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname

    knownPlayers[source] = true;

    if Player.PlayerData.job['name'] == 'reporter' then
        if not knownPlayers[source] then

            knownPlayers[source] = nil;
            DropPlayer(src, "Exploid detected") -- Update this to ban if you feel like it

            return
        else
            exports.oxmysql:insert(
                'INSERT INTO newspaper (story_type, title, body, date, image, publisher) VALUES (?, ?, ?, ?, ?, ?)',
                {'news', data.title, data.body, data.date, data.image, playerName})

            TriggerClientEvent('QBCore:Notify', src, Lang:t("success.storypublished"), 'success')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.notjobtopublish"), 'success')
    end

    knownPlayers[source] = nil;
end)

RegisterNetEvent('newspaper:server:deleteStory', function(data)
    local Player = QBCore.Functions.GetPlayer(source)
    local src = source
    local knownPlayers = {}

    knownPlayers[source] = true;

    if Player.PlayerData.job['name'] == 'reporter' then
        if not knownPlayers[source] then
            -- Player not supposed to have access to this. Ban the player.

            knownPlayers[source] = nil;

            return
        else
            exports.oxmysql:execute('DELETE FROM newspaper WHERE id = ?', {data.id})

            TriggerClientEvent('QBCore:Notify', src, Lang:t("success.storydeleted"), 'success')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.errordelete"), 'success')
    end

    knownPlayers[source] = nil;
end)
