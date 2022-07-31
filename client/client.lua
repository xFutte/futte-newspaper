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

AddItemToNewsStand('newspaper', Config.BuyNewspaperText, Config.BuyNewspaperIcon, NewsStands)

RegisterNetEvent('newsstands:client:openNewspaper', function()
    QBCore.Functions.TriggerCallback('newsstands:server:getStories', function(news, jail, isReporter, reporterLevel, reporterOnDuty, playerName)
        SendNUIMessage({
            stories = news,
            sentences = jail,
            isReporter = isReporter,
            reporterLevel = reporterLevel,
            reporterOnDuty = reporterOnDuty,
            playerName = playerName,
        })
    end)
    
	  newspaper = CreateObject(GetHashKey("prop_cliff_paper"), 0, 0, 0, true, true, true)
	  RequestAnimDict("missfam4")
	  while not HasAnimDictLoaded("missfam4") do Citizen.Wait(5) end
	  TaskPlayAnim(PlayerPedId(), "missfam4", "base", 3.0, 2.0, -1, 33, 0.0, false, false, false)
	  AttachEntityToEntity(newspaper, PlayerPedId(), GetPedBoneIndex(GetPlayerPed(-1), 18905), 0.26, 0.06, 0.16, 320.0, 310.0, 0.0, true, true, false, true, 1, true)
    SetNuiFocus(true, true)
end)

RegisterNUICallback('publishStory', function(data)
    TriggerServerEvent('newsstands:server:publishStory', data)
end)

RegisterNUICallback('updateStory', function(data)
    TriggerServerEvent('newsstands:server:updateStory', data)
end)

RegisterNUICallback('deleteStory', function(data)
    TriggerServerEvent('newsstands:server:deleteStory', data)
end)

RegisterNUICallback('newsstands:client:closeNewspaper', function(_, cb)
    cb({})
    SetNuiFocus(false, false)
	  ClearPedTasks(PlayerPedId())
	  Wait(200)
	  DeleteObject(newspaper)
end)

