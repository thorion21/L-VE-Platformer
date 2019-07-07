local Vector2 = {}

function Vector2:new(x, y)
    local vec = {
        x = x or 0,
        y = y or 0
    }

    self.__index = self
    return setmetatable(vec, self)
end

function Vector2:__add(other)
    return Vector2:new(self.x + other.x, self.y + other.y)
end

function Vector2:__sub(other)
    return Vector2:new(self.x - other.x, self.y - other.y)
end

function Vector2:__mul(other)
    return Vector2:new(self.x * other.x, self.y * other.y)
end

function Vector2:__div(other)
    return Vector2:new(self.x / other.x, self.y / other.y)
end

function Vector2:__eq(other)
    return self.x == other.x and self.y == other.y
end

function Vector2:__tostring()
    return string.format("<Vector2 %.2f, %.2f>", self.x, self.y)
end

function Vector2:copy()
    return Vector2:new(self.x, self.y)
end

function Vector2:magnitude()
    return math.sqrt((self.x ^ 2) + (self.y ^ 2))
end

function Vector2:normalize()
    local mag = self:magnitude()
    if mag > 0 then
        self.x = self.x / mag
        self.y = self.y / mag
    end
end

function Vector2:dot(other)
    return (self.x * other.x) + (self.y * other.y)
end

return Vector2
