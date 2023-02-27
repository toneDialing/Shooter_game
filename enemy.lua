Enemy = Class{}

require 'player'
require 'collision'

function Enemy:init(x_pos, y_pos, speed)
    self.texture = love.graphics.newImage("graphics/enemy.png")
    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()
    self.x = x_pos
    self.y = y_pos
    self.dx = speed
    self.alive = true
end

function Enemy:update(dt)
    if self.alive then
        for i, v in ipairs(all_bullets) do
            -- PROBLEM: bullet.x/bullet.y are oriented differently depending on
            -- the location of the bullet
            if bullet_collision(v, self) then
                --[[
                    Bullet is marked out of play rather than immediately removed from
                    all_bullets so that other enemies have the opportunity to detect
                    collision with it. Thus one bullet will kill multiple enemies if
                    they're in the same spot.
                ]]
                v.out_of_play = true
                self.alive = false
            end
        end
        -- Enemies currently only move horizontally
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