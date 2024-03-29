--[[ Horizontal bullets and vertical bullets are different images each with their own
    width and height, so this function works sensibly for either. 
]]
function collision(subject, object)
    return (subject.x + subject.width) > object.x and subject.x < (object.x + object.width) and
        (subject.y + subject.height) > object.y and subject.y < (object.y + object.height)
end

--[[
    PROBLEM: These horizontal and vertical functions are too similar. It would be preferable
    to combine them into a single function that takes direction as a parameter.
]]

--[[
    PROBLEM: Corner collisions need to be fixed to avoid diagonal rebounds along
    straight walls. Multiple walls in a row still currently have "corners" embedded
    within them.
    (Also noted in enemy.lua)
]]

function was_horizontally_aligned(subject, object)
    return (subject.previous_y + subject.height) > object.y and
        subject.previous_y < (object.y + object.height)
end

function was_vertically_aligned(subject, object)
    return (subject.previous_x + subject.width) > object.x and
        subject.previous_x < (object.x + object.width)
end

-- Places subject to the immediate right/left of object, depending on relative position
function adjust_horizontal_position(subject, object)
    if subject.width < object.width then
        if subject.x < (object.x + ((subject.width+object.width)/2 - subject.width)) then
            return (object.x - subject.width)
        else
            return (object.x + object.width)
        end
    else -- works whether subject.width > object.width or is equal to
        if subject.x < ((object.x - (subject.width+object.width)/2) + object.width) then
            return (object.x - subject.width)
        else
            return (object.x + object.width)
        end
    end
end

-- Places subject immediately above/below object, depending on relative position
function adjust_vertical_position(subject, object)
    if subject.height < object.height then
        if subject.y < (object.y + ((subject.height+object.height)/2 - subject.height)) then
            return (object.y - subject.height)
        else
            return (object.y + object.height)
        end
    else -- works whether subject.height > object.height or is equal to
        if subject.y < ((object.y - (subject.height+object.height)/2) + object.height) then
            return (object.y - subject.height)
        else
            return (object.y + object.height)
        end
    end
end