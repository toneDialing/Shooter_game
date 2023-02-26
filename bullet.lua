Bullet = Class{}

bullet_speed = 300

local direction_left = "left"
local direction_right = "right"
local direction_up = "up"
local direction_down = "down"

function Bullet:init(player, direction)
    self.texture = love.graphics.newImage("bullet.png")
    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()
    self.direction = direction
    self.orientation = 0
    -- set x and y position according to turret's direction, bearing rotation in mind
    if self.direction == direction_left then
        self.x = player.x
        self.y = player.y + player.height/2 - self.width/2
        self.orientation = math.pi/2
    elseif self.direction == direction_right then
        self.x = player.x + player.width + self.height
        self.y = player.y + player.height/2 - self.width/2
        self.orientation = math.pi/2
    elseif self.direction == direction_up then
        self.x = player.x + player.width/2 - self.width/2
        self.y = player.y - self.height
    else -- assumes bullet must be down
        self.x = player.x + player.width/2 - self.width/2
        self.y = player.y + player.height
    end
    self.speed = bullet_speed
    self.out_of_play = false

    --[[
        self.move:
        Table containing anonymous functions that are called depending
        upon the bullet's direction.
    ]]
    self.move = {
        [direction_left] = function(dt)
            self.x = self.x - self.speed*dt
            if self.x<0 then -- bullet is offscreen
                self.out_of_play = true
            end
        end,
        [direction_right] = function(dt)
            self.x = self.x + self.speed*dt
            if self.x>(WINDOW_WIDTH+self.height) then -- bullet is offscreen
                self.out_of_play = true
            end
        end,
        [direction_up] = function(dt)
            self.y = self.y - self.speed*dt
            if self.y<(0-self.height) then -- bullet is offscreen
                self.out_of_play = true
            end
        end,
        [direction_down] = function(dt)
            self.y = self.y + self.speed*dt
            if self.y>WINDOW_HEIGHT then -- bullet is offscreen
                self.out_of_play = true
            end
        end
    }
end

function Bullet:update(dt)
    self.move[self.direction](dt)
end

function Bullet:draw()
    love.graphics.draw(self.texture, self.x, self.y, self.orientation)
end
