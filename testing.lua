
local d = require "utils/mydebug"
local m = require "utils/math"
local System = require("Systems/System")

local MovementSystem = require("Systems/MovementSystem")

System:initialize()

local ms = MovementSystem:new() -- World Load
ms:notify("salut :)")
ms:add('as871g', {'position', {x=2, y=3}})
ms:print()
ms:process(12969)
ms:remove('as871g')

--local System = require("Systems/System")
syss = System:GetSystems()
d.tprint(syss)
-- print(syss)
