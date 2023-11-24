FrameworkObject = GetSharedObjectSafe()

-- Used for getting data inside of a table
--- @param t table
--- @return any
function tprint(t)
    return print(json.encode(t, {indent = true}))
end