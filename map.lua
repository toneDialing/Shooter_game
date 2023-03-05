require 'player'
require 'enemy'
require 'enemy_horizontal'
require 'enemy_vertical'
require 'enemy_diagonal'

Map = Class{}

-- a map contains a player and enemies
function Map:init()
    player = Player()
    all_enemies = {
        Enemy(300, 300),
        Enemy(250, 150),
        Horizontal_enemy(400, 500, 100),
        Horizontal_enemy(100, 400, 200),
        Horizontal_enemy(200, 550, -150),
        Horizontal_enemy(700, 450, 250),
        Vertical_enemy(300, 300, 300),
        Diagonal_enemy(150, 150, 200),
        Diagonal_enemy(750, 550, -200)
    }
end

function Map:update(dt)
    player:update(dt)
    for _, v in ipairs(all_enemies) do
        v:update(dt)
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
end
