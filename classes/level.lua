Level = Object.extend(Object)

local spriteHeightWidth = 32
local mapSpriteXYSize = 16
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

local level1 = {
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 0, 2, 1, 2, 1, 2, 2, 1, 1, 2, 1, 2, 1, 2, 1, 0 },
    { 0, 1, 2, 21, 24, 24, 24, 24, 24, 24, 20, 2, 24, 24, 27, 0 },
    { 0, 26, 24, 27, 0, 0, 0, 0, 0, 0, 26, 1, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 },
    { 0, 1, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0 },
    { 0, 1, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 0 },
    { 0, 2, 1, 2, 1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 0 },
    { 0, 2, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 0 },
    { 0, 25, 20, 23, 0, 0, 0, 0, 1, 2, 1, 2, 1, 1, 2, 0 },
    { 0, 26, 24, 27, 0, 0, 0, 0, 25, 20, 21, 20, 23, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 0, 0, 0, 26, 24, 24, 24, 27, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
}

local function populateLevelTable(levelTable)
    for i = 1, mapSpriteXYSize do
        levelTable[i] = {}

        for j = 1, mapSpriteXYSize do
            levelTable[i][j] = level1[i][j]
        end
    end
end

local function loadSprites()
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
end