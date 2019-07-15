local class = require("libs/middleclass")
local World = require("World")

local Entity = class ('Entity')

function Entity:initialize(components)
    self.id = World:GetUniqueEntityId()
    self.components = components
end

return Entity
