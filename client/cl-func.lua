local PROPS_LIST = {
	['prop_cliff_paper'] = true,
}

local OriginTaskPlayAnim = TaskPlayAnim

TaskPlayAnim = function(ped, animDict, animName, duration, flag, flag2, flag3, flag4, flag5)
    if not DoesEntityExist(ped) then return end

    if not IsEntityPlayingAnim(ped, animDict, animName, 3) then
        RequestAnimDictLoad(animDict)
        OriginTaskPlayAnim(ped, animDict, animName, duration, flag, flag2, flag3, flag4, flag5)
    end
end

function RequestAnimDictLoad(dictName)
    if HasAnimDictLoaded(dictName) then return end

    RequestAnimDict(dictName)

    while not HasAnimDictLoaded(dictName) do
        Wait(100)
    end
end

local function AddItemToNewsStand(storyType, paper, paperIcon, stands)
    exports['qb-target']:AddTargetModel(stands, {
        options = {{
            label = paper,
            icon = paperIcon,
            action = function(entity)
                if IsPedAPlayer(entity) then
                    return false
                end

                TriggerServerEvent('futte-newspaper:server:requestBuyNewsPaper', storyType)
                TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})
            end
        }},
        distance = Config.Target.InteractDistance or 1.5
    })
end

function ClearAnyAttachedEntitiesToPed()
	for k, entity in pairs(GetGamePool('CObject')) do
		local mePed = PlayerPedId()

        if IsEntityAttachedToEntity(mePed, entity) then
			if PROPS_LIST[GetEntityArchetypeName(entity)] then
				SetEntityAsMissionEntity(entity, true, true)
				DeleteObject(entity)
				DeleteEntity(entity)
			end
		end
    end
end

AddItemToNewsStand(Config.Items.NEWSPAPER, Config.BuyNewspaperText, Config.BuyNewspaperIcon, Config.NewsStandsModels)
