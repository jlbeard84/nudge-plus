Level = Object.extend(Object)

local keyPressed = false

local spriteHeightWidth = 32
local mapSpriteXYSize = 16
local playerSpeed = 20

local playerSprite

local waterSprite
local waterSpriteNum = 0

local grassSprite1
local grassSprite1Num = 1

local grassSprite2
local grassSprite2Num = 2

local sandSprite1
local sandSprite1Num = 20

local sandSprite2
local sandSprite2Num = 21

local sandTopShore
local sandTopShoreNum = 22

local sandRightShore
local sandRightShoreNum = 23

local sandBottomShore
local sandBottomShoreNum = 24

local sandLeftShore
local sandLeftShoreNum = 25

local sandBottomLeftShore
local sandBottomLeftShoreNum = 26

local sandBottomRightShore
local sandBottomRightShoreNum = 27

local function loadSprites()
    playerSprite = love.graphics.newImage("/sprites/player.png")

    waterSprite = love.graphics.newImage("/sprites/water.png")

    grassSprite1 = love.graphics.newImage("/sprites/grass_base_1.png")
    grassSprite2 = love.graphics.newImage("/sprites/grass_base_2.png")

    sandSprite1 = love.graphics.newImage("/sprites/sand_base_1.png")
    sandSprite2 = love.graphics.newImage("/sprites/sand_base_2.png")
    sandTopShore = love.graphics.newImage("/sprites/sand_topshore.png")
    sandRightShore = love.graphics.newImage("/sprites/sand_rightshore.png")
    sandBottomShore = love.graphics.newImage("/sprites/sand_bottomshore.png")
    sandLeftShore = love.graphics.newImage("/sprites/sand_leftshore.png")
    sandBottomRightShore = love.graphics.newImage("/sprites/sand_bottomrightshore.png")
    sandBottomLeftShore = love.graphics.newImage("/sprites/sand_bottomleftshore.png")
end

local function playerPositionValid(self, posX, posY)
    if posX < 1 or posX > mapSpriteXYSize or posY < 1 or posY > mapSpriteXYSize or self.map[posY][posX] == 0 then
        return false
    end

    return true
end

function Level:new(levelMap)
    self.map = {}
    self.run = false
    self.playerPosition = { 0, 0 }
    self.playerXY = { 0, 0 }

    loadSprites()
end

function Level:loadMap(map, playerStartPosition)
    self.map = map
    self.playerPosition = playerStartPosition
    self.playerXY = { self.playerPosition[1] * spriteHeightWidth, self.playerPosition[2] * spriteHeightWidth}
end

function Level:setRun(shouldRun)
    self.run = shouldRun
end

function Level:update(dt)

    if not(self.run) then
        return
    end

    self.playerXY[1] = self.playerXY[1] - ((self.playerXY[1]  - (self.playerPosition[1]*spriteHeightWidth)) * playerSpeed * dt)
    self.playerXY[2] = self.playerXY[2] - ((self.playerXY[2]  - (self.playerPosition[2]*spriteHeightWidth)) * playerSpeed * dt)
end

function Level:keypressed(key)

    local moveX = 0
    local moveY = 0

    if key == "right" then
        moveX = 1
    end
    
    if key == "left" then
        moveX = -1
    end

    if key == "down" then
        moveY = 1
    end

    if key == "up" then
        moveY = -1
    end

    local newPosX = self.playerPosition[1] + moveX
    local newPosY = self.playerPosition[2] + moveY

    if  playerPositionValid(self, newPosX, newPosY) then
        self.playerPosition[1] = newPosX
        self.playerPosition[2] = newPosY
    else
        --play sound
    end
end

function Level:draw()
    if not(self.run) or #self.map == 0 then
        return
    end
    
    for i,row in ipairs(self.map) do
        for j,col in ipairs(row) do
            local spriteToDraw

            if col == waterSpriteNum then
                spriteToDraw = waterSprite
            elseif col == grassSprite1Num then
                spriteToDraw = grassSprite1
            elseif col == grassSprite2Num then
                spriteToDraw = grassSprite2
            elseif col == sandSprite1Num then
                spriteToDraw = sandSprite1
            elseif col == sandSprite2Num then
                spriteToDraw = sandSprite2
            elseif col == sandTopShoreNum then
                spriteToDraw = sandTopShore
            elseif col == sandRightShoreNum then
                spriteToDraw = sandRightShore
            elseif col == sandBottomShoreNum then
                spriteToDraw = sandBottomShore
            elseif col == sandLeftShoreNum then
                spriteToDraw = sandLeftShore
            elseif col == sandBottomRightShoreNum then
                spriteToDraw = sandBottomRightShore
            elseif col == sandBottomLeftShoreNum then
                spriteToDraw = sandBottomLeftShore
            end

            love.graphics.draw(spriteToDraw, j * spriteHeightWidth, i * spriteHeightWidth)
        end
    end

    love.graphics.draw(playerSprite, self.playerXY[1], self.playerXY[2])
end