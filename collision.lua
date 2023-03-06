--[[ Horizontal bullets and vertical bullets are different images each with their own
    width and height, so this function works sensibly for either. 
]]
function bullet_collision(bullet, object)
    return (bullet.x + bullet.width) > object.x and bullet.x < (object.x + object.width) and
        (bullet.y + bullet.height) > object.y and bullet.y < (object.y + object.height)
end

function wall_collision(player, object)
    return (player.x + player.width) > object.x and player.x < (object.x + object.width) and
        (player.y + player.height) > object.y and player.y < (object.y + object.height)
end

--[[
    PROBLEM: These horizontal and vertical functions are too similar. It would be preferable
    to combine them into a single function that takes direction as a parameter.
]]

function was_horizontally_aligned(player, object)
    return (player.previous_y + player.height) > object.y and
        player.previous_y < (object.y + object.height)
end

function was_vertically_aligned(player, object)
    return (player.previous_x + player.width) > object.x and
        player.previous_x < (object.x + object.width)
end

function adjust_horizontal_position(player, object)
    if player.width < object.width then
        if player.x < (object.x + ((player.width+object.width)/2 - player.width)) then
            return (object.x - player.width)
        else
            return (object.x + object.width)
        end
    else -- works whether player.width > object.width or is equal to
        if player.x < ((object.x - (player.width+object.width)/2) + object.width) then
            return (object.x - player.width)
        else
            return (object.x + object.width)
        end
    end
end

function adjust_vertical_position(player, object)
    if player.height < object.height then
        if player.y < (object.y + ((player.height+object.height)/2 - player.height)) then
            return (object.y - player.height)
        else
            return (object.y + object.height)
        end
    else -- works whether player.height > object.height or is equal to
        if player.y < ((object.y - (player.height+object.height)/2) + object.height) then
            return (object.y - player.height)
        else
            return (object.y + object.height)
        end
    end
end

--[[ More generalized version:
function collision(subject, object)
    return (subject.x + subject.width) > object.x and subject.x < (object.x + object.width) and
        (subject.y + subject.height) > object.y and subject.y < (object.y + object.height)
end
]]