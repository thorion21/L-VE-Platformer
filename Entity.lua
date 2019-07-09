local World = require("World")

local Entity = {}

function Entity:new()
    local ent = {
        id = World:GetUniqueEntityId(),
        components = {},
        tags = {},
        loaded = false,
        remove = false
    }

    self.__index = self
    return setmetatable(ent, self)
end

function Entity:add(args)
    assert(type(args) == 'table', "components not a table!")
    for c_type, c_value in pairs(args) do
        self.components[c_type] = c_value
    end
end

function Entity:remove(args)
    assert(type(args) == 'table', "components not a table!")
    for _, c_type in ipairs(args) do
        self.components[c_type] = nil
    end
end

function Entity:setTags(args)
    assert(type(args) == 'table', "tags not a table!")
    for _, tag in ipairs(args) do
        self.tags[#self.tags + 1] = tag
    end
end

return Entity
