require 'bullet'

Player = Class{}

local player_xpos = 100
local player_ypos = 10
local player_speed = 180
local player_max_ypos = 140 -- max distance player can move down on screen

local max_ammo = 6 -- max bullets allowed
local ammo_remaining = max_ammo -- keeps track of all bullets in play

function Player:init()
    self.texture = love.graphics.newImage("player.png") -- normal green rectangle
    self.x = player_xpos
    self.y = player_ypos
    self.width = self.texture:getWidth()
    self.height = self.texture:getHeight()
    self.speed = player_speed
    self.dx = 0
    self.dy = 0

    all_bullets = {}

    standard_font = love.graphics.newFont("Capture it.ttf", 30)
    love.graphics.setFont(standard_font)
end

function Player:update(dt)
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

    -- Press 'space' to shoot
    if love.keyboard.pressed['space'] then
        if ammo_remaining > 0 then
            bullet = Bullet(self.x + (self.width/2), self.y + self.height)
            table.insert(all_bullets, bullet)
            ammo_remaining = ammo_remaining - 1
        end
    end

    -- Press 'r' to reload
    if love.keyboard.pressed['r'] then
        ammo_remaining = 6
    end

    -- update player
    self.x = self.x + self.dx*dt
    self.y = self.y + self.dy*dt
    -- bounds checking for player
    if self.x<0 then self.x=0
    elseif self.x>(WINDOW_WIDTH-self.width) then self.x=(WINDOW_WIDTH-self.width) end
    if self.y<0 then self.y=0
    elseif self.y>(player_max_ypos-self.height) then self.y=(player_max_ypos-self.height) end

    -- update bullet(s)
    for _, v in ipairs(all_bullets) do
        v:update(dt)
    end
end

function Player:draw()
    love.graphics.draw(self.texture, self.x, self.y)

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
