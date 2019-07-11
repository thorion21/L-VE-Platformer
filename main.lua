--[[
    @author: Thorion
    Main temporary file to test everything.
]]

local World = require("World")
local Prefabs = require("Prefabs")
local mydebug = require("utils/mydebug")

-- function love.load()
--     World:load()
-- end
--
-- function love.update(dt)
--     World:update(dt)
-- end
--
-- function love.draw()
--     World:draw()
-- end

local player = Prefabs:player()
--mydebug.print_entity(player)
World:load()
-- World:update()
World:add(player)
World:update(69)
World:remove(player)
