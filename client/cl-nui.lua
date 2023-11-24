RegisterNUICallback('publishStory', function(data)
    TriggerServerEvent('futte-newspaper:server:publishStory', data)
end)

RegisterNUICallback('updateStory', function(data)
    TriggerServerEvent('futte-newspaper:server:updateStory', data)
end)

RegisterNUICallback('deleteStory', function(data)
    TriggerServerEvent('futte-newspaper:server:deleteStory', data)
end)

RegisterNUICallback('newspaper:client:closeNewspaper', function(_, cb)
    cb({})
    ExitUI()
end)

function ExitUI()
    SetNuiFocus(false, false)

    local plyPed = PlayerPedId()

    if NEWSPAPER_OPEN_STATE then
        NEWSPAPER_OPEN_STATE = false
    end

    ClearPedTasks(plyPed)
    ClearAnyAttachedEntitiesToPed()
end

function OpenNewsPaperUI()
    local job, playerName = Framework.fetchUserJob()

    Wait(0)

    SendNUIMessage({
        stories = STORIES_CACHE.NEWS and next(STORIES_CACHE.NEWS) and STORIES_CACHE.NEWS or {},
        sentences = STORIES_CACHE.SENTENCES and next(STORIES_CACHE.SENTENCES) and STORIES_CACHE.SENTENCES or {},
        isReporter = job and job.name == Config.Job.name,
        reporterLevel = job and job.grade.level or 0,
        reporterOnDuty = job and job.onduty,
        playerName = playerName or 'UNK-NAME'
    })

    SetNuiFocus(true, true)
end