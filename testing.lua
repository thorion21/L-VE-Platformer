
local d = require "utils/mydebug"

x = {
    user1 = {{x=2,y=3}},
    user2 = {{x=110, y=111}}
}

if x.user1 ~= nil then
    x.user1[#x.user1 + 1] = {a=99, b=98}
else
    x.user1 = {{a=22, b=23}}
end

print('-----------')
d.tprint(x.user1[1])
d.tprint(x.user1[2])
