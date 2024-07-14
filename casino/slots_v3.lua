-- draw methods
function initialScreen(bet)
    drawFilledRectangle(1, 1, width, height, colors.green)
    drawFilledRectangle(5, 4, width - 4, height - 1, colors.black)

    drawHeader(bet)
    drawArrows()

    local col = {colors.orange, colors.purple, colors.blue}
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
    centerText("IN TOP LEFT CORNER", 10)
end

-- logic methods
function spin(animationSleepTime, spinCountOffset, bet)

    local elements = {}
    if isWin(bet) then
        print("win")
        local combo = weightedRandomCombo(bet)
        print(combo[1] .. " " .. combo[2])
        elements = setElements(combo[1], combo[2])
    else
        print("lose")
        elements = setElementsNoMoreThanTwice()
    end

    local r1 = elements[1]
    local r2 = elements[2]
    local r3 = elements[3]
    local r4 = elements[4]
    local r5 = elements[5]
    
    print("r1 " .. tostring(r1) .. " r2: " .. tostring(r2) .. " r3: " ..  tostring(r3) .. " r4: " ..  tostring(r4) .. " r5: " ..  tostring(r5))

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
 
    return {r1, r2, r3, r4, r5}
end

function isWin(bet)
    local r = math.random(1, 100)
    local winChance = 50
    print("rwin " .. r)

    if bet > 0 and bet <= 3 then
        winChance = winChances[1]
    elseif bet > 3 and bet <= 5 then
        winChance = winChances[2]
    elseif bet > 5 and bet <= 8 then
        winChance = winChances[3]
    elseif bet > 8 and bet <= 10 then
        winChance = winChances[4]
    elseif bet > 10 and bet <= 15 then
        winChance = winChances[5]
    elseif bet > 15 and bet <= 30 then
        winChance = winChances[6]
    elseif bet > 30 and bet <= 60 then
        winChance = winChances[7]
    elseif bet > 60 and bet <= 100 then
        winChance = winChances[8]
    end        
    
    print("winChance" .. winChance)

    if r >= 1 and r <= winChance then
        return true
    end

    return false
end

function weightedRandomCombo(bet)
    local r = math.random(1, 175)
    print("combo r: " .. r)
    
    -- if bet <= 5 then
    --     r = math.min(r + 20, 170)
    -- elseif bet <= 10 then
    --     r = math.min(r + 15, 170)
    -- elseif bet <= 20 then
    --     r = math.min(r + 10, 170)
    -- elseif bet <= 30 then
    --     r = math.min(r + 5, 170)
    -- end

    print("bet modified combo r: " .. r)
    if r >= 1 and r < weightsCombo[1] then -- 1 to 44
        return {1, 3}
    elseif r >= weightsCombo[1] and r < weightsCombo[2] then -- 45 to 67
        return {1, 4}
    elseif r >= weightsCombo[2] and r < weightsCombo[3] then -- 68 to 78
        return {1, 5}
    elseif r >= weightsCombo[3] and r < weightsCombo[4] then -- 79 to 103
        return {2, 3}
    elseif r >= weightsCombo[4] and r < weightsCombo[5] then -- 104 to 115
        return {2, 4}
    elseif r >= weightsCombo[5] and r < weightsCombo[6] then -- 116 to 121
        return {2, 5}
    elseif r >= weightsCombo[6] and r < weightsCombo[7] then -- 122 to 136
        return {3, 3}
    elseif r >= weightsCombo[7] and r < weightsCombo[8] then -- 137 to 144
        return {3, 4}
    elseif r >= weightsCombo[8] and r < weightsCombo[9] then -- 145 to 148
        return {3, 5}
    elseif r >= weightsCombo[9] and r < weightsCombo[10] then -- 149 to 158
        return {4, 3}
    elseif r >= weightsCombo[10] and r < weightsCombo[11] then -- 159 to 163
        return {4, 4}
    elseif r >= weightsCombo[11] and r < weightsCombo[12] then -- 164 to 166
        return {4, 5}
    elseif r >= weightsCombo[12] and r < weightsCombo[13] then -- 167 to 171
        return {5, 3}
    elseif r >= weightsCombo[13] and r < weightsCombo[14] then -- 172 to 174
        return {5, 4}
    elseif r >= weightsCombo[14] and r < weightsCombo[15] then -- 175 to 175
        return {5, 5}
    end

    return {5, 3}
end

function setElements(element, count)
    local result = {}
    
    for i = 1, count do
        table.insert(result, element)
    end
    
    while #result < 5 do
        local randomElement = math.random(1, 5)
        if randomElement ~= element or (randomElement == element and count == 0) then
            table.insert(result, randomElement)
        end
    end
    
    for i = #result, 2, -1 do
        local j = math.random(i)
        result[i], result[j] = result[j], result[i]
    end
    
    return result
end

function setElementsNoMoreThanTwice()
    local allElements = {1, 2, 3, 4, 5}
    local result = {}
    local elementCount = {}
    for _, el in ipairs(allElements) do
        elementCount[el] = 0
    end

    local function getRandomElement()
        local validElements = {}
        for _, el in ipairs(allElements) do
            if elementCount[el] < 2 then
                table.insert(validElements, el)
            end
        end

        return validElements[math.random(#validElements)]
    end

    while #result < 5 do
        local randomElement = getRandomElement()
        table.insert(result, randomElement)
        elementCount[randomElement] = elementCount[randomElement] + 1
    end

    for i = #result, 2, -1 do
        local j = math.random(i)
        result[i], result[j] = result[j], result[i]
    end

    return result
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
weightsCombo = {45, 68, 79, 104, 116, 122, 137, 145, 149, 159, 164, 167, 172, 175, 176}

coefTable3 = {1, 1, 1, 2, 2}
coefTable4 = {2, 3, 4, 6, 8}
coefTable5 = {3, 4, 5, 10, 16}

maxBet = 100
currency = "pocket_money:copper_coin"
idleTimer = 1800 -- seconds = idleTimer / 2
winChances = {60, 50, 45, 40, 35, 30, 20, 10} -- if bet is between 0-3, 3-5, 5-8, 8-10, 10-15, 15-30, 30-60, 60-100

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
            
            -- give back the extra
            if extra > 0 then
                withdraw(extra, 64)
                bet = 100
            end
            initialScreen(bet)

            reward = calculateWinnings(spin(0.05, 30, bet), bet)
            if reward > 0 then
                drawWinnerScreen()
                speaker1.playSound("minecraft:entity.player.levelup", 3, 1)
                withdraw(reward, 64)
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
            initialScreen(math.min(bet, 100))
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
