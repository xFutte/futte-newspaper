local QBCore = exports['qb-core']:GetCoreObject()

local nilStory = {
    [1] = {
        id = 0,
        type = 'news',
        header = 'Empty paper',
        body = 'No news available today! Check again tomorrow!',
        datetime = os.date(),
        jailed_player = '',
        jailed_time = 1
    }
}

QBCore.Functions.CreateCallback('newsstands:getStories', function(source, cb, storyType)
    local data = exports.oxmysql:executeSync('SELECT * FROM newsstands WHERE story_type = ? ORDER BY id DESC LIMIT 7',
        {storyType})
    if data and data[1] then
        cb(data)
    else
        cb(nilStory)
    end
end)

-- Handle getting papers from stands

QBCore.Functions.CreateUseableItem("newspaper", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for k, v in pairs(item) do
        print(k, v)
    end

    if Player.Functions.GetItemByName(item.name) ~= nil then
        TriggerClientEvent('newsstands:newspaper:open', src)
    end
end)

-- Buy a newspaper
RegisterNetEvent('newsstands:buy', function(type)
    local Player = QBCore.Functions.GetPlayer(source)
    local cash = Player.PlayerData.money['cash']

    if type then
        if cash >= Config[type].price then

            Player.Functions.RemoveMoney("cash", Config[type].price)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['newspaper'], "add")
            Player.Functions.AddItem(type, 1)
        else
            TriggerClientEvent('QBCore:Notify', source,
                '$' .. Config[type].price .. ' required for buying a ' .. Config[type].name, 'error')
        end
    end
end)

-- Publish stories
QBCore.Commands.Add('newstory', 'Write a new story for the newspaper (God tier players)', {}, false, function(source)
    TriggerClientEvent('newsstands:client:writestory', source)
end, 'god')

RegisterNetEvent('newsstands:server:publishStory', function(data)
    -- Security checks
    local Player = QBCore.Functions.GetPlayer(source)
    local src = source

    if Player.PlayerData.job['name'] == 'reporter' then
        local player = GetPlayerPed(src)
        local coords1 = GetEntityCoords(player)
        local coords2 = vector3(442.09, -981.96, 30.69) -- Place the reporter need to be for publishing a new story
        local distance = #(coords1 - coords2)

        if distance < Config.minimum_distance then
            exports.oxmysql:insert('INSERT INTO newsstands (story_type, header, body) VALUES (?, ?, ?)',
                {'news', data.header, data.body})

            TriggerClientEvent('QBCore:Notify', src, 'Story has been published!', 'success')

            return true
        else
            TriggerClientEvent('QBCore:Notify', src, 'You are about to be banned - bye bye', 'error')

            return false
        end
    end
end)
