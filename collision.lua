--[[ Horizontal bullets and vertical bullets are different images each with their own
    width and height, so this function works sensibly for either. 
]]
function bullet_collision(bullet, object)
    if (bullet.x + bullet.width) > object.x and bullet.x < (object.x + object.width) and
        (bullet.y + bullet.height) > object.y and bullet.y < (object.y + object.height) then
        return true
    end
end

--[[ More generalized version:
function collision(subject, object)
    if (subject.x + subject.width) > object.x and subject.x < (object.x + object.width) and
        (subject.y + subject.height) > object.y and subject.y < (object.y + object.height) then
            return true
    end
end
]]