Framework = {}

local JobCache = nil

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(receivedData)
    JobCache = receivedData
end)

CreateThread(function()
    repeat
        Wait(500)
    until FrameworkObject ~= nil

    Framework.fetchUserJob()
end)

Framework.fetchUserJob = function()
    local playerData = FrameworkObject.Functions.GetPlayerData()
    local charInfo = playerData and playerData.charInfo
    local fullName = charInfo and charInfo.firstname .. ' ' .. charInfo.lastname

    if not JobCache then
        if playerData then
            JobCache = playerData.job
        end
    end

    return JobCache, fullName
end