Bullet = Class{}

local bullet_speed = 300

function Bullet:init(xpos, ypos)
    self.texture = love.graphics.newImage("bullet.png")
    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()
    self.x = xpos
    self.y = ypos
    self.dy = bullet_speed
    self.out_of_play = false
end

function Bullet:update(dt)
    self.y = self.y + self.dy*dt
    if self.y>WINDOW_HEIGHT then -- bullet is offscreen
        self.out_of_play = true
    end
end

function Bullet:draw()
    love.graphics.draw(self.texture, self.x, self.y)
end