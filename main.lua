--[[
    @author: Thorion
    Main temporary file to test everything.
]]

local world = require("World")
local prefabs = require("Prefabs")
local mydebug = require("utils/mydebug")

function love.load()
    World = world:new()
    World:load()

    local player = prefabs:player()
    print(player.id)
    World:add(player)
end

function love.update(dt)
    World:update(dt)
end

function love.draw()
    World:draw()
end

-- World = world:new()
-- World:load()
--
-- local player = prefabs:player()
-- World:add(player)
-- World:update(dt)
-- World:draw()
-- World:remove(player)
