local class = require("libs/middleclass")
local SystemManager = require("Systems/System")

local EventManager = class('EventManager')

function EventManager:initialize(systems, SystemManager)
    self.systems = systems
    self.SystemManager = SystemManager
    self.events = {
        MSG_PLAY_SOUND = { self.systems.health },
    }
end

function EventManager:signal(EVENT_TYPE, ...)
    local systems_to_send = self.events[EVENT_TYPE]

    for _, system in pairs(systems_to_send) do
        self.SystemManager:announce(system, { EVENT_TYPE, ... })
    end
end

return EventManager
