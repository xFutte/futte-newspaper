local QBCore = exports['qb-core']:GetCoreObject()
local story = {}

NewsStands = {"prop_news_disp_02a_s", "prop_news_disp_02c", "prop_news_disp_02e",
              "prop_news_disp_03c", "prop_news_disp_06a", "prop_news_disp_02a", "prop_news_disp_02d",
              "prop_news_disp_02b", "prop_news_disp_01a"}

JailStands = {"prop_news_disp_03a"}

RobberyStands = {"prop_news_disp_05a"}

-- Method for adding a newspaper to specific prop(s)
function AddItemToNewsStand(storyType, storyLabel, storyIcon, stands)
    exports['qb-target']:AddTargetModel(stands, {
        options = {
        { 
            label = storyLabel,
            icon = storyIcon,
            action = function(entity)

                if IsPedAPlayer(entity) then
                    return false
                end

                if storyType then
                    OpenNewspaper(storyType)
                end

                TriggerEvent('animations:client:EmoteCommandStart', {"clipboard"})

                SetNuiFocus(true, true)

            end
        }},
        distance = 1.5 -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
    })
end

AddItemToNewsStand('news', 'Read newspaper', 'fas fa-newspaper', NewsStands)
AddItemToNewsStand('jailtime', 'Jail sentences', 'fas fa-gavel', JailStands)
AddItemToNewsStand('robberies', 'Read flashnews', 'fas fa-bolt', RobberyStands)

RegisterNUICallback('hide', function()
    SetNuiFocus(false, false)
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)

function OpenNewspaper(storyType)
    QBCore.Functions.TriggerCallback('newsstands:getStories', function(data)
        SendNUIMessage({
            action = 'show',
            paper = storyType,
            story = data
        })

    end, storyType)
end

-- Publish a story manually

RegisterNUICallback('publishStory', function(data)
    TriggerServerEvent('newsstands:server:publishStory', data)

    SetNuiFocus(false, false)

    QBCore.Functions.Notify('Story has been published', 'success')

    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)

RegisterNetEvent('newsstands:client:writestory', function()
    SetNuiFocus(true, true)

    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard"})

    SendNUIMessage({
        action = 'newstory'
    })
end)

