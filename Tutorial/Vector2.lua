local Vector2 = {}

--[[
    Vector2 Module Implementation
]]

function Vector2:new(x, y)
    local vec = {
        x = x or 0,
        y = y or 0
    }
    self.__index = self
    return setmetatable(vec, self)
end

function Vector2:__add(o) return Vector2:new(self.x + o.x, self.y + o.y) end
function Vector2:__sub(o) return Vector2:new(self.x - o.x, self.y - o.y) end
function Vector2:__mul(o) return Vector2:new(self.x * o.x, self.y * o.y) end
function Vector2:__div(o) return Vector2:new(self.x / o.x, self.y / o.y) end
function Vector2:__eq(o) return self.x == o.x and self.y == o.y end
function Vector2:dot(o) return (self.x * o.x) + (self.y * o.y) end
function Vector2:magnitude() return math.sqrt((self.x ^ 2) + (self.y ^ 2)) end
function Vector2:copy() return Vector2:new(self.x, self.y) end
function Vector2:zero() return Vector2:new() end
function Vector2:__tostring() return string.format("<Vector2 %.2f, %.2f>", self.x, self.y) end

function Vector2:normalize()
    local mag = self:magnitude()
    if mag > 0 then
        self.x = self.x / mag
        self.y = self.y / mag
    end
end

return Vector2
