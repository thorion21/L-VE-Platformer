
local d = require "utils/mydebug"
local m = require "utils/math"

function f1(id, ...)
    print('func1', id, ...)
    f2(...)
end

function f2(...)
    print('func2', ...)
end

f1(1234, 5678, 9012)
