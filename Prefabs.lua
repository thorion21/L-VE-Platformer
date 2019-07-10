local Entity = require("Entity")
local component = require("Component")
local utils = require("utils/utils")

local Prefabs = {}

function Prefabs:player()
    local entity = Entity:new()
    local components = {
        position = component.position(),
        health = component.health()
    }
    return utils.AddComponents(entity, components)
end

return Prefabs
