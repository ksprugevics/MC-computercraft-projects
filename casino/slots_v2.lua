-- draw methods
function initialScreen(bet)
    drawFilledRectangle(1, 1, width, height, colors.green)
    drawFilledRectangle(5, 4, width - 4, height - 1, colors.black)

    drawHeader(bet)
    drawArrows()

    local col = {colors.orange, colors.red, colors.blue}
    drawSingleColumn(6, 8, col)
    drawSingleColumn(10, 12, col)
    drawSingleColumn(14, 16, col)
    drawSingleColumn(18, 20, col)
    drawSingleColumn(22, 24, col)
end

function drawFilledRectangle(x1, y1, x2, y2, color)
    monitor.setBackgroundColor(color)
    for y=y1, y2 do
        for x=x1, x2 do
            monitor.setCursorPos(x, y)
            monitor.write(" ")
        end
    end
end

function drawHeader(bet)
    monitor.setBackgroundColor(colors.green)
    monitor.setCursorPos(1, 1)
    monitor.write("Bet:" .. bet)
    monitor.setCursorPos(25, 1)
    monitor.write("Slots")
    centerText("BOOK OF STEVE", 2)
end

function centerText(text, y)
    local startX = math.floor((width - #text) / 2) + 1
    monitor.setCursorPos(startX, y)
    monitor.write(text)
end

function drawArrows()
    drawFilledRectangle(2, 6, 2, 9, colors.white)
    drawFilledRectangle(3, 7, 3, 8, colors.white)
    drawFilledRectangle(28, 6, 28, 9, colors.white)
    drawFilledRectangle(27, 7, 27, 8, colors.white)
end

function drawSingleColumn(x1, x2, colors)
    y1_steps = {5, 7, 9}
    y2_steps = {6, 8, 10}
    drawFilledRectangle(x1, y1_steps[1], x2, y2_steps[1], colors[1])
    drawFilledRectangle(x1, y1_steps[2], x2, y2_steps[2], colors[2])
    drawFilledRectangle(x1, y1_steps[3], x2, y2_steps[3], colors[3])
end

function drawWinnerScreen()
    drawFilledRectangle(5, 6, 25, 6, colors.lime)
    drawFilledRectangle(5, 9, 25, 9, colors.lime)
    drawFilledRectangle(5, 6, 5, 9, colors.lime)
    drawFilledRectangle(25, 6, 25, 9, colors.lime)
    centerText("WINNER!!", 6)
    centerText("Win:" .. reward, 9)
end

function drawLoserScreen()
    drawFilledRectangle(5, 6, 25, 6, colors.red)
    drawFilledRectangle(5, 9, 25, 9, colors.red)
    drawFilledRectangle(5, 6, 5, 9, colors.red)
    drawFilledRectangle(25, 6, 25, 9, colors.red)
    centerText("LOSER!!", 6)
end

function drawIdleScreen()
    initialScreen(0)
    drawFilledRectangle(5, 4, width - 4, height - 1, colors.black)
    centerText("-- IDLE MODE --", 5)
    centerText("INSERT BET AND WAIT", 8)
    centerText("FOR MACHINE", 9)
    centerText("TO RESTART (20s)", 10)
end

function drawInsertBetScreen()
    initialScreen(0)
    drawFilledRectangle(5, 4, width - 4, height - 1, colors.black)
    centerText("-- TUTORIAL --", 5)
    centerText("INSERT BET AND WAIT", 8)
    centerText("FOR IT TO SHOW UP", 9)
    centerText("IN TOP RIGHT CORNER", 10)
end

-- logic methods
function spin(animationSleepTime, spinCountOffset)

    local r1 = weightedRandom()
    local r2 = weightedRandom()
    local r3 = weightedRandom()
    local r4 = weightedRandom()
    local r5 = weightedRandom()
    
    -- Calculate how many times the column will spin
    local s1 = r1 + 3 * spinCountOffset
    local s2 = r2 + 4 * spinCountOffset
    local s3 = r3 + 5 * spinCountOffset
    local s4 = r4 + 6 * spinCountOffset
    local s5 = r5 + 7 * spinCountOffset
 
    -- Counters to keep track of current spin position
    local c1 = 2
    local c2 = 2
    local c3 = 2
    local c4 = 2
    local c5 = 2
 
    while c5 <= s5 do
        if c1 <= s1 then
            drawSingleColumn(6, 8, {colorOrder[math.fmod(c1, 5) + 1], colorOrder[math.fmod(c1 - 1,5) + 1], colorOrder[math.fmod(c1 - 2,5) + 1]})
            c1 = c1 + 1
            if c1 == s1 + 1 then
                speaker2.playSound("entity.experience_orb.pickup", 3, 1)
            end
        end
        if c2 <= s2 then
            drawSingleColumn(10, 12, {colorOrder[math.fmod(c2, 5) + 1], colorOrder[math.fmod(c2 - 1,5) + 1], colorOrder[math.fmod(c2 - 2,5) + 1]})
            c2 = c2 + 1
            if c2 == s2 + 1 then
                speaker2.playSound("entity.experience_orb.pickup", 3, 1)
            end
        end
 
        if c3 <= s3 then
            drawSingleColumn(14, 16, {colorOrder[math.fmod(c3, 5) + 1], colorOrder[math.fmod(c3 - 1,5) + 1], colorOrder[math.fmod(c3 - 2,5) + 1]})
            c3 = c3 + 1
            if c3 == s3 + 1 then
                speaker2.playSound("entity.experience_orb.pickup", 3, 1)
            end
        end

        if c4 <= s4 then
            drawSingleColumn(18, 20, {colorOrder[math.fmod(c4, 5) + 1], colorOrder[math.fmod(c4 - 1,5) + 1], colorOrder[math.fmod(c4 - 2,5) + 1]})
            c4 = c4 + 1
            if c4 == s4 + 1 then
                speaker2.playSound("entity.experience_orb.pickup", 3, 1)
            end
        end

        if c5 <= s5 then
            drawSingleColumn(22, 24, {colorOrder[math.fmod(c5, 5) + 1], colorOrder[math.fmod(c5 - 1,5) + 1], colorOrder[math.fmod(c5 - 2,5) + 1]})
            c5 = c5 + 1
            if c5 == s5 + 1 then
                speaker2.playSound("entity.experience_orb.pickup", 3, 1)
            end
        end

        speaker1.playSound("minecraft:block.note_block.harp", 2, 1.25)
        sleep(animationSleepTime)
    end
 
    print("r1 " .. tostring(r1) .. " r2: " .. tostring(r2) .. " r3: " ..  tostring(r3) .. " r4: " ..  tostring(r4) .. " r5: " ..  tostring(r5))
    return {r1, r2, r3, r4, r5}
end

function weightedRandom()
    local r = math.random(1, 100)
    print(r)
    if r >= 1 and r < weights[1] then
        return 1
    elseif r >= weights[1] and r < weights[2] then
        return 2
    elseif r >= weights[2] and r < weights[3] then
        return 3
    elseif r >= weights[3] and r < weights[4] then
        return 4
    elseif r >= weights[4] and r <=100 then
        return 5
    end
    
    return 1
end

function calculateWinnings(result, bet)
    local prize = 0
    local matchCount = 0
    local matchElement = nil

    local elements = {r1, r2, r3, r4, r5}
    local counts = {}
    
    for i = 1, #result do
        if counts[result[i]] == nil then
            counts[result[i]] = 1
        else
            counts[result[i]] = counts[result[i]] + 1
        end
    end

    for k, v in pairs(counts) do
        if v > matchCount then
            matchCount = v
            matchElement = k
        end
    end

    print("match count .. " .. matchCount)
    print("match element .. "..  matchElement)

    if matchCount == 3 then
        prize = bet * coefTable3[matchElement]
    elseif matchCount == 4 then
        prize = bet * coefTable4[matchElement]
    elseif matchCount == 5 then
        prize = bet * coefTable5[matchElement]
    end

    print("Prize: " .. prize)
    return prize
end

-- bet methods
function calculateBet()
    local bet = 0
    for i=1,16 do
        item = turtle.getItemDetail(i)
        if item then
            if item.name == currency then
                bet = bet + turtle.getItemCount(i)
            else 
                turtle.select(i)
                turtle.dropUp()
            end
        end
    end
    turtle.select(1)
    return bet
end

function deposit()
    for i=1,16 do
        item = turtle.getItemDetail(i)
        if item then
            if item.name == currency then
                turtle.select(i)
                turtle.dropDown()
            end
        end
    end
    turtle.select(1)
end

function withdraw(qty, chunks)
    turtle.select(1)

    if qty < chunks then
        turtle.suckDown(qty)
        turtle.dropUp(qty)
        return
    end

    local count = qty
    local remainder = qty % chunks
    repeat
        turtle.suckDown(chunks)
        turtle.dropUp(chunks)
        count = count - chunks
    until count <= remainder
    turtle.suckDown(remainder)
    turtle.dropUp(remainder)
end

colorOrder = {}
colorOrder[1] = colors.lightGray
colorOrder[2] = colors.cyan
colorOrder[3] = colors.blue
colorOrder[4] = colors.purple
colorOrder[5] = colors.orange

weights = {45, 70, 85, 95, 100}

coefTable3 = {1, 1, 1, 2, 2}
coefTable4 = {1, 2, 4, 6, 8}
coefTable5 = {3, 4, 5, 10, 16}

maxBet = 100
currency = "pocket_money:copper_coin"
idleTimer = 1800 -- seconds = idleTimer / 2

local speakers = table.pack(peripheral.find("speaker"))
speaker1 = speakers[1]
speaker2 = speakers[2]
monitor = peripheral.find("monitor")
monitor.setTextScale(1)
width, height = monitor.getSize()

monitor.clear()
initialScreen(0)

idleCounter = 0

while true do
    local bet = calculateBet(bet)
    if redstone.getInput("right") then
        if bet <= 0 then
            drawInsertBetScreen()
            sleep(3)
        else 
            idleCounter = 0

            local bet = calculateBet()
            local extra = bet - maxBet
            print("bet .. " .. bet)
            print("extra .. " .. extra)
            deposit()
            initialScreen(bet)

            -- give back the extra
            if extra > 0 then
                withdraw(extra, 64)
            end

            reward = calculateWinnings(spin(0.05, 30), bet)
            reward = bet
            if reward > 0 then
                drawWinnerScreen()
                speaker1.playSound("minecraft:entity.player.levelup", 3, 1)
                withdraw(reward, 10)
            else
                drawLoserScreen()
                speaker1.playSound("minecraft:entity.player.death", 3, 1)
                speaker2.playSound("minecraft:entity.player.death", 3, 1)
            end

            sleep(4)

            initialScreen(0)
        end
    else
        if bet > 0 then
            initialScreen(bet)
            idleCounter = 0
        elseif idleMode then
            monitor = peripheral.find("monitor")
            drawIdleScreen()
            sleep(15)
        else 
            idleCounter = idleCounter + 1
        end
    end

    if idleCounter > idleTimer then
        idleMode = true
    else
        idleMode = false
    end
    sleep(0.5)
end
