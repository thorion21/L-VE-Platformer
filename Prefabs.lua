local Entity = require("Entity")
local component = require("Component")
local utils = require("utils/utils")

local Prefabs = {}

function Prefabs:player()
    local entity = Entity:new()
    local components = {
        position = component.position(100, 200),
        health = component.health(30)
    }
    return utils.AddComponents(entity, components)
end

return Prefabs
