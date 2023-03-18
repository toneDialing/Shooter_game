require 'player'
require 'collision'

Enemy = Class{}

-- Thus far all enemies are assumed to have the same dimensions
function Enemy:init(x_pos, y_pos)
    self.texture = love.graphics.newImage("graphics/enemy_red.png")
    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()
    self.x = x_pos
    self.y = y_pos
    self.previous_x = self.x
    self.previous_y = self.y
    self.dx = 0
    self.dy = 0
    self.dead = false
end

function Enemy:update(dt)
    self.previous_x = self.x
    self.previous_y = self.y
    self.x = self.x + self.dx*dt
    self.y = self.y + self.dy*dt

    -- OPTION: Could randomly choose to change dx or dy upon corner collision
    --[[
        PROBLEM: When multiple walls are combined, the code doesn't work as expected.
        e.g., enemies bounce off corners when it's supposed to be a smooth wall, because
        they're hitting the corner of a single wall object.
    ]]
    -- Collision checking
    for _, v in ipairs(all_walls) do
        if collision(self, v) then
            if was_horizontally_aligned(self, v) then
                self.x = adjust_horizontal_position(self, v)
                self.dx = -self.dx
            elseif was_vertically_aligned(self, v) then
                self.y = adjust_vertical_position(self, v)
                self.dy = -self.dy
            else -- precise corner collision
                self.x = adjust_horizontal_position(self, v)
                self.y = adjust_vertical_position(self, v)
                self.dx = -self.dx
                self.dy = -self.dy
            end
        end
    end

    -- Bounds checking
    if self.x<0 then
        self.x = 0
        self.dx = -self.dx
    elseif self.x>(WINDOW_WIDTH-self.width) then
        self.x = WINDOW_WIDTH-self.width
        self.dx = -self.dx
    end
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
        if collision(v, self) then
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

function Enemy:draw()
    love.graphics.draw(self.texture, self.x, self.y)
end