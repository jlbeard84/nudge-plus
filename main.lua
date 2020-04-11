function love.load()
    Object = require "libs.classic"
    require "classes.level"
    require "levels.level_1"

    level = Level1()
    level:loadMap()
    level:setRun(true)
end

function love.update(dt)
    level:update(dt)
end

function love.draw()
    level:draw()
end