local m8 = require("utils/math")
local utils = require("utils/utils")
local Queue = require("utils/queue")
local System = require("Systems/System")
local const = require("utils/constants")
local class = require("libs/middleclass")

local InputSystem = class('InputSystem', System)

function InputSystem:initialize()
    self.name = 'input'
    self.components = {}
    self.messages = Queue:new()
    System.register(self, self)
end

function InputSystem:process(dt, id, components)
    local velocity = components.velocity
    local isPressed = love.keyboard.isDown

    local dist = utils.ToInt(isPressed('d')) - utils.ToInt(isPressed('a'))

    velocity.x = velocity.x + dist * velocity.acceleration
    velocity.x = m8.clamp(velocity.x, -velocity.max_speed, velocity.max_speed)

    local isJumping = isPressed('space')

    if isJumping then
        velocity.y = -const.PLAYER_JUMP_FORCE
    end
end

return InputSystem
