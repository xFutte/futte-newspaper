FrameworkObject = GetSharedObjectSafe()

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