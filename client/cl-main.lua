STORIES_CACHE = {}

NEWSPAPER_OPEN_STATE = false

RegisterNetEvent('futte-newspaper:client:syncStories', function(serverData)
    STORIES_CACHE = serverData
end)

RegisterNetEvent('futte-newspaper:client:openNewspaper', function()
    if NEWSPAPER_OPEN_STATE then
        return print('Newspaper is already open')
    end

    NEWSPAPER_OPEN_STATE = true

    local paperModel = joaat("prop_cliff_paper")
    local newspaper = CreateObject(paperModel, 0, 0, 0, true, true, true)

    local plyPed = PlayerPedId()
    local animDict = "missfam4"
    local animName = "base"

    TaskPlayAnim(
        plyPed, animDict, animName, 
        3.0, 2.0, -1, 
        33, 0.0, 
        false, false, false
    )

    local pedBone = GetPedBoneIndex(plyPed, 18905)

    AttachEntityToEntity(
        newspaper, plyPed, pedBone,
        0.26, 0.06, 0.16, 
        320.0, 10.0, 0.0, 
        true, true, false, 
        true, 1, true
    )

    OpenNewsPaperUI()
end)


AddEventHandler('onClientResourceStart', function (resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      	return
    end

	ExitUI()
end)




