local QBCore = exports['qb-core']:GetCoreObject()
local story = {}

NewsStands = {"prop_news_disp_02a_s", "prop_news_disp_02c", "prop_news_disp_02e",
              "prop_news_disp_03c", "prop_news_disp_06a", "prop_news_disp_02a", "prop_news_disp_02d",
              "prop_news_disp_02b", "prop_news_disp_01a"}

JailStands = {"prop_news_disp_03a"}

RobberyStands = {"prop_news_disp_05a"}

function AddItemToNewsStand(storyType, storyLabel, storyIcon, stands)
    exports['qb-target']:AddTargetModel(stands, { -- This defines the models, can be a string or a table
        options = { -- This is your options table, in this table all the options will be specified for the target to accept
        { -- This is the first table with options, you can make as many options inside the options table as you want, -- This is the icon that will display next to this trigger option
            label = storyLabel, -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
            icon = storyIcon, -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
            action = function(entity) -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL

                if IsPedAPlayer(entity) then
                    return false
                end -- This will return false if the entity interacted with is a player and otherwise returns true

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

