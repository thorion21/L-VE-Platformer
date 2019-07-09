local utils = require("utils/utils")
local World = {}

function World:new()
    local world = {
        entitiesToAdd = {},
        entitiesToRemove = {},
        systemsToAdd = {},
        systemsToRemove = {},
        entities = {},
        systems = {},
    }
    self.__index = self
    return setmetatable(world, self)
end

function World:load()
    -- Loads all prerequisites
end

function World:update(dt)
    -- Updates all entities and systems
end

function World:draw()
    -- Draws all entities
end

function World:GetUniqueEntityId()
    return utils.uuid()
end

return World
