GameScreen = require("gameScreen")
EndScreen = require("endScreen")
MenuScreen = require("menuScreen")

Balloons = {}
Scale = {}

_G.love = require("love")

-- TODO: Maybe add different points to each ballon depending on the difficulty

function love.load() 
    local anim8 = require("lib/anim8")
    love.graphics.setDefaultFilter("nearest", "nearest")

    Scale.x = love.graphics.getWidth()/1280
    Scale.y = love.graphics.getHeight()/720


    local balloon = {
        x = 100,
        y = 100,
        radius = 50,
        speed = 15,
        sprite_sheet = love.graphics.newImage("assets/sprites/balloon_purple.png"),
        animation = nil
    }

    balloon.grid = anim8.newGrid(16, 32, balloon.sprite_sheet:getWidth(), balloon.sprite_sheet:getHeight())
    balloon.animations = {
        normal = anim8.newAnimation(balloon.grid('1-3', 1), 0.2),
        popped = anim8.newAnimation(balloon.grid('1-3', 2), 0.2)
    }
    balloon.animation = balloon.animations.normal

    local balloon2 = {
        x = 300,
        y = 500,
        radius = 50,
        speed = 5,
        sprite_sheet = love.graphics.newImage("assets/sprites/balloon_red.png"),
        animation = nil
    }

    balloon2.grid = anim8.newGrid(16,32, balloon2.sprite_sheet:getWidth(), balloon2.sprite_sheet:getHeight())
    balloon2.animations = {
        normal = anim8.newAnimation(balloon2.grid('1-3', 1), 0.2),
        popped = anim8.newAnimation(balloon2.grid('1-3', 2), 0.2)
    }
    balloon2.animation = balloon2.animations.normal

    local balloon3 = {
        x = 600,
        y = 450,
        radius = 50,
        speed = 25,
        sprite_sheet = love.graphics.newImage("assets/sprites/balloon_yellow.png"),
        animation = nil
    }

    balloon3.grid = anim8.newGrid(16,32, balloon3.sprite_sheet:getWidth(), balloon3.sprite_sheet:getHeight())
    balloon3.animations = {
        normal = anim8.newAnimation(balloon3.grid('1-3', 1), 0.2),
        popped = anim8.newAnimation(balloon3.grid('1-3', 2), 0.2)
    }
    balloon3.animation = balloon3.animations.normal

    table.insert(Balloons, balloon)
    table.insert(Balloons, balloon2)
    table.insert(Balloons, balloon3)

    GameFont = love.graphics.newFont(40);
    
    Score = 0
    Menu = true
    Run = true

    MenuBackground = love.graphics.newImage("assets/imgs/menuBackground.png")
    GameBackground = love.graphics.newImage("assets/imgs/gameBackground.jpg")
    FinalBackground = love.graphics.newImage("assets/imgs/finalBackground.jpg")
    StartMusic = love.audio.newSource("assets/music/bgm.mp3", "stream")
    FinalMusic = love.audio.newSource("assets/music/finalMusic.wav", "stream")
    Pop_SFX = love.audio.newSource("assets/music/pop_sfx.mp3", "static")

    StartMusic:setVolume(0.2)
    FinalMusic:setVolume(0.2)

    StartMusic:setLooping(true)
    FinalMusic:setLooping(true)

    StartMusic:play()
end

function love.update(dt) 

    if love.timer.getTime() > 25 then
        Run = false
    end

    if not Run then
        StartMusic:stop()
        FinalMusic:play()
    end

    for _, balloon in pairs(Balloons) do
        balloon.x = balloon.x + math.random(-balloon.speed * dt * 10, balloon.speed * dt * 10)
        balloon.y = (balloon.y - balloon.speed * dt)

        if balloon.animation == balloon.animations.popped and balloon.animation.position == 3 then
            balloon.animation:gotoFrame(1)
            balloon.animation = balloon.animations.normal
        end

        balloon.animation:update(dt)
    end

end

function love.draw()
    if Menu then
        MenuScreen.draw()
    else if Run and not Menu then
        GameScreen.draw()
    else
        EndScreen.draw()
    end
end

end

-- TODO: Make animation reset with ballon respawn also make so that the balloon is not clickable after it has been popped also 

function love.mousepressed(x, y, button, istouch) 
    if button == 1 then 
        for _, balloon in pairs(Balloons) do
            local mouseToTarget = DistanceBetween(x, y, balloon.x, balloon.y)
            if mouseToTarget < balloon.radius then
                balloon.animation = balloon.animations.popped
                Pop_SFX:play()

                Score = Score + 1
                balloon.x = math.random(balloon.radius, love.graphics.getWidth() - balloon.radius)
                balloon.y = math.random(balloon.radius, love.graphics.getHeight() - balloon.radius)
                end
        end
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "f3" and Menu then
        Menu = false
    end

    if key == "f4" and (not Run or Menu) then
        love.event.quit()
    end
end

function DistanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end
