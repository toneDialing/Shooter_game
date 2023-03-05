require 'player'
require 'enemy'
require 'collision'

Diag_enemy = Class{__includes = Enemy}

function Diag_enemy:init(x_pos, y_pos, speed)
    Enemy.init(self, x_pos, y_pos)
    self.dx = speed
    self.dy = speed
end

function Diag_enemy:update(dt)
    Enemy.update(self, dt)
end

function Diag_enemy:draw()
    Enemy.draw(self, dt)
end