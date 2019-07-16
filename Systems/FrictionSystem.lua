local m8 = require("utils/math")
local Queue = require("utils/queue")
local System = require("Systems/System")
local const = require("utils/constants")
local class = require("libs/middleclass")

local FrictionSystem = class('FrictionSystem', System)

function FrictionSystem:initialize(SystemManager, EntityManager)
    self.name = 'friction'
    self.components = {}
    self.messages = Queue:new()
    self.SystemManager = SystemManager
    self.EntityManager = EntityManager

    self.SystemManager:register(self, self)
end

function FrictionSystem:process(dt, id, components)
    local position = components.position
    local velocity = components.velocity

    local speed = m8.distance0(velocity.x, velocity.y)
    local sign = m8.sign(velocity.x)

    if speed > velocity.friction then
        velocity.x = sign * (math.abs(velocity.x) - velocity.friction)
    else
        velocity.x = 0
    end

    velocity.y = math.min(velocity.y + const.GRAVITY * dt, const.MAX_VELOCITY)
end

return FrictionSystem
