local Queue = require("utils/queue")
local class = require("libs/middleclass")
local System = require("Systems/System")

local HealthSystem = class('HealthSystem', System)

function HealthSystem:initialize()
    self.name = 'health'
    self.components = {}
    self.messages = Queue:new()
    System.register(self, self)
end

function HealthSystem:process(dt, id, components)
    print('Health system running!', dt)
end

function HealthSystem:notify(message)
    self.messages:enqueue(message)
end

return HealthSystem
