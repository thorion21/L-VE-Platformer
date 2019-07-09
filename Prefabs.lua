local Entity = require("Entity")
local component = require("Component")

local Prefabs = {}

function Prefabs:player()
    local entity = Entity:new()

    entity:add({
        player = true,
        position = component.position(),
        health = component.health()
    })

    entity:setTags({
        "player",
        "target"
    })

    return entity
end

return Prefabs
