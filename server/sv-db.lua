Database = {
    Queries = {
        CREATE_JAIL_STORY = [[
            INSERT INTO newspaper (story_type, jailed_player, jailed_time, date) VALUES (?, ?, ?, CURRENT_TIMESTAMP)
        ]],
        FETCH_NEWS_BY_STORY_TYPE = [[
            SELECT * FROM newspaper WHERE story_type = ? ORDER BY id DESC LIMIT ?
        ]],
        PUBLISH_STORY = [[
            INSERT INTO newspaper (story_type, title, body, date, image, publisher) VALUES (?, ?, ?, ?, ?, ?)
        ]],
        DELETE_STORY = [[
            DELETE FROM newspaper WHERE id = ?
        ]],
        UPDATE_STORY = [[
            UPDATE newspaper SET title = ?, body = ?, image = ? WHERE id = ?
        ]]
    }
}

Database.DeleteStory = function(id)
    if not id then return end

    return exports.oxmysql:execute(Database.Queries.DELETE_STORY, {id})
end

Database.UpdateStory = function(data)
    if not data then return end

    return exports.oxmysql:execute(Database.Queries.UPDATE_STORY, {
        data.title, data.body, data.image, data.id
    })
end

--- Define a story in the database.
--- @param data table
--- @param publisherName string
--- @return any state
Database.PublishStory = function(data, publisherName)
    if not data then return end
    if not publisherName then return end

    return exports.oxmysql:execute(Database.Queries.PUBLISH_STORY, {
        STORY_TYPES.NEWS, 
        data.title, data.body, data.date, data.image, 
        publisherName
    })
end

--- Define target citizen a jail story in the database.
--- @param characterName string
--- @param jailTime number
Database.CreateJailStory = function(characterName, jailTime)
    if not characterName then return end
    if not jailTime then return end

    return exports.oxmysql:execute(Database.Queries.CREATE_JAIL_STORY, {
        STORY_TYPES.JAIL, 
        characterName, jailTime
    })
end

--- Fetch news from the database.
--- @return table
Database.FetchNews = function()
    local totalAmount = Config.AmountOfNews or 10

    return exports.oxmysql:executeSync(Database.Queries.FETCH_NEWS_BY_STORY_TYPE, {
        STORY_TYPES.NEWS, totalAmount
    })
end

--- Fetch sentences from the database.
--- @return table
Database.FetchSentences = function()
    local totalAmount = Config.AmountOfSentences or 10

    return exports.oxmysql:executeSync(Database.Queries.FETCH_NEWS_BY_STORY_TYPE, {
        STORY_TYPES.JAIL, totalAmount
    })
end