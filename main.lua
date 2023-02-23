Class = require 'class'
require 'player'

-- default window size in LÖVE
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- table to keep track of which keys have been pressed once
    -- refreshes after each update (see end of love.update() below)
    love.keyboard.pressed = {}

    player = Player()
end

function love.keypressed(key)
    if key=='escape' then -- quit upon escape
        love.event.quit()
    end

    love.keyboard.pressed[key] = true
end

function love.update(dt)
    player:update(dt)

    -- refreshes which keys have been pressed
    love.keyboard.pressed = {}
end

function love.draw()
    player:draw()
end