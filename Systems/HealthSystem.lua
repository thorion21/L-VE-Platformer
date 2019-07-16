local Queue = require("utils/queue")
local System = require("Systems/System")
local class = require("libs/middleclass")

local HealthSystem = class('HealthSystem')

function HealthSystem:initialize(SystemManager, EntityManager)
    self.name = 'health'
    self.components = {}
    self.messages = Queue:new()
    self.SystemManager = SystemManager
    self.EntityManager = EntityManager

    self.SystemManager:register(self, self)
end

function HealthSystem:process(dt, id, components)
    --print('Health system running!', dt)
    while not self.messages:isEmpty()
    do
        local val = self.messages:dequeue()
        print('HEALTH SYSTEM\t', val[1], val[2])
    end
end

return HealthSystem
