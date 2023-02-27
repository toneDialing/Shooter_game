require 'player'
require 'enemy'

Map = Class{}

function Map:init()
    player = Player()
    all_enemies = {
        Enemy(400, 500),
        Enemy(200, 500),
        Enemy(300, 400),
        Enemy(700, 450),
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
