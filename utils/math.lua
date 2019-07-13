local m = {}

function m.sign(x)
  return (x > 0 and 1) or (x < 0 and -1) or 0
end

function m.distance0(x, y)
    return (x ^ 2 + y ^ 2) ^ 0.5
end

function m.distance(x1, y1, x2, y2)
    return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end

function m.clamp(value, low, high)
    return math.max(low, math.min(value, high))
end

function m.normalize(x, y)
    local length = (x * x + y * y) ^ 0.5

    if length > 0 then
        return x / length, y / length
    end

    return 0, 0
end

return m
