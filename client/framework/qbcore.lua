CreateThread(function()
    if Config.Framework == 'QBCORE' then
        RegisterNetEvent('QBCore:Client:OnJobUpdate', function(receivedData)
            JobCache = receivedData
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
    end
end)