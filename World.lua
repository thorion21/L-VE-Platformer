local utils = require("utils/utils")
local mydebug = require("utils/mydebug")
local system = require("System")
local World = {}

function World:new()
    local world = {
        entitiesToAdd = {},
        entitiesToRemove = {},
        switcher = {},
        entities = {},
        systems = {},
    }
    self.__index = self
    return setmetatable(world, self)
end

function World:load()
    -- Loads all prerequisites
    self.systems = self:GetSystems()
    self.switcher = self:GetSwitcher()
end

function World:update(dt)
    -- Updates all systems
    for sys_name, system_proto in pairs(self.systems) do
        local process = system_proto[1]
        system.update(dt, process, system_proto.components)
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

    for entity_component, component_value in pairs(entity.components) do
        -- Get all the systems to which the component have the same aspect
        local sameAspectSystems = self.switcher[entity_component]

        for _, syst  in ipairs(sameAspectSystems) do
            -- Check if it is already an entry in the system
            local ent = syst.components[entity.id]

            if ent == nil then
                syst.components[entity.id] = {}
            end

            syst.components[entity.id][entity_component] = component_value
        end
    end

    --mydebug.fprint(self.systems.health.components)

end

function World:remove(entity)
    -- Tells every system which registered that entity to remove it's
    -- information as it's no longer needed

    for component, _ in pairs(entity.components) do
        local sameAspectSystems = self.switcher[component]

        for _, syst in ipairs(sameAspectSystems) do
            syst.components[entity.id] = nil
        end
    end

    -- Additional removal
    entity.components = nil
    entity = nil
end

function World:GetSwitcher()
    return {
        -- Each component is described here and returns a list
        -- of systems that use that component.
        position = {self.systems.movement, self.systems.health},
        health = {self.systems.health}
    }
end

function World:GetSystems()
    return {
        movement = {system.movement, components = {}},
        health = {system.health, components = {}}
    }
end

return World
