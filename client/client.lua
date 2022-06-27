local QBCore = exports['qb-core']:GetCoreObject()
local story = {}

local NewsStands = {"prop_news_disp_02a_s", "prop_news_disp_02c", "prop_news_disp_05a", "prop_news_disp_02e",
                    "prop_news_disp_03c", "prop_news_disp_06a", "prop_news_disp_02a", "prop_news_disp_02d",
                    "prop_news_disp_02b", "prop_news_disp_01a"}

local JailStands = {"prop_news_disp_03a"}

local function AddItemToNewsStand(storyType, paper, paperIcon, stands)
    exports['qb-target']:AddTargetModel(stands, { 
        options = { 
        { 
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

RegisterNetEvent('newsstands:newspaper:open', function(type)
    QBCore.Functions.TriggerCallback('newsstands:getStories', function(data)
        SendNUIMessage({
            action = 'show',
            paper = type,
            story = data
        })
    end, 'news')

    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard"})
    SetNuiFocus(true, true)
end)

RegisterNUICallback('hide', function()
    SetNuiFocus(false, false)
    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)

RegisterNUICallback('publishStory', function(data)
    TriggerServerEvent('newsstands:server:publishStory', data)

    SetNuiFocus(false, false)

    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
end)

RegisterNetEvent('newsstands:client:writestory', function()
    SetNuiFocus(true, true)

    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard"})

    SendNUIMessage({
        action = 'newstory'
    })
end)

AddItemToNewsStand('newspaper', 'Buy newspaper', 'fas fa-newspaper', NewsStands)
AddItemToNewsStand('jailtime', 'Jail sentences', 'fas fa-gavel', JailStands)
