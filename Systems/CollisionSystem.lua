local Queue = require("utils/queue")
local class = require("libs/middleclass")
local System = require("Systems/System")

local CollisionSystem = class('CollisionSystem', System)

function CollisionSystem:initialize()
    self.name = 'collision'
    self.components = {}
    self.messages = Queue:new()
    System.register(self, self)
end

function CollisionSystem:process(dt, id, components)
    print('Collision system running!', dt)
end

function CollisionSystem:notify(message)
    self.messages:enqueue(message)
end

return CollisionSystem
