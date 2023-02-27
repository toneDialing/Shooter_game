require 'player'
require 'enemy'

Map = Class{}

-- a map contains a player and enemies
function Map:init()
    player = Player()
    all_enemies = {
        Enemy(400, 500, 100),
        Enemy(100, 400, 100),
        Enemy(0, 400, 150),
        Enemy(700, 450, 250)
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
    for _, v in ipairs(all_enemies) do
        v:draw()
    end
end
