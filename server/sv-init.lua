STORIES_CACHE = {
    NEWS = {},
    SENTENCES = {},
}

CreateThread(function()
    if IsResourceOnServer('rcore_prison') then
        print('^3[API] ^0rcore_prison detected, enabling jail stories.')

        AddEventHandler('rcore_prison:prisonerState', function(data)
            local state = data and data.state
            local playerId = data and data.serverId
            local prisonerData = data and data.prisoner

            if state == 'jailed' and prisonerData then
                local jailTime = prisonerData and prisonerData.jailTime or 0
                local prisonerName = prisonerData and prisonerData.name

                -- TODO: Requires to modify frontend with some variable with prefix jail format (seconds/mins/hours/days) to make proper sense.

                if prisonerName and jailTime > 0 then
                    CreateJailStory(prisonerName, jailTime)
                end
            end
        end)
    end

    STORIES_CACHE.NEWS = Database.FetchNews()
    STORIES_CACHE.SENTENCES = Database.FetchSentences()

    Wait(1000)

    SyncStories(-1, STORIES_CACHE)
end)