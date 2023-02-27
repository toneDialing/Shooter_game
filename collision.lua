function bullet_collision(bullet, object)
    if bullet.x > object.x and bullet.x < (object.x + object.width) and
        bullet.y > object.y and bullet.y < (object.y + object.height) then
        return true
    end
end