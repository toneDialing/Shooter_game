require 'player'
require 'enemy'
require 'collision'

Horizontal_enemy = Class{__includes = Enemy}

function Horizontal_enemy:init(x_pos, y_pos, speed)
    Enemy.init(self, x_pos, y_pos)
    self.texture = love.graphics.newImage("graphics/enemy_purple.png")
    -- Note width and height are still accurate as all enemies are same size for now
    self.dx = speed
end

function Horizontal_enemy:update(dt)
    Enemy.update(self, dt)
end

function Horizontal_enemy:draw()
    Enemy.draw(self, dt)
end