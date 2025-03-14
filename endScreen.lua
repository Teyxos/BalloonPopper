local P = {}
EndScreen = P

function P.draw()

    love.graphics.draw(FinalBackground, 0, 0, nil, Scale.x, Scale.y)

    love.graphics.print("Game Over", love.graphics.getWidth()/2 - 300, love.graphics.getHeight()/2 - 100)
    love.graphics.print("Your final score is: " .. Score, love.graphics.getWidth()/2 - 300, love.graphics.getHeight()/2 - 100 + 40)
    love.graphics.print("Press F4 to close", love.graphics.getWidth()/2 - 300, love.graphics.getHeight()/2 - 100 + 80)
end

return EndScreen