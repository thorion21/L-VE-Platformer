local class = require("libs/middleclass")

local EntityManager = class('EntityManager')

function EntityManager:initialize(entities)
    self.entities = entities
end

function EntityManager:get(id)
    return self.entities[id]
end

return EntityManager
