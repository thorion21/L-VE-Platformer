local d = require("utils/mydebug")
local utils = require("utils/utils")
local m8 = require("utils/math")
local const = require("utils/constants")

local system = {}

function system.input(dt, id, c, entities)
    local velocity = c.velocity
    local isPressed = love.keyboard.isDown

    local dist = utils.ToInt(isPressed('d')) - utils.ToInt(isPressed('a'))

    velocity.x = velocity.x + dist * velocity.acceleration
    velocity.x = m8.clamp(velocity.x, -velocity.max_speed, velocity.max_speed)

    local isJumping = isPressed('space')

    if isJumping then
        velocity.y = -const.PLAYER_JUMP_FORCE
    end

    print(velocity.x)
end

function system.friction(dt, id, c, entities)
    local position = c.position
    local velocity = c.velocity

    local speed = m8.distance0(velocity.x, velocity.y)
    local sign = m8.sign(velocity.x)

    if speed > velocity.friction then
        velocity.x = sign * (math.abs(velocity.x) - velocity.friction)
    else
        velocity.x = 0
    end

    velocity.y = velocity.y + const.GRAVITY * dt
    print(velocity.y)
    if velocity.y >= const.MAX_VELOCITY then
        velocity.y = const.MAX_VELOCITY
    end

end

function system.movement(dt, id, c, entities)
    local position = c.position
    local velocity = c.velocity

    position.x = position.x + velocity.x * dt
    position.y = position.y + velocity.y * dt

end

function system.health(dt, id, c, entities)
    local health = c.health
    --print('HealthSystem active!', dt, health.health, health.max_health)
    --print('MoveSystem HEALTH!', dt, position.x, position.y)
end

function system.update(dt, process, components, entities)
    for entity_id, entity_components in pairs(components) do
        process(dt, entity_id, entity_components, entities)
    end
end

function system.draw(entity)
    love.graphics.rectangle(
        'fill',
         entity.components.position.x,
         entity.components.position.y,
         50, 50
     )
    --print('Drawing!')
end

return system
