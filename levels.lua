require 'map'

--[[
    For some reason it seems as though I need to have the [1], [2], etc. for each table entry,
    even though I thought Lua supplied integer indices as defaults if no specific key
    is provided.
]]

--[[
    Level design: provide introduction to enemies (and bullet trajectories?) slowly
    Initial level could be small wall with stationary enemy behind, much like Wii tanks
]]

--[[
    TO DO: Improve design of level implementation, perhaps with level map
    -- should all objects be the same size?
]]

-- Must update max_levels whenever altering this table
-- This seems like poor programming; perhaps add last_level variable to maps
all_maps = {
    [1] = function() return Map(
        Player(100, 277),
        {
            Enemy(500, 285)
        },
        {
            Wall(380, 240),
            Wall(380, 280),
            Wall(380, 320)
        })
    end,
    [2] = function() return Map(
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
    [3] = function() return Map(
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
    end,
    [4] = function() return Map(
        Player(370, 280),
        {
            Horizontal_enemy(40, 40, 400),
            Vertical_enemy(40, 40, 400),
            Horizontal_enemy(720, 40, -400),
            Vertical_enemy(720, 40, 400),
            Horizontal_enemy(40, 520, 400),
            Vertical_enemy(40, 520, -400),
            Horizontal_enemy(720, 520, -400),
            Vertical_enemy(720, 520, -400),
            Diagonal_enemy(100, 100, 450),
            Diagonal_enemy(130, 130, -450),
            Diagonal_enemy(700, 100, -450),
            Diagonal_enemy(670, 130, 450),
            Diagonal_enemy(350, 600, 500),
            Diagonal_enemy(375, 600, -500),
            Diagonal_enemy(400, 600, 500),
            Diagonal_enemy(425, 600, -500)
        },
        {
            Wall(280, 220),
            Wall(320, 220),
            Wall(440, 220),
            Wall(480, 220),
            Wall(280, 260),
            Wall(280, 300),
            Wall(280, 340),
            Wall(320, 340),
            Wall(360, 340),
            Wall(400, 340),
            Wall(440, 340),
            Wall(480, 340),
            Wall(480, 300),
            Wall(480, 260),
            Wall(0, 0),
            Wall(40, 0),
            Wall(0, 40),
            Wall(760, 0),
            Wall(720, 0),
            Wall(760, 40),
            Wall(0, 560),
            Wall(0, 520),
            Wall(40, 560),
            Wall(760, 560),
            Wall(720, 560),
            Wall(760, 520)
        })
    end
}