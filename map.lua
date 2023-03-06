require 'player'
require 'wall'
require 'enemy'
require 'enemy_horizontal'
require 'enemy_vertical'
require 'enemy_diagonal'

Map = Class{}

-- a map contains a player and enemies
function Map:init()
    player = Player(110, 10)
    all_enemies = {
        Enemy(300, 300),
        Enemy(250, 150),
        Horizontal_enemy(400, 500, 100),
        Horizontal_enemy(100, 400, 200),
        Horizontal_enemy(200, 550, -150),
        Horizontal_enemy(700, 450, 250),
        Vertical_enemy(300, 300, 300),
        Diagonal_enemy(150, 150, 200),
        Diagonal_enemy(740, 560, -200)
    }
    all_walls = {
        Wall(60, 50),
        Wall(500, 520),
        Wall(380, 200)
    }
end

function Map:update(dt)
    if game_state == "play" then
        player:update(dt)
        -- Collision checking (enemies and player)
        --[[
            This collision checking isn't done in player:update(dt) because I want both player
            and enemies to update before checking for collision.
        ]]
        for _, v in ipairs(all_enemies) do
            v:update(dt)
            if collision(player, v) then
                game_state = "death"
            end
        end
    end
end

function Map:draw()
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
    for _, v in ipairs(all_walls) do
        v:draw()
    end

    -- Win once all enemies are eliminated
    if #all_enemies == 0 then
        game_state = "level_clear"
    end

    -- Loss message
    if game_state == "death" then
        love.graphics.printf("You died.\nPress 'p' to play again.", 0, 100, WINDOW_WIDTH, "center")
    end

    -- Win message
    if game_state == "level_clear" then
        love.graphics.printf("You win! Well done.", 0, 100, WINDOW_WIDTH, "center")
    end
end
