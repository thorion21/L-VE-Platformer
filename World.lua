local utils = require("utils/utils")
local mydebug = require("utils/mydebug")
local system = require("System")
local World = {}

function World:new()
    local world = {
        entitiesToAdd = {},
        entitiesToRemove = {},
        entities = {},
        systems = {},
    }
    self.__index = self
    return setmetatable(world, self)
end

function World:load()
    -- Loads all prerequisites
    self.systems = self:GetSystems()
end

function World:update(dt)
    -- Updates all systems

    for system, system_proto in pairs(self.systems) do
        local process = system_proto[1]
        process(table.unpack(system_proto.components))
    end
end

function World:draw()
    -- Draws all entities
end

function World:GetUniqueEntityId()
    return utils.uuid()
end

function World:add(entity)
    -- Splits the entity into components and adds them to the
    -- corresponding systems (PARSER)
    --mydebug.tprint(entity, mydebug.tprint(entity.components))

    local switcher = {
        -- Define what every system takes
        -- Each component is described here and returns a list
        -- of systems that use that component. For every system,
        -- adds that component
        position = {self.systems.movement, self.systems.health},
        health = {self.systems.health}
    }

    for entity_component, component_value in pairs(entity.components) do
        print(entity_component, component_value)
        local sameAspectSystems = switcher[entity_component]
        --mydebug.tprint(sameAspectSystems)
        --mydebug.tprint(sameAspectSystems)
        for _, syst  in ipairs(sameAspectSystems) do
            mydebug.tprint(syst.components)
--            table.insert(self.systems.syst.components,
            local ent = syst.components[entity.id]
            if ent ~= nil then
                -- This system does have another component
                ent[#ent + 1] = component_value
            else
                ent

            syst.components[entity.id]
        end
    end

end

function World:remove(entity)
    -- Tells every system which registered that entity to remove it's
    -- information as it's no longer needed
end

function World:GetSystems()
    return {
        movement = {system.movement, components = {}},
        health = {system.health, components = {}}
    }
end

return World
