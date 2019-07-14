local utils = require("utils/utils")
local mydebug = require("utils/mydebug")
local system = require("System")
local bump = require("libs/bump")
local Queue = require("utils/queue")
local World = {}

function World:new()
    local world = {
        entitiesToAdd = {},
        entitiesToRemove = {},
        switcher = {},
        entities = {},
        systems = {},
        orderedSystems = {},
        colliderWorld = {}
    }
    self.__index = self
    return setmetatable(world, self)
end

function World:load()
    -- Loads all prerequisites
    self.entities = {}
    self.entitiesToAdd = {}
    self.entitiesToRemove = {}
    self.systems = self:GetSystems()
    self.switcher = self:GetSwitcher()
    self.orderedSystems = self:GetOrderedSystemList()
    self.colliderWorld = bump.newWorld(64)
    system.load(self, self.entities, self.colliderWorld)
end

function World:update(dt)
    -- Remove all old entities (REVERSED ORDER)
    local e2r = self.entitiesToRemove
    for idx = #e2r, 1, -1 do
        self:removeFromWorld(e2r[idx])
        self.colliderWorld:remove(e2r[idx])
        e2r[idx] = nil
    end

    -- Add all new entities (REVERSED ORDER)
    local e2a = self.entitiesToAdd
    for idx = #e2a, 1, -1 do
        local e2a_comp = e2a[idx].components
        self:addInWorld(e2a[idx])

        -- If the entity has a collider component
        if e2a_comp.collider ~= nil then
            self.colliderWorld:add(
                e2a[idx],
                e2a_comp.position.x,
                e2a_comp.position.y,
                e2a_comp.collider.width,
                e2a_comp.collider.height
            )
        end

        e2a[idx] = nil
    end

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
    local e2a = self.entitiesToAdd
    e2a[#e2a + 1] = entity
    return entity
end

function World:addInWorld(entity)
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

end

function World:remove(entity)
    local e2r = self.entitiesToRemove
    e2r[#e2r + 1] = entity
    return entity
end

function World:removeFromWorld(entity)
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
        position = {
            self.systems.movement,
            self.systems.friction,
            self.systems.collision
        },
        health = { self.systems.health },
        input = { self.systems.input },
        velocity = {
            self.systems.movement,
            self.systems.input,
            self.systems.friction,
            self.systems.collision
        },
        collider = { self.systems.collision }
    }
end

function World:GetSystems()
    return {
        movement = {
            system.movement,
            components = {},
            messages = Queue:new()
        },
        health = {
            system.health,
            components = {},
            messages = Queue:new()
        },
        input = {
            system.input,
            components = {},
            messages = Queue:new()
        },
        friction = {
            system.friction,
            components = {},
            messages = Queue:new()
        },
        collision = {
            system.collision,
            components = {},
            messages = Queue:new()
        }
    }
end

function World:GetOrderedSystemList()
    -- Returns the list of systems arranged in order of execution (update)
    return {
        self.systems.input,
        self.systems.friction,
        self.systems.collision,
        self.systems.movement,
        self.systems.health,
    }
end

return World
