local Entity = require("Entity")
local component = require("Component")
local const = require("utils/constants")
local class = require("libs/middleclass")

local Player = class('Player', Entity)

function Player:initialize()
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
        collider = component.collider(50, 50),
        render = true
    }
    Entity.initialize(self, components)
end

return Player
