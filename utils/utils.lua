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

return utils
