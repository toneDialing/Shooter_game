Enemy = Class{}

local enemy_speed = 100
local initial_xpos = 400
local initial_ypos = 500

function Enemy:init()
    self.texture = love.graphics.newImage("enemy.png")
    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()
    self.x = initial_xpos
    self.y = initial_ypos
    self.dx = enemy_speed
end

function Enemy:update(dt)
    self.x = self.x + self.dx*dt
    if self.x<0 then
        self.x = 0
        self.dx = -self.dx
    elseif self.x>(WINDOW_WIDTH-self.width) then
        self.x = WINDOW_WIDTH-self.width
        self.dx = -self.dx
    end
end

function Enemy:draw()
    love.graphics.draw(self.texture, self.x, self.y)
end