--[[ Horizontal bullets and vertical bullets are different images each with their own
    width and height, so this function works sensibly for either. 
]]
function bullet_collision(bullet, object)
    if (bullet.x + bullet.width) > object.x and bullet.x < (object.x + object.width) and
        (bullet.y + bullet.height) > object.y and bullet.y < (object.y + object.height) then
        return true
    end
end