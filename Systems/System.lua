local class = require("libs/middleclass")

local System = class('System')

function System:initialize()
    self.systems = {}
end

function System:register(new_system)
    self.systems[new_system.name] = new_system
end

function System:update(system, dt)
    for id, components in pairs(self.systems[system.name].components) do
        system:process(dt, id, components)
    end
end

function System:add(system, id, component)
    -- Add components to specified system
    -- Check if it is already an entry in the system
    local ent = system.components[id]

    if ent == nil then
        system.components[id] = {}
    end

    local ctype, cvalue = component[1], component[2]

    system.components[id][ctype] = cvalue
end

function System:remove(system, id)
    system.components[id] = nil
end

function System:signal(system, message)
    system.messages.enqueue(message)
end

return System
