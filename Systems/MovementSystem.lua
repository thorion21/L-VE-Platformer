local Queue = require("utils/queue")
local System = require("Systems/System")
local class = require("libs/middleclass")

local MovementSystem = class('MovementSystem', System)

function MovementSystem:initialize()
    self.name = 'movement'
    self.components = {}
    self.messages = Queue:new()
    System.register(self, self)
end

function MovementSystem:process(dt, id, components)
    local position = components.position
    local velocity = components.velocity

    position.x = position.x + velocity.x * dt
    position.y = position.y + velocity.y * dt

    -- Will be deleted
    if position.y >= 1100 then
        position.y = 1100
        velocity.y = 0
    end
end

return MovementSystem
