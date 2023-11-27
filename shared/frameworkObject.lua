function IsResourceOnServer(resource)
    return GetResourceState(resource) == 'started'
end

function GetSharedObjectSafe()
    if IsResourceOnServer('qb-core') then
        return exports['qb-core']:GetCoreObject()
    elseif IsResourceOnServer('es_extended') then
        return exports['es_extended']:getSharedObject()
    else
        return nil
    end
end