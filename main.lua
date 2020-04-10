function love.load()
    Object = require "libs.classic"
    require "classes.level"

    level = Level("levelname")
    level:setRun(true)
end

function love.update(dt)
    level:update(dt)
end

function love.draw()
    level:draw()
end