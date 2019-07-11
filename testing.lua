
local d = require "utils/mydebug"

x = {
    a=2,
    b={
        c = 3,
        d = 4
    }
}

y = {}
pl = {a=2,b=3}
y[#y + 1] = pl
print(#y)
--d.fprint(x)
