Wall = Class{}

function Wall:init(x_pos, y_pos)
    self.texture = love.graphics.newImage("graphics/wall.png")
    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()
    self.x = x_pos
    self.y = y_pos
end

function Wall:update(dt)
end

function Wall:draw()
    love.graphics.draw(self.texture, self.x, self.y)
end