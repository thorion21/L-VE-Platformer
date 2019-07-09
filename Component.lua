local component = {}

function component.position(x, y)
    return {
        x = x or 0,
        y = y or 0
    }
end

function component.health(amount)
    return {
        health = amount,
        max_health = amount
    }
end

return component
