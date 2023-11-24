function IsResourceOnServer(resource)
    return GetResourceState(resource) == 'started'
end

function GetSharedObjectSafe()
    if IsResourceOnServer('qb-core') then
        return exports['qb-core']:GetCoreObject()
    else
        return nil
    end
end