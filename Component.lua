local component = {}

function component.position(x, y)
    return {
        x = x or 0,
        y = y or 0
    }
end

function component.collider(width, height)
    return {
        width = width,
        height = height
    }
end

function component.velocity(x, y, acceleration, friction, max_speed)
    return {
        x = x,
        y = y,
        acceleration = acceleration,
        friction = friction,
        max_speed = max_speed
    }
end

function component.health(amount)
    return {
        health = amount or 0,
        max_health = amount or 0
    }
end

return component
