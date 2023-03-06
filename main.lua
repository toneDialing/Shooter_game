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

    standard_font = love.graphics.newFont("fonts/Capture_it.ttf", 30)
    love.graphics.setFont(standard_font)

    -- tables to keep track of which keys have been pressed once or released
    -- refreshes after each update (see end of love.update() below)
    love.keyboard.pressed = {}
    love.keyboard.released = {}

    map = Map()

    game_state = "home_screen"
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
    if game_state == "play" then
        map:update(dt)
    elseif game_state == "death" or game_state == "home_screen" then
        if love.keyboard.pressed['p'] or love.keyboard.pressed['return'] then
            map = Map()
            game_state = "play"
        end
    elseif game_state == "level_clear" then
        if love.keyboard.pressed['p'] or love.keyboard.pressed['return'] then
            game_state = "home_screen"
        end
    end

    -- refreshes which keys have been pressed/released
    love.keyboard.pressed = {}
    love.keyboard.released = {}
end

function love.draw()
    if game_state == "home_screen" then
        love.graphics.printf("66 Shots\nPress 'p' to play", 0, 100, WINDOW_WIDTH, "center")
    else
        map:draw()
    end
end