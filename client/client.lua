-- CUSTOM CODE
local QBCore = exports['qb-core']:GetCoreObject()

local NewsStands = {"prop_news_disp_02a_s", "prop_news_disp_02c", "prop_news_disp_05a", "prop_news_disp_02e",
                    "prop_news_disp_03c", "prop_news_disp_06a", "prop_news_disp_02a", "prop_news_disp_02d",
                    "prop_news_disp_02b", "prop_news_disp_01a", "prop_news_disp_03a"}

local function AddItemToNewsStand(storyType, paper, paperIcon, stands)
    exports['qb-target']:AddTargetModel(stands, {
        options = {{
            label = paper,
            icon = paperIcon,
            action = function(entity)

                if IsPedAPlayer(entity) then
                    return false
                end

                TriggerServerEvent('newsstands:buy', storyType)
                TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})
            end
        }},
        distance = 1.5
    })
end

AddItemToNewsStand('newspaper', 'Buy newspaper', 'fas fa-newspaper', NewsStands)

RegisterNetEvent('newsstands:client:openNewspaper', function()
    QBCore.Functions.TriggerCallback('newsstands:server:getStories', function(data, isReporter)
        SendNUIMessage({
            stories = data,
            isReporter = isReporter
        })
    end, 'news')

    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard"})
    SetNuiFocus(true, true)
end)

RegisterNUICallback('publishStory', function(data)
    TriggerServerEvent('newsstands:server:publishStory', data)

    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)

RegisterNUICallback('deleteStory', function(data)
    TriggerServerEvent('newsstands:server:deleteStory', data)
end)

RegisterNUICallback('newsstands:client:closeNewspaper', function(_, cb)
    cb({})
    SetNuiFocus(false, false)
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)

