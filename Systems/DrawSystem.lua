local Queue = require("utils/queue")
local class = require("libs/middleclass")
local System = require("Systems/System")

local DrawSystem = class('DrawSystem', System)

function DrawSystem:initialize()
    self.name = 'draw'
    self.components = {}
    self.messages = Queue:new()
    System.register(self, self)
end

function DrawSystem:process(entity)
    love.graphics.rectangle(
        'fill',
         entity.components.position.x,
         entity.components.position.y,
         50, 50
     )
end

function DrawSystem:notify(message)
    self.messages:enqueue(message)
end

return DrawSystem
