require 'bullet'

Player = Class{}

local player_xpos = 100
local player_ypos = 10
local player_speed = 180

--[[ scrapped this
local player_max_ypos = 140 -- max distance player can move down on screen
]]

local direction_left = "left"
local direction_right = "right"
local direction_up = "up"
local direction_down = "down"
local player_initial_direction = direction_down

local max_ammo = 6 -- max bullets allowed
local ammo_remaining = max_ammo -- keeps track of all bullets in play

function Player:init()
    self.texture = {}
    self.texture[direction_left] = love.graphics.newImage("player_left.png")
    self.texture[direction_right] = love.graphics.newImage("player_right.png")
    self.texture[direction_up] = love.graphics.newImage("player_up.png")
    self.texture[direction_down] = love.graphics.newImage("player_down.png")
    self.x = player_xpos
    self.y = player_ypos
    self.width = self.texture[direction_left]:getWidth() -- all direction textures have same dimensions
    self.height = self.texture[direction_left]:getHeight()
    self.direction = player_initial_direction -- direction of turret
    self.speed = player_speed
    self.dx = 0
    self.dy = 0

    all_bullets = {}

    standard_font = love.graphics.newFont("Capture it.ttf", 30)
    love.graphics.setFont(standard_font)
end

function Player:update(dt)
    -- Press arrow keys to move
    if love.keyboard.isDown('left') then
        self.dx = -player_speed
    elseif love.keyboard.isDown('right') then
        self.dx = player_speed
    else self.dx = 0
    end
    if love.keyboard.isDown('up') then
        self.dy = -player_speed
    elseif love.keyboard.isDown('down') then
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
    self.x = self.x + self.dx*dt
    self.y = self.y + self.dy*dt
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
    for i, v in ipairs(all_bullets) do
        if v.out_of_play then -- bullet is offscreen
            table.remove(all_bullets, i) -- remove bullet object from table
            --[[ Supposedly Lua has automatic garbage management, but nonetheless I'm unsure
                how to properly remove each bullet from memory once it's offscreen. The best
                I've come up with thus far is to simply remove it from the all_bullets table,
                thereby no longer calling update() and draw() for that object. ]]
        else
            v:draw()
        end
    end

    love.graphics.print("Ammo: " .. ammo_remaining, 665, 5)
end
