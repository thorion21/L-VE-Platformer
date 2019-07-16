local Queue = require("utils/queue")
local System = require("Systems/System")
local class = require("libs/middleclass")

local DrawSystem = class('DrawSystem', System)

function DrawSystem:initialize(SystemManager, EntityManager)
    self.name = 'draw'
    self.components = {}
    self.messages = Queue:new()
    self.SystemManager = SystemManager
    self.EntityManager = EntityManager

    self.SystemManager:register(self, self)
end

function DrawSystem:process(entity)
    love.graphics.rectangle(
        'fill',
         entity.components.position.x,
         entity.components.position.y,
         50, 50
     )
end

return DrawSystem
