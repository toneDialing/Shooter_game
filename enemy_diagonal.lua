require 'player'
require 'enemy'
require 'collision'

Diagonal_enemy = Class{__includes = Enemy}

function Diagonal_enemy:init(x_pos, y_pos, speed)
    Enemy.init(self, x_pos, y_pos)
    self.texture = love.graphics.newImage("graphics/enemy_orange.png")
    -- Note width and height are still accurate as all enemies are same size for now
    self.dx = speed
    self.dy = speed
end

function Diagonal_enemy:update(dt)
    Enemy.update(self, dt)
end

function Diagonal_enemy:draw()
    Enemy.draw(self, dt)
end