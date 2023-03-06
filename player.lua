require 'bullet'

Player = Class{}

local player_xpos = 100
local player_ypos = 10
local player_speed = 250

local direction_left = "left"
local direction_right = "right"
local direction_up = "up"
local direction_down = "down"
local player_initial_direction = direction_down

local max_ammo = 66 -- max bullets allowed
local ammo_remaining = max_ammo -- keeps track of all bullets in play

-- variables to keep track of how long (in dt) each arrow key has been pressed for
local left_pressed_time = 0
local right_pressed_time = 0
local up_pressed_time = 0
local down_pressed_time = 0

-- a player consists of a movable texture and bullets fired from that texture
function Player:init()
    self.texture = {}
    self.texture[direction_left] = love.graphics.newImage("graphics/player_left.png")
    self.texture[direction_right] = love.graphics.newImage("graphics/player_right.png")
    self.texture[direction_up] = love.graphics.newImage("graphics/player_up.png")
    self.texture[direction_down] = love.graphics.newImage("graphics/player_down.png")
    self.x = player_xpos
    self.y = player_ypos
    self.previous_x = self.x
    self.previous_y = self.y
    self.width = self.texture[direction_left]:getWidth() -- all direction textures have same dimensions
    self.height = self.texture[direction_left]:getHeight()
    self.direction = player_initial_direction -- direction of turret
    self.speed = player_speed
    self.dx = 0
    self.dy = 0

    all_bullets = {}

    standard_font = love.graphics.newFont("fonts/Capture_it.ttf", 30)
    love.graphics.setFont(standard_font)
end

function Player:update(dt)
    -- Reset arrow key timer if an arrow key is released
    if love.keyboard.released['left'] then
        left_pressed_time = 0
    end
    if love.keyboard.released['right'] then
        right_pressed_time = 0
    end
    if love.keyboard.released['up'] then
        up_pressed_time = 0
    end
    if love.keyboard.released['down'] then
        down_pressed_time = 0
    end

    -- Press arrow keys to move
    --[[ PROBLEM: I've made it so that the most recently pressed key can override
        the opposite pressed key (using timers to keep track of how long each key
        has been pressed for), but now diagonal movement no longer works if
        opposite keys are being pressed simultaneously. ]]
    if love.keyboard.isDown('left') then
        left_pressed_time = left_pressed_time + dt
        if love.keyboard.isDown('right') then
            right_pressed_time = right_pressed_time + dt
            if right_pressed_time<left_pressed_time then
                self.dx = player_speed
            else
                self.dx = -player_speed
            end
        else
            self.dx = -player_speed
        end
    elseif love.keyboard.isDown('right') then
        right_pressed_time = right_pressed_time + dt
        self.dx = player_speed
    else
        self.dx = 0
    end
    if love.keyboard.isDown('up') then
        up_pressed_time = up_pressed_time + dt
        if love.keyboard.isDown('down') then
            down_pressed_time = down_pressed_time + dt
            if down_pressed_time<up_pressed_time then
                self.dy = player_speed
            else
                self.dy = -player_speed
            end
        else
            self.dy = -player_speed
        end
    elseif love.keyboard.isDown('down') then
        down_pressed_time = down_pressed_time + dt
        self.dy = player_speed
    else
        self.dy = 0
    end

    -- Press 'wasd' to change turret direction
    -- PROBLEM: elseif may not be best construction
    if love.keyboard.pressed['w'] then
        self.direction = direction_up
    elseif love.keyboard.pressed['a'] then
        self.direction = direction_left
    elseif love.keyboard.pressed['s'] then
        self.direction = direction_down
    elseif love.keyboard.pressed['d'] then
        self.direction = direction_right
    end

    -- Press 'space' to shoot
    if love.keyboard.pressed['space'] then
        if ammo_remaining > 0 then
            bullet = Bullet(self, self.direction)
            table.insert(all_bullets, bullet)
            ammo_remaining = ammo_remaining - 1
        end
    end

    -- Press 'r' to reload
    if love.keyboard.pressed['r'] then
        ammo_remaining = max_ammo
    end

    -- update player
    self.previous_x = self.x
    self.previous_y = self.y
    self.x = self.x + self.dx*dt
    self.y = self.y + self.dy*dt
    -- collision checking for player
    for _, v in ipairs(all_walls) do
        if collision(self, v) then
            if was_horizontally_aligned(self, v) then
                self.x = adjust_horizontal_position(self, v)
            elseif was_vertically_aligned(self, v) then
                self.y = adjust_vertical_position(self, v)
            else
                self.x = adjust_horizontal_position(self, v)
                self.y = adjust_vertical_position(self, v)
            end
        end
    end
    -- bounds checking for player
    if self.x<0 then self.x=0
    elseif self.x>(WINDOW_WIDTH-self.width) then self.x=(WINDOW_WIDTH-self.width) end
    if self.y<0 then self.y=0
    elseif self.y>(WINDOW_HEIGHT-self.height) then self.y=(WINDOW_HEIGHT-self.height) end

    -- update bullet(s)
    for _, v in ipairs(all_bullets) do
        v:update(dt)
    end
end

function Player:draw()
    love.graphics.draw(self.texture[self.direction], self.x, self.y)

    -- draw bullet(s)
    -- Loop backwards through table to avoid skips if elements are removed
    for i=#all_bullets, 1, -1 do
        all_bullets[i]:draw()
        if all_bullets[i].out_of_play then -- bullet is offscreen
            table.remove(all_bullets, i) -- remove bullet object from table
            --[[ Supposedly Lua has automatic garbage management, but nonetheless I'm unsure
                how to properly remove each bullet from memory once it's offscreen. The best
                I've come up with thus far is to simply remove it from the all_bullets table,
                thereby no longer calling update() and draw() for that object. ]]
        end
    end

    love.graphics.print("Ammo: " .. ammo_remaining, 655, 5)
end
