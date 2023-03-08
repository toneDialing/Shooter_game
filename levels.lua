require 'map'

--[[
    For some reason it seems as though I need to have the [1], [2], etc. for each table entry,
    even though I thought Lua supplied integer indices as defaults if no specific key
    is provided.
]]

all_maps = {
    [1] = function() return Map(
        Player(110, 10),
        {
            Enemy(300, 300),
            Enemy(250, 150),
            Horizontal_enemy(400, 500, 100),
            Horizontal_enemy(100, 400, 200),
            Horizontal_enemy(200, 550, -150),
            Horizontal_enemy(700, 450, 250),
            Vertical_enemy(300, 300, 300),
            Diagonal_enemy(150, 150, 200),
            Diagonal_enemy(740, 560, -200)
        },
        {
            Wall(60, 50),
            Wall(500, 520),
            Wall(380, 200)
        })
    end,
    [2] = function() return Map(
        Player(500, 550),
        {
            Diagonal_enemy(300, 100, 250),
            Diagonal_enemy(300, 50, 240),
            Diagonal_enemy(200, 20, 260),
            Diagonal_enemy(400, 400, -200),
            Vertical_enemy(50, 50, 300),
            Vertical_enemy(100, 550, -300),
            Horizontal_enemy(50, 550, 300),
            Horizontal_enemy(550, 500, -300)
        },
        {
            Wall(200, 550),
            Wall(250, 500),
            Wall(300, 450),
            Wall(350, 400),
            Wall(500, 250),
            Wall(550, 200),
            Wall(600, 150),
            Wall(650, 100),
            Wall(700, 50)
        })
    end
}