--[[
    @author: Thorion
    Main temporary file to test everything.
]]

local World = require("World")
local Prefabs = require("Prefabs")
local mydebug = require("utils/mydebug")

-- function love.load(arg)
--     world = World:new()
-- end
--
-- function love.update(dt)
--     world:update(dt)
-- end
--
-- function love.draw()
--     world:draw()
-- end

local player = Prefabs:player()
mydebug.print_entity(player)
