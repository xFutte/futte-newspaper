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

RegisterNetEvent('newsstands:server:insertStory', function(data)
    exports.oxmysql.executeSync('INSERT INTO newsstands (story_type, header, body, datetime) VALUES (?, ?, ?, ?)',
        {data.storyType, data.header, data.body, os.time('%x')})
end)

QBCore.Functions.CreateCallback('newsstands:getStories', function(source, cb, storyType)
    local data = exports.oxmysql:executeSync('SELECT * FROM newsstands WHERE story_type = ? ORDER BY id DESC LIMIT 7',
        {storyType})

    if data and data[1] then
        cb(data)
    else
        cb(nilStory)
    end
end)

QBCore.Commands.Add('newstory', 'Write a new story for the newspaper (God tier players)', {}, false, function(source)
    TriggerClientEvent('newsstands:client:writestory', source)
end, 'god')


RegisterNetEvent('newsstands:server:publishStory', function(data)
    exports.oxmysql:insert('INSERT INTO newsstands (story_type, header, body) VALUES (?, ?, ?)',
        {'news', data.header, data.body})  
end)

