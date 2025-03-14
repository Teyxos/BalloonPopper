local P = {}
GameScreen = P

function P.draw()
    love.graphics.draw(GameBackground, 0, 0, nil, Scale.x, Scale.y)

    for _, balloon in pairs(Balloons) do
        balloon.animation:draw(balloon.sprite_sheet, balloon.x, balloon.y, nil, 2)
    end

    love.graphics.setColor(1,1,1)
    
    love.graphics.print(Score, 0, 0)
    local text = string.format("Time: %2.2f", 25 - love.timer.getTime())
    love.graphics.print(text, 0, 40)
end

return GameScreen