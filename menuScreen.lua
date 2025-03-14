local P = {}
MenuScreen = P

function P.draw()
    love.graphics.setFont(GameFont)

    love.graphics.draw(MenuBackground, 0, 0, nil, Scale.x, Scale.y)

    love.graphics.print("Balloon Popper!", love.graphics.getWidth()/2 - 300, love.graphics.getHeight()/2 - 100)
    love.graphics.print("Start Game F3", love.graphics.getWidth()/2 - 300, love.graphics.getHeight()/2 - 100 + 80)
    love.graphics.print("Press F4 to close", love.graphics.getWidth()/2 - 300, love.graphics.getHeight()/2 - 100 + 120)
end

return MenuScreen