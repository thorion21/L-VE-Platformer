local system = {}

function system.movement(position)
    print('MoveSystem active!', position.x, position.y)
end

function system.health()
    print('HealthSystem active!', health.health, health.max_health)
end

return system
