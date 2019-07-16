local Queue = require("utils/queue")
local System = require("Systems/System")
local class = require("libs/middleclass")

local CollisionSystem = class('CollisionSystem', System)


function CollisionSystem:initialize(SystemManager, EntityManager, ColliderWorld)
    self.name = 'collision'
    self.components = {}
    self.messages = Queue:new()
    self.SystemManager = SystemManager
    self.EntityManager = EntityManager
    self.ColliderWorld = ColliderWorld

    self.SystemManager:register(self, self)
end

function CollisionSystem:process(dt, id, components)
    local position = components.position
    local velocity = components.velocity
    local entity = self.EntityManager:get(id)

    local goal_x = position.x + velocity.x * dt
    local goal_y = position.y + velocity.y * dt
    local actual_x, actual_y, cols, len = self.ColliderWorld:check(entity, goal_x, goal_y, filter)

    position.x = actual_x
    position.y = actual_y

    for i = 1, len do
        local other = cols[i].other.components

        if other.isMap then
            entity.components.velocity.y = entity.components.velocity.y - 100 * dt
        end

    end

end

function filter(item, other)
    local comps = item.components

    if other.components.isMap then return 'slide' end
end

return CollisionSystem
