
local bump = require("libs/bump")
local Queue = require("utils/queue")
local utils = require("utils/utils")
local class = require("libs/middleclass")
local EventManager = require("EventManager")
local EntityManager = require("EntityManager")
local SystemManager = require("Systems/System")
local DrawSystem = require("Systems/DrawSystem")
local InputSystem = require("Systems/InputSystem")
local HealthSystem = require("Systems/HealthSystem")
local FrictionSystem = require("Systems/FrictionSystem")
local MovementSystem = require("Systems/MovementSystem")
local CollisionSystem = require("Systems/CollisionSystem")

local World = class('World')

function World:initialize()
    -- Loads all prerequisites
    self.SM = SystemManager:initialize()

    self.entities = {}
    self.entitiesToAdd = Queue:new()
    self.entitiesToRemove = Queue:new()
    self.colliderWorld = bump.newWorld(64)
    self.EnM = EntityManager:new(self.entities)

    self.systems = self:GetSystems()
    self.switcher = self:GetSwitcher()
    self.orderedSystems = self:GetOrderedSystemList()


    self.EvM = EventManager:new(self.systems, self.SM)

    self.SM:set(self.EvM)
end

function World:update(dt)

    -- Remove all old entities
    local e2r = self.entitiesToRemove
    while not e2r:isEmpty()
    do
        local elem = e2r:dequeue()
        local elem_comp = elem.components

        -- If the entity has a collider component
        self:removeFromWorld(elem)

        if elem_comp.collider ~= nil then
            self.colliderWorld:remove(elem)
        end

        self.entities[elem.id] = nil
        elem.components = nil
        elem = nil
    end

    -- Add all new entities
    local e2a = self.entitiesToAdd
    while not e2a:isEmpty()
    do
        local elem = e2a:dequeue()
        local elem_comp = elem.components
        self:addInWorld(elem)

        -- If the entity has a collider component
        if elem_comp.collider ~= nil then
            self.colliderWorld:add(
                elem,
                elem_comp.position.x,
                elem_comp.position.y,
                elem_comp.collider.width,
                elem_comp.collider.height
            )
        end
    end

    -- Updates all systems
    for _, system in ipairs(self.orderedSystems) do
        SystemManager:update(system, dt)
    end

end

function World:draw()
    -- Draws all entities
    for _, entity in pairs(self.entities) do
        if entity.components.render ~= nil then
            self.systems.draw:process(entity)
        end
    end
end

function World:GetUniqueEntityId()
    return utils.uuid()
end

function World:add(entity)
    return self.entitiesToAdd:enqueue(entity)
end

function World:addInWorld(entity)
    -- Splits the entity into components and adds them to the
    -- corresponding systems (PARSER)

    -- Add the entity to game entities
    self.entities[entity.id] = entity

    if entity.components.isMap ~= nil then return end

    for entity_component, component_value in pairs(entity.components) do
        -- Get all the systems to which the component have the same aspect
        local sameAspectSystems = self.switcher[entity_component]

        if sameAspectSystems == nil then goto continue_add end

        for _, system  in ipairs(sameAspectSystems) do
            SystemManager:add(
                system,
                entity.id,
                {
                    entity_component,
                    component_value
                }
            )
        end

        ::continue_add::
    end

end

function World:remove(entity)
    return self.entitiesToRemove:enqueue(entity)
end

function World:removeFromWorld(entity)
    -- Tells every system which registered that entity to remove it's
    -- information as it's no longer needed

    for component, _ in pairs(entity.components) do
        local sameAspectSystems = self.switcher[component]

        if sameAspectSystems == nil then goto continue_remove end

        for _, system in ipairs(sameAspectSystems) do
            SystemManager:remove(system, entity.id)
        end

        ::continue_remove::
    end
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
        movement    =       MovementSystem  :new(self.SM, self.EnM, self.colliderWorld),
        health      =       HealthSystem    :new(self.SM, self.EnM),
        input       =       InputSystem     :new(self.SM, self.EnM),
        friction    =       FrictionSystem  :new(self.SM, self.EnM),
        collision   =       CollisionSystem :new(self.SM, self.EnM, self.colliderWorld),
        draw        =       DrawSystem      :new(self.SM, self.EnM)
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
