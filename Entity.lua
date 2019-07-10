local World = require("World")

local Entity = {}

function Entity:new()
    local ent = {
        id = World:GetUniqueEntityId(),
        components = {}
    }

    self.__index = self
    return setmetatable(ent, self)
end

return Entity
