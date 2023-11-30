CreateThread(function()
    if Config.Framework == 'ESX' then
        RegisterNetEvent('esx:setJob', function(receivedData)
            -- ?? NOTE: Using qb-core job structure then we dont have to change the code in the future. (future refactor)

            JobCache = {
                type = 'none',
                onDuty = true,
                name = receivedData.name,
                payment = 0,
                isboss = receivedData.grade_label == 'Boss',
                grade = {
                    level = receivedData.grade,
                    name = receivedData.grade_label,
                },
                label = receivedData.label
            }
        end)

        Framework.fetchUserJob = function()
            local playerData = FrameworkObject.GetPlayerData()
            local fullName = nil
        
            if not JobCache then
                if playerData then 
                    fullName = ('%s %s'):format(playerData.firstName or 'UNK_FIRSTNAME', playerData.lastName or 'UNK_LASTNAME')

                    --??  NOTE: Using qb-core job structure then we dont have to change the code in the future. (future refactor)

                    JobCache = {
                        type = 'none',
                        onDuty = true,
                        name = playerData.job and playerData.job.name,
                        payment = 0,
                        isboss = playerData.job and playerData.job.grade_label == 'Boss',
                        grade = {
                            level = playerData.job and playerData.job.grade,
                            name = playerData.job and playerData.job.grade_label,
                        },
                        label = playerData.job and playerData.job.label
                    }
                end
            else
                if playerData then
                    fullName = ('%s %s'):format(playerData.firstName or 'UNK_FIRSTNAME', playerData.lastName or 'UNK_LASTNAME')
                end
            end

            return JobCache, fullName
        end
    end
end)