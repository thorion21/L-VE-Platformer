local Queue = require("utils/queue")
local System = require("Systems/System")
local class = require("libs/middleclass")

local CollisionSystem = class('CollisionSystem', System)

function CollisionSystem:initialize(SystemManager)
    self.name = 'collision'
    self.components = {}
    self.messages = Queue:new()
    self.SystemManager = SystemManager

    self.SystemManager:register(self, self)
end

function CollisionSystem:process(dt, id, components)
    --print('Collision system running!', dt)
end

return CollisionSystem
