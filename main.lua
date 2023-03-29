-- Working game title: "Six Shots"
--[[
        These game states should probably be stored in a table or something.
    GAME STATES:
        "play"
        "death"
        "level_clear"
        "home_screen"
]]

--[[ TO DO:
    Basic:
        Add camera
        Add more enemies
        Add timer
    Later:
        Curve bullets
        Add locks/keys
        Add ammo pouches?
]]

-- Global game state variables
play_game = "play"
death = "death"
home_screen = "home_screen"
level_clear = "level_clear"

Class = require 'class'
require 'map'
require 'levels'

-- default window size in LÖVE
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

-- Global level variables
level_number = 1
max_levels = 4

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

    map = all_maps[level_number]()

    game_state = home_screen
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
    if game_state == play_game then
        map:update(dt)
    elseif game_state == death or game_state == home_screen then
        if love.keyboard.pressed['p'] or love.keyboard.pressed['return'] then
            map = all_maps[level_number]()
            game_state = play_game
        end
    elseif game_state == level_clear then
        if love.keyboard.pressed['p'] or love.keyboard.pressed['return'] then
            if level_number < max_levels then
                --[[
                    NOTE: level_number should only be incremented once per clear,
                    so it must either be incremented upon a key press or an additional
                    variable must keep track of whether it's been incremented already.
                    Otherwise it would continually increment per update(dt) while in the
                    "level_clear" game state.
                ]]
                level_number = level_number + 1
                map = all_maps[level_number]()
                game_state = play_game
            else -- all levels completed
                level_number = 1 -- restart the game
                game_state = home_screen
            end
        end
    end

    -- refreshes which keys have been pressed/released
    love.keyboard.pressed = {}
    love.keyboard.released = {}
end

function love.draw()
    if game_state == home_screen then
        love.graphics.printf("66 Shots\nPress 'p' to play", 0, 100, WINDOW_WIDTH, "center")
        -- PROBLEM: this image is being assigned twice (messy)
        local player_icon = love.graphics.newImage("graphics/player_down.png")
        love.graphics.draw(player_icon, 370, 300)
    else
        map:draw()
    end
    -- Update to refresh each level and only run during "play" game state
    -- PROBLEM: fix max number of digits displayed
    love.graphics.printf(love.timer.getTime(), 5, 5, WINDOW_WIDTH, "left")
end