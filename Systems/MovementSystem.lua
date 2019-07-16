local Queue = require("utils/queue")
local System = require("Systems/System")
local class = require("libs/middleclass")

local MovementSystem = class('MovementSystem', System)

function MovementSystem:initialize(SystemManager, EntityManager, ColliderWorld)
    self.name = 'movement'
    self.components = {}
    self.messages = Queue:new()
    self.SystemManager = SystemManager
    self.EntityManager = EntityManager
    self.ColliderWorld = ColliderWorld

    self.SystemManager:register(self, self)
end

function MovementSystem:process(dt, id, components)
    local position = components.position
    local velocity = components.velocity
    local entity = self.EntityManager:get(id)

    self.ColliderWorld:update(entity, position.x, position.y)
end

return MovementSystem
