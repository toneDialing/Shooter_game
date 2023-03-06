require 'player'
require 'enemy'
require 'collision'

Vertical_enemy = Class{__includes = Enemy}

function Vertical_enemy:init(x_pos, y_pos, speed)
    Enemy.init(self, x_pos, y_pos)
    self.texture = love.graphics.newImage("graphics/enemy_purple.png")
    -- Note width and height are still accurate as all enemies are same size for now
    self.dy = speed
end

function Vertical_enemy:update(dt)
    Enemy.update(self, dt)
end

function Vertical_enemy:draw()
    Enemy.draw(self, dt)
end