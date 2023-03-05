-- Working game title: "Six Shots"

Class = require 'class'
require 'map'

-- default window size in LÖVE
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

--[[ TO DO:
    Basic:
        Add walls
        Add camera
        Add different enemies
    Later:
        Curve bullets
        Add locks/keys
        Add ammo pouches?
    Fixes:
        Iterate from end of lists for removing items
]]

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    love.window.setTitle("Six Shots")
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- tables to keep track of which keys have been pressed once or released
    -- refreshes after each update (see end of love.update() below)
    love.keyboard.pressed = {}
    love.keyboard.released = {}

    map = Map()
end

function love.keypressed(key)
    if key=='escape' then -- quit upon escape
        love.event.quit()
    end

    love.keyboard.pressed[key] = true
end

function love.keyreleased(key)
    love.keyboard.released[key] = true
end

function love.update(dt)
    map:update(dt)

    -- refreshes which keys have been pressed/released
    love.keyboard.pressed = {}
    love.keyboard.released = {}
end

function love.draw()
    map:draw()
end