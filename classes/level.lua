Level = Object.extend(Object)

local spriteHeightWidth = 30
local mapSpriteXYSize = 16
local waterSprite
local waterSpriteNum = 0

local function populateLevelTable(levelTable)
    for i = 1, mapSpriteXYSize do
        levelTable[i] = {}

        for j = 1, mapSpriteXYSize do
            levelTable[i][j] = waterSpriteNum
        end
    end
end

local function loadSprites()
    waterSprite = love.graphics.newImage("/sprites/water.png")
end

function Level:new(levelName)
    self.map = {}
    self.run = false

    populateLevelTable(self.map)
    loadSprites()
end

function Level:setRun(shouldRun)
    self.run = shouldRun
end

function Level:update(dt)
    -- animate map sprites

    if not(self.run) then
        return
    end
end

function Level:draw()
    if not(self.run) or #self.map == 0 then
        return
    end
    
    for i,row in ipairs(self.map) do
        for j,col in ipairs(row) do
            local spriteToDraw
            print(col)

            if col == waterSpriteNum then
                spriteToDraw = waterSprite
            end

            love.graphics.draw(spriteToDraw, j * spriteHeightWidth, i * spriteHeightWidth)
        end
    end
end