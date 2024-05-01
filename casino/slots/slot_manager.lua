local mon = peripheral.wrap("monitor_2")
local w, h = mon.getSize()

function initialScreen()
    drawFilledRectangle(1, 1, 18, 12, colors.purple)
    drawFilledRectangle(2, 2, 17, 12, colors.black)

    drawHeader(0)

    -- Draw Arrows
    mon.setBackgroundColor(colors.lime)
    for i=6, 8 do
        mon.setCursorPos(1, i)
        mon.write(" ")
    end

    for i=6, 8 do
        mon.setCursorPos(18, i)
        mon.write(" ")
    end

    for i=3, 14, 5 do
        drawSingleBlock(3, i, colors.orange)
        drawSingleBlock(6, i, colors.red)
        drawSingleBlock(9, i, colors.blue)
    end
end


function drawFilledRectangle(x1, y1, x2, y2, color)
    mon.setBackgroundColor(color)
    for y=y1, y2 do
        for x=x1, x2 do
            mon.setCursorPos(x, y)
            mon.write(" ")
        end
    end
end
 
function drawHeader(bet)
    mon.setBackgroundColor(colors.purple)
    mon.setCursorPos(1, 1)
    mon.write("Slots")
    mon.setCursorPos(13, 1)
    mon.write("Bet:" .. bet)
end
 
 
function drawSingleBlock(x, y, color)
    mon.setBackgroundColor(color)
    for i=y, y+3 do
        for j=x, x+2 do
            mon.setCursorPos(i, j)
            mon.write(" ")
        end
    end
    mon.setCursorPos(3, 3)
end
 
function spinOnce(col, colorOrder, i)
    drawSingleBlock(3, col, colorOrder[math.fmod(i, 5)])
    drawSingleBlock(6, col, colorOrder[math.fmod(i - 1,5)])
    drawSingleBlock(9, col, colorOrder[math.fmod(i - 2,5)])
end
 
function spin()
 
    local colorOrder = {}
    colorOrder[0] = colors.orange
    colorOrder[1] = colors.red
    colorOrder[2] = colors.blue
    colorOrder[3] = colors.purple
    colorOrder[4] = colors.cyan
 
 
    -- Generate random value for each slots column
    local r1 = math.random(0, 4)
    local r2 = math.random(0, 4)
    local r3 = math.random(0, 4)
    
    -- Calculate how many times the column will spin
    local s1 = r1 + 21
    local s2 = r2 + 31
    local s3 = r3 + 41
 
    -- Counters to keep track of current spin position
    local c1 = 2
    local c2 = 2
    local c3 = 2
 
    while c3 <= s3 do
 
        if c1 <= s1 then 
            spinOnce(3, colorOrder, c1)
            c1 = c1 + 1
        end
 
        if c2 <= s2 then 
            spinOnce(8, colorOrder, c2)
            c2 = c2 + 1
        end
 
        if c3 <= s3 then
            spinOnce(13, colorOrder, c3)
            c3 = c3 + 1
        end
        sleep(0.125)
    end
 
    print("r1 " .. r1)
    print("r2 " .. r2)
    print("r3 " .. r3)
    res = {}
    res["1st"] = r1
    res["2nd"] = r2
    res["3rd"] = r3
    return res
end
 
 
function calculateWinnings(res, bet)
    local r1 = res["1st"]
    local r2 = res["2nd"]
    local r3 = res["3rd"]
 
    local coefTable2 = {}
    coefTable2[0] = 1
    coefTable2[1] = 2
    coefTable2[2] = 2
    coefTable2[3] = 3
    coefTable2[4] = 4
 
    local coefTable3 = {}
    coefTable3[0] = 3
    coefTable3[1] = 4
    coefTable3[2] = 8
    coefTable3[3] = 16
    coefTable3[4] = 32
    local prize = 0
 
    print("Bet: " .. bet)
    if r1 == r2 and r2 == r3 then
        prize = bet * coefTable3[r1]
    elseif r1 == r2 or r1 == r3 then
        prize = bet * coefTable2[r1]
    elseif r2 == r3 then
        prize = bet * coefTable2[r2]
    end
    print("Prize: " .. prize)
    return prize
end
 


-- Main loop
while true do

    mon.clear()
    initialScreen()

    rednet.open("right")
    print("Waiting for bet.")
    local _, bet, _ = rednet.receive("1836299479664403")
    print("Bet received: " .. bet)
    drawHeader(bet)
    reward = calculateWinnings(spin(), bet)

    mon.setBackgroundColor(colors.lime)
    mon.setCursorPos(2, 5)
    mon.write(string.rep(" ", 16))
    mon.setCursorPos(2, 9)
    mon.write(string.rep(" ", 16))
    mon.setBackgroundColor(colors.black)

    mon.setCursorPos(7, 2)

    if reward > 0 and bet > 0 then
        mon.write("Winner!")
        mon.setCursorPos(3, 12)
        mon.write("Win:" .. reward)
    elseif bet ~= 0 and reward == 0 then
        mon.write("Loser!")
    end

    print("Sending reward: " .. reward)
    rednet.broadcast(reward, "1836299479664404")
    sleep(4)
end 
rednet.close("right")

