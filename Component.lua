local component = {}

function component.position(x, y)
    return {
        x = x or 0,
        y = y or 0
    }
end

function component.health(amount)
    return {
        health = amount or 0,
        max_health = amount or 0
    }
end

function component.render()
    return {
        r = true
    }
end

return component
