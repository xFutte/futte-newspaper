if IsDuplicityVersion() then
    IsInit = false
    Framework = {}
    print('SHARED ENVIROMENT: server FW')
else
    Framework = {}
    print('SHARED ENVIROMENT: client FW')
end

FrameworkObject = GetSharedObjectSafe()

CreateThread(function()
    InitFramework()

    Wait(1000)

    InitInfo()
end)

function InitFramework()
    local framework = nil

    if IsResourceOnServer('qb-core') then
        framework = 'QBCORE'
    elseif IsResourceOnServer('es_extended') then
        framework = 'ESX'
    else
        framework = 'STANDALONE'
    end

    if not Config.Framework and framework then
        Config.Framework = framework
    end

    if not Config.Inventory then
        local inventory = GetServerActiveInventory()

        if inventory then
            Config.Inventory = inventory
        else
            Config.Inventory = 'STANDALONE'
        end
    end

    Wait(0) -- Wait for initial serialization of data so we can use any of the functions below [ FW REQUIRED ]
end

function GetServerActiveInventory()
    local p = promise.new()

    if not Config.Inventories or next(Config.Inventories) == nil then
        return p:resolve(nil)
    end

    for k, inventoryName in pairs(Config.Inventories) do
        local isRunning = IsResourceOnServer(inventoryName)
    
        if isRunning then
            p:resolve(inventoryName)
            break
        end
    end

    return Citizen.Await(p)
end 

function InitInfo()
    IsInit = true
    local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version', 0)

    if IsDuplicityVersion() then
        if Config.DisableInitInfo then
            return
        end

        local itemState = Framework.DoesItemExist(Config.Items.NEWSPAPER) or 'UNK'
        local jobState = Framework.DoesJobExist(Config.Job.name) or 'UNK'
        
        sprint('\n^3%s^0\nVersion: ^3%s^0\nFramework: ^3%s^0\n^0Inventory: ^3%s\n^0\n^0Is required item [%s] registered: ^3%s^0\n^0Is required job [%s] registered in your FW: ^3%s\n^0', GetCurrentResourceName(), currentVersion, Config.Framework, Config.Inventory, Config.Items.NEWSPAPER, itemState and 'YES' or 'PLEASE DEFINE THE REQUIRED ITEM IN YOUR INVENTORY!', Config.Job.name, jobState and 'YES' or 'PLEASE DEFINE THE REQUIRED JOB IN YOUR FRAMEWORK!') 
    
        IsInit = false
    end
end

-- Used for getting data inside of a table
--- @param t table
--- @return any
function tprint(t)
    return print(json.encode(t, {indent = true}))
end

-- Used for getting table size
--- @param t table
--- @return number
function table.size(t)
    local c = 0
    
    for k, v in pairs(t) do
        c = c + 1
    end

    return c
end

function l(key)
    if Config.Locales == nil then
        Config.Locales.Lang = 'en'
    end

    return Config.Locales.Translations[Config.Locales.Lang][key]
end

function sprint(msg, ...)
    return print(string.format(msg, ...))
end