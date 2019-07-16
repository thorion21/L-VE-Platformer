local Entity = require("Entity")
local component = require("Component")
local const = require("utils/constants")
local class = require("libs/middleclass")

local Ground = class('Ground', Entity)

function Ground:initialize()
    local components = {
        position = component.position(500, 1100),
        collider = component.collider(2000, 50),
        isMap = true,
        render = true
    }
    Entity.initialize(self, components)
end

return Ground
