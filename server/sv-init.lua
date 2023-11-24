STORIES_CACHE = {
    NEWS = {},
    SENTENCES = {},
}

CreateThread(function()
    Wait(1000)

    if IsResourceOnServer('rcore_prison') then
        print('futte-newspaper: rcore_prison detected, enabling jail stories.')

        AddEventHandler('rcore_prison:prisonerState', function(data)
            local state = data and data.state
            local playerId = data and data.serverId
            local prisonerData = data and data.prisoner

            if state == 'jailed' and prisonerData then
                local jailTime = prisonerData and prisonerData.jailTime or 0
                local prisonerName = prisonerData and prisonerData.name

                if prisonerName and jailTime > 0 then
                    -- local state = CreateJailStory(prisonerName, jailTime)
                    -- print(state)
                end
            end
        end)
    end

    STORIES_CACHE.NEWS = Database.FetchNews()
    STORIES_CACHE.SENTENCES = Database.FetchSentences()

    SyncStories(-1, STORIES_CACHE)
end)