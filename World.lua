local utils = require("utils/utils")
local mydebug = require("utils/mydebug")
local system = require("System")
local World = {}

function World:new()
    local world = {
        switcher = {},
        entities = {},
        systems = {},
        orderedSystems = {}
    }
    self.__index = self
    return setmetatable(world, self)
end

function World:load()
    -- Loads all prerequisites
    self.systems = self:GetSystems()
    self.switcher = self:GetSwitcher()
    self.orderedSystems = self:GetOrderedSystemList()
    self.entities = {}
end

function World:update(dt)
    -- Updates all systems
    for _, system_proto in ipairs(self.orderedSystems) do
        local process = system_proto[1]
        system.update(dt, process, system_proto.components)
    end
end

function World:draw()
    -- Draws all entities
    for _, entity in pairs(self.entities) do
        if entity.components.render ~= nil then
            system.draw(entity)
        end
    end
end

function World:GetUniqueEntityId()
    return utils.uuid()
end

function World:add(entity)
    -- Splits the entity into components and adds them to the
    -- corresponding systems (PARSER)

    -- Add the entity to game entities
    self.entities[entity.id] = entity

    for entity_component, component_value in pairs(entity.components) do
        -- Get all the systems to which the component have the same aspect
        local sameAspectSystems = self.switcher[entity_component]

        if sameAspectSystems == nil then goto continue_add end

        for _, syst  in ipairs(sameAspectSystems) do
            -- Check if it is already an entry in the system
            local ent = syst.components[entity.id]

            if ent == nil then
                syst.components[entity.id] = {}
            end

            syst.components[entity.id][entity_component] = component_value
        end

        ::continue_add::
    end

    --mydebug.fprint(self.systems.health.components)

end

function World:remove(entity)
    -- Tells every system which registered that entity to remove it's
    -- information as it's no longer needed

    for component, _ in pairs(entity.components) do
        local sameAspectSystems = self.switcher[component]

        if sameAspectSystems == nil then goto continue_remove end

        for _, syst in ipairs(sameAspectSystems) do
            syst.components[entity.id] = nil
        end

        ::continue_remove::
    end

    -- Additional removal
    self.entities[entity.id] = nil
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

function World:GetOrderedSystemList()
    -- Returns the list of systems arranged in order of execution (update)
    return {
        self.systems.movement,
        self.systems.health
    }
end

return World
