-- This currently isn't working for some reason. Need to review tables in Lua again.

local play = "play"
local death = "death"
local level_clear = "level clear"
local home_screen = "home screen"

game_states = {
    [play] = 1,
    [death] = 2,
    [level_clear] = 3,
    [home_screen] = 4
}