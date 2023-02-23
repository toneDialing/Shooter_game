require 'bullet'

Player = Class{}

local player_xpos = 100
local player_ypos = 10
local player_speed = 180
local player_max_ypos = 140 -- max distance player can move down on screen

local bullet_counter -- keeps track of all bullets in play

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

    -- shoot bullets upon pressing space bar
    -- PROBLEM: bullets need to be removed from memory once they disappear from the screen
    if love.keyboard.was_key_pressed("space") then
        bullet = Bullet(self.x + (self.width/2), self.y + self.height, #all_bullets+1)
        all_bullets[bullet.bullet_number] = bullet
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
    for _, v in ipairs(all_bullets) do
        v:draw()
    end
end
