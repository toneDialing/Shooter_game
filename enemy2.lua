require 'player'
require 'enemy'
require 'collision'

Vert_enemy = Class{__includes = Enemy}

function Vert_enemy:init(x_pos, y_pos, speed)
    Enemy.init(self, x_pos, y_pos)
    self.dy = speed
end

function Vert_enemy:update(dt)
    Enemy.update(self, dt)
end

function Vert_enemy:draw()
    Enemy.draw(self, dt)
end