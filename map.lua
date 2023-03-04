require 'player'
require 'enemy'
require 'enemy2'

Map = Class{}

-- a map contains a player and enemies
function Map:init()
    player = Player()
    all_enemies = {
        Enemy(400, 500, 100),
        Enemy(100, 400, 200),
        Enemy(200, 550, 150),
        Enemy(700, 450, 250),
        Vert_enemy(300, 300, 300)
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
    for i, v in ipairs(all_enemies) do
        v:draw()
        --[[
            Note: dead enemies/bullets are still drawn before removal
            from table so that the collision is shown
        ]]
        if v.dead then
            table.remove(all_enemies, i)
        end
    end
end
