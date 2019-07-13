local utils = {}
math.randomseed(69)
local random = math.random

function utils.uuid()
    local template ='xxxxxxx'
    return string.gsub(template, '[xy]', function (c)
        local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
        return string.format('%x', v)
    end)
end

function utils.AddComponents(entity, components)
    assert(type(components) == 'table', "components not a table!")
    for c_type, c_value in pairs(components) do
        entity.components[c_type] = c_value
    end

    return entity
end

function utils.ToInt(boolean)
    return boolean and 1 or 0
end

return utils
