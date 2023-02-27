Enemy = Class{}

require 'player'
require 'collision'

local enemy_speed = 100

function Enemy:init(x_pos, y_pos)
    self.texture = love.graphics.newImage("graphics/enemy.png")
    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()
    self.x = x_pos
    self.y = y_pos
    self.dx = enemy_speed
    self.alive = true
end

function Enemy:update(dt)
    if self.alive then
        for i, v in ipairs(all_bullets) do
            if bullet_collision(v, self) then
                table.remove(all_bullets, i)
                self.alive = false
            end
        end
        self.x = self.x + self.dx*dt
        if self.x<0 then
            self.x = 0
            self.dx = -self.dx
        elseif self.x>(WINDOW_WIDTH-self.width) then
            self.x = WINDOW_WIDTH-self.width
            self.dx = -self.dx
        end
    end
end

function Enemy:draw()
    if self.alive then
        love.graphics.draw(self.texture, self.x, self.y)
    end
end