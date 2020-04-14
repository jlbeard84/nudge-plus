Level = Object.extend(Object)

local keyPressed = false

local spriteHeightWidth = 32
local mapSpriteXYSize = 16
local playerSpeed = 30

local playerSprite
local bananaSprite
local gateSprite

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
    bananaSprite = love.graphics.newImage("/sprites/banana.png")
    gateSprite = love.graphics.newImage("/sprites/gate.png")

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

local function objectPositionValid(self, posX, posY)
    if posX < 1 or posX > mapSpriteXYSize or posY < 1 or posY > mapSpriteXYSize or self.map[posY][posX] == 0 then
        return false
    end

    return true
end

local function objectIntersectsBanana(self, posX, posY)
    local bananaIndex = 0
    
    for i, bananaPosition in ipairs(self.bananaPositions) do
        if posX == bananaPosition[1] and posY == bananaPosition[2] then 
            bananaIndex = i
            break
        end
    end

    return bananaIndex
end

local function convertToLocalPosition(x, y)
    local localX = x * spriteHeightWidth
    local localY = y * spriteHeightWidth

    return { localX, localY }
end

local function convertToGlobalPosition(dt, currentGlobalPosition, currentLocalPosition)
    return currentGlobalPosition - ((currentGlobalPosition  - (currentLocalPosition*spriteHeightWidth)) * playerSpeed * dt)
end

function Level:new(levelMap)
    self.map = {}
    self.run = false
    self.playerPosition = { 0, 0 }
    self.playerXY = { 0, 0 }
    self.gatePosition = { 0, 0 }
    self.bananaPositions = {}
    self.bananaXYs = {}

    loadSprites()
end

function Level:loadMap(map, playerStartPosition, bananaPositions, gatePosition)
    self.map = map
    self.playerPosition = playerStartPosition
    self.playerXY = convertToLocalPosition(self.playerPosition[1], self.playerPosition[2])
    self.bananaPositions = bananaPositions
    self.gatePosition = gatePosition

    for i, bananaPosition in ipairs(bananaPositions) do
        table.insert(self.bananaXYs, convertToLocalPosition(bananaPosition[1], bananaPosition[2]))
    end
end

function Level:setRun(shouldRun)
    self.run = shouldRun
end

function Level:update(dt)

    if not(self.run) then
        return
    end

    self.playerXY[1] = convertToGlobalPosition(dt, self.playerXY[1], self.playerPosition[1])
    self.playerXY[2] = convertToGlobalPosition(dt, self.playerXY[2], self.playerPosition[2])

    for i, bananaPosition in ipairs(self.bananaPositions) do
        self.bananaXYs[i][1] = convertToGlobalPosition(dt, self.bananaXYs[i][1], bananaPosition[1])
        self.bananaXYs[i][2] = convertToGlobalPosition(dt, self.bananaXYs[i][2], bananaPosition[2])
    end
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

    local intersectingBananaIndex = objectIntersectsBanana(self, newPosX, newPosY)

    if intersectingBananaIndex > 0 then
        local newBananaX = self.bananaPositions[intersectingBananaIndex][1] + moveX
        local newBananaY = self.bananaPositions[intersectingBananaIndex][2] + moveY

        if objectPositionValid(self, newBananaX, newBananaY) and objectIntersectsBanana(self, newBananaX, newBananaY) == 0 then
            self.playerPosition[1] = newPosX
            self.playerPosition[2] = newPosY
            
            if self.gatePosition[1] == newBananaX and self.gatePosition[2] == newBananaY then
                table.remove(self.bananaPositions, intersectingBananaIndex)
                table.remove(self.bananaXYs, intersectingBananaIndex)
            else
                self.bananaPositions[intersectingBananaIndex][1] = newBananaX
                self.bananaPositions[intersectingBananaIndex][2] = newBananaY
            end
        else
            --play sound
        end
    elseif objectPositionValid(self, newPosX, newPosY) then
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

    for i, bananaXY in ipairs(self.bananaXYs) do
        love.graphics.draw(bananaSprite, bananaXY[1], bananaXY[2])
    end

    local gateLocalPosition = convertToLocalPosition(self.gatePosition[1], self.gatePosition[2])

    love.graphics.draw(gateSprite, gateLocalPosition[1], gateLocalPosition[2])
end