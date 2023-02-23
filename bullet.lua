Bullet = Class{}

local bullet_speed = 300

function Bullet:init(xpos, ypos, bullet_counter)
    self.texture = love.graphics.newImage("bullet.png")
    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()
    self.x = xpos
    self.y = ypos
    self.dy = bullet_speed
    self.bullet_number = bullet_counter
end

function Bullet:update(dt)
    self.y = self.y + self.dy*dt
end

function Bullet:draw()
    love.graphics.draw(self.texture, self.x, self.y)
end