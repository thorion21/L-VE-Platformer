local Queue = {}

function Queue:new ()
    local queue = {
        first = 0,
        last = -1
    }
    self.__index = self
    return setmetatable(queue, self)
end

function Queue:enqueue (value)
    local first = self.first - 1
    self.first = first
    self[first] = value
    return value
end

function Queue:dequeue ()
    local last = self.last
    local value = self[last]
    self[last] = nil
    self.last = last - 1
    return value
end

function Queue:isEmpty()
    return self.first > self.last
end

return Queue
