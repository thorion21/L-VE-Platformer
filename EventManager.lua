local class = require("libs/middleclass")
local SystemManager = require("Systems/System")

local EventManager = class('EventManager')

function EventManager:initialize(systems)
    print('Doing it right?')
    self.systems = systems
    self.events = {
        MSG_PLAY_SOUND = { self.systems.sound },
    }
end

function EventManager:signal(EVENT_TYPE, ...)
    local systems_to_send = self.events[EVENT_TYPE]

    for _, system in pairs(systems_to_send) do
        SystemManager:signal(system, { EVENT_TYPE, ... })
    end
end

return EventManager
