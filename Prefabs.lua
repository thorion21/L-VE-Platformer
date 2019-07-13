local Entity = require("Entity")
local component = require("Component")
local utils = require("utils/utils")
local const = require("utils/constants")

local Prefabs = {}

function Prefabs:player()
    local entity = Entity:new()
    local components = {
        position = component.position(100, 500),
        health = component.health(30),
        input = true,
        velocity = component.velocity(
            0,
            0,
            20,
            const.PLAYER_FRICTION,
            const.PLAYER_MAX_SPEED
        ),
        render = component.render()
    }
    return utils.AddComponents(entity, components)
end

return Prefabs
