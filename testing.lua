
local d = require "utils/mydebug"

x = {
    a=2,
    b={
        c = 3,
        d = 4
    }
}

d.fprint(x)
