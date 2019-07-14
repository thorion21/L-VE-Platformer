local EventManager = {}

function EventManager:new()
    local em = {
        observers = {}
    }
    self.__index = self
    return setmetatable(em, self)
end

function EventManager:load(world)
    self.observers = systems
end

function EventManager:signal(EVENT_TYPE, ...)

end
