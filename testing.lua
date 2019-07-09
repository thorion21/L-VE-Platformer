local Entity = {}

function Entity:new()
    local e = {
        value = 22
    }
    self.__index = self
    return setmetatable(e, self)
end

function Entity:change()
    self.value = self.value + 1
end

local e = Entity:new()
e:change()
print(e.value)
