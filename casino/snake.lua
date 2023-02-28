local mon = peripheral.wrap("monitor_0")
local w, h = mon.getSize() -- 71w, 26h
local difficulty = 1 -- Seconds between each frame update
local direction = "right"
local headPosX = 36
local headPosY = 14
local applePosX = 0
local applePosY = 0
local movedThisFrame = false


function drawFilledRectangle(x1, y1, x2, y2, color)
    mon.setBackgroundColor(color)
    for y=y1, y2 do
        for x=x1, x2 do
            mon.setCursorPos(x, y)
            mon.write(" ")
        end
    end
end


function updateScore(score)
    mon.setBackgroundColor(colors.white)
    mon.setTextColor(colors.purple)
    mon.setCursorPos(2, 1)
    mon.write("Score: " .. score)
end


function colorPixel(x, y, color)
    mon.setBackgroundColor(color)
    mon.setCursorPos(x, y)
    mon.write(" ")
end


function spawnApple()
    applePosX = math.random(2, 70)
    applePosY = math.random(3, 25)
end

function frame()

    drawFilledRectangle(2, 3, 70, 25, colors.black)
    updateScore(0)

    -- Check for input
    if redstone.testBundledInput("back", colors.blue) and direction ~= "left" then
        direction = "right"
    elseif redstone.testBundledInput("back", colors.red) and direction ~= "up" then
        direction = "down"
    elseif redstone.testBundledInput("back", colors.magenta) and direction ~= "down" then
        direction = "up"
    elseif redstone.testBundledInput("back", colors.green) and direction ~= "right" then
        direction = "left"
    end

    -- Move
    if direction == "right" and not movedThisFrame then
        headPosX = headPosX + 1
        movedThisFrame = true
    elseif direction == "left" and not movedThisFrame then
        headPosX = headPosX - 1
        movedThisFrame = true
    elseif direction == "up" and not movedThisFrame then
        headPosY = headPosY - 1
        movedThisFrame = true
    elseif direction == "down" and not movedThisFrame then 
        headPosY = headPosY + 1
        movedThisFrame = true
    end

    colorPixel(headPosX, headPosY, colors.gray)
    colorPixel(applePosX, applePosY, colors.red)
    movedThisFrame = false
end

mon.clear()

drawFilledRectangle(1, 1, 71, 26, colors.white)
drawFilledRectangle(2, 3, 70, 25, colors.black)
spawnApple()

while true do
    frame()
    sleep(difficulty)
end



-- Playing field size x = 2-70 (68) y = 3-25 (22). Center: (36, 14)