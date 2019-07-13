local d = require("utils/mydebug")
local utils = require("utils/utils")
local m8 = require("utils/math")
local const = require("utils/constants")

local system = {}
local World = {}
local entities = {}
local colliderWorld = {}

function system.input(dt, id, c)
    local velocity = c.velocity
    local isPressed = love.keyboard.isDown

    local dist = utils.ToInt(isPressed('d')) - utils.ToInt(isPressed('a'))

    velocity.x = velocity.x + dist * velocity.acceleration
    velocity.x = m8.clamp(velocity.x, -velocity.max_speed, velocity.max_speed)

    local isJumping = isPressed('space')

    if isJumping then
        velocity.y = -const.PLAYER_JUMP_FORCE
    end

end

function system.friction(dt, id, c)
    local position = c.position
    local velocity = c.velocity

    local speed = m8.distance0(velocity.x, velocity.y)
    local sign = m8.sign(velocity.x)

    if speed > velocity.friction then
        velocity.x = sign * (math.abs(velocity.x) - velocity.friction)
    else
        velocity.x = 0
    end

    velocity.y = math.min(velocity.y + const.GRAVITY * dt, const.MAX_VELOCITY)
end

function system.collision(dt, id, c)
    local position = c.position
    local velocity = c.velocity
    local collider = c.collider
    
end

function system.movement(dt, id, c, entities)
    local position = c.position
    local velocity = c.velocity

    position.x = position.x + velocity.x * dt
    position.y = position.y + velocity.y * dt

    -- Will be deleted
    if position.y >= 1100 then
        position.y = 1100
        velocity.y = 0
    end
end

function system.health(dt, id, c)
    local health = c.health
    --print('HealthSystem active!', dt, health.health, health.max_health)
    --print('MoveSystem HEALTH!', dt, position.x, position.y)
end

function system.update(dt, process, components)
    for entity_id, entity_components in pairs(components) do
        process(dt, entity_id, entity_components)
    end
end

function system.load(WWorld, Wentities, Wcollider)
    World = WWorld
    entities = Wentities
    colliderWorld = Wcollider
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
