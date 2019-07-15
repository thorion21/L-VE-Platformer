local Queue = require("utils/queue")
local System = require("Systems/System")
local class = require("libs/middleclass")

local CollisionSystem = class('CollisionSystem', System)

function CollisionSystem:initialize()
    self.name = 'collision'
    self.components = {}
    self.messages = Queue:new()
    System.register(self, self)
end

function CollisionSystem:process(dt, id, components)
    --print('Collision system running!', dt)
end

return CollisionSystem
