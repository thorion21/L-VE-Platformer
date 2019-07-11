local d = require "utils/mydebug"
local system = {}

function system.movement(dt, p)
    local position = p.position
    print('MoveSystem active!', dt, position.x, position.y)
end

function system.health(dt, p)
    local health = p.health
    local position = p.position
    print('HealthSystem active!', dt, health.health, health.max_health)
    print('MoveSystem HEALTH!', dt, position.x, position.y)
end

function system.update(dt, process, components)
    for entity_id, entity_components in pairs(components) do
        process(dt, entity_components)
    end
end

return system
