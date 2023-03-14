require 'player'
require 'wall'
require 'enemy'
require 'enemy_horizontal'
require 'enemy_vertical'
require 'enemy_diagonal'

Map = Class{}

-- These local variables are duplicates of local variables in main.lua
-- Should they all be global instead?
local play_game = "play"
local death = "death"
local home_screen = "home_screen"
local level_clear = "level_clear"

-- a map contains a player and enemies
function Map:init(player_init, enemy_init, wall_init)
    player = player_init
    all_enemies = enemy_init
    all_walls = wall_init
end

function Map:update(dt)
    if game_state == play_game then
        player:update(dt)
        -- Collision checking (enemies and player)
        --[[
            This collision checking isn't done in player:update(dt) because I want both player
            and enemies to update before checking for collision.
        ]]
        for _, v in ipairs(all_enemies) do
            v:update(dt)
            if collision(player, v) then
                game_state = death
            end
        end
    end
end

function Map:draw()
    for _, v in ipairs(all_walls) do
        v:draw()
    end
    -- PROBLEM: Enemies get drawn over the player, and thus over ammo display
    -- Make ammo part of HUD or draw enemies first
    player:draw()
    -- Loop backwards through table to avoid skips if elements are removed
    for i=#all_enemies, 1, -1 do
        all_enemies[i]:draw()
        --[[
            Note: dead enemies/bullets are still drawn before removal
            from table so that the collision is shown
        ]]
        if all_enemies[i].dead then
            table.remove(all_enemies, i)
        end
    end

    -- Win once all enemies are eliminated
    if #all_enemies == 0 then
        game_state = level_clear
    end

    -- Loss message
    if game_state == death then
        love.graphics.printf("You died.\nPress 'p' to play again.", 0, 100, WINDOW_WIDTH, "center")
    end

    -- Win message
    if game_state == level_clear then
        love.graphics.printf("You win! Well done.", 0, 100, WINDOW_WIDTH, "center")
    end
end
