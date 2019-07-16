--[[
    @author: Thorion
    Main temporary file to test everything.
]]

local world = require("World")
local player = require("Prefabs/Player")
local ground = require("Prefabs/Ground")

function love.load()
    World = world:new()

    local player1 = player:new()
    local ground1 = ground:new()
    World:add(player1)
    World:add(ground1)
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
