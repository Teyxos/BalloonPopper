local P = {}
EndScreen = P

function P.draw()

    love.graphics.draw(FinalBackground, 0, 0, nil, Scale.x, Scale.y)

    love.graphics.print("Game Over", 200, love.graphics.getWidth()/2)
    love.graphics.print("Your final score is: " .. Score, 200, 340)
    love.graphics.print("Press F4 to close", 200, 380)
end

return EndScreen