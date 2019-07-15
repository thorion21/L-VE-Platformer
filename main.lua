--[[
    @author: Thorion
    Main temporary file to test everything.
]]

local world = require("World")
local player = require("Prefabs/Player")

function love.load()
    World = world:new()

    local player = player:new()
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
