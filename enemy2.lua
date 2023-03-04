Vert_enemy = Class{}

require 'player'
require 'enemy'
require 'collision'

Vert_enemy:include(Enemy)

function Vert_enemy:init(x_pos, y_pos, speed)
    self.texture = love.graphics.newImage("graphics/enemy.png")
    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()
    self.x = x_pos
    self.y = y_pos
    self.dy = speed
    self.dead = false
end

function Vert_enemy:update(dt)
    -- Enemies currently only move horizontally
    self.y = self.y + self.dy*dt
    if self.y<0 then
        self.y = 0
        self.dy = -self.dy
    elseif self.y>(WINDOW_HEIGHT-self.height) then
        self.y = WINDOW_HEIGHT-self.height
        self.dy = -self.dy
    end

    -- Check for bullet collisions
    -- Positions of bullet and enemy are updated before checking for collision
    for i, v in ipairs(all_bullets) do
        if bullet_collision(v, self) then
            --[[
                Bullet is marked out of play rather than immediately removed from
                all_bullets so that other enemies have the opportunity to detect
                collision with it. Thus one bullet will kill multiple enemies if
                they're in the same spot.
            ]]
            v.out_of_play = true
            self.dead = true
        end
    end
end

function Vert_enemy:draw()
    love.graphics.draw(self.texture, self.x, self.y)
end