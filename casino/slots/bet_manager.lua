-- Calculates bet from turtle's inventory.
function calculateBet()
    local bet = 0
    for i=1,16 do
        item = turtle.getItemDetail(i)
        if item then
            if item.name == "minecraft:gold_ingot" then
                bet = bet + turtle.getItemCount(i)
            elseif item.name == "minecraft:gold_block" then
                bet = bet + turtle.getItemCount(i) * 9
            end
        end
    end
    return bet
end


-- Above container with gold blocks, below gold ingots. Withdraws max gold blocks then ingots.
function withdraw(qty)
 
    turtle.select(1)
    local blocks = math.floor(qty / 9)
    local ingots = qty % 9
 
    local res = blocks
    if blocks > 64 then
        repeat
            turtle.suckUp(64)
            res = res - 64
        until res <= 64
    end
 
    turtle.suckUp(res)
    turtle.suckDown(ingots)
end


-- Deposits bet into storage
function deposit()
    for i=1,16 do
        item = turtle.getItemDetail(i)
        if item then
            if item.name == "minecraft:gold_ingot" then
                turtle.select(i)
                turtle.dropDown()
            elseif item.name == "minecraft:gold_block" then
                turtle.select(i)
                turtle.dropUp()
            end
        end
    end
end


-- Dispenses turtle's inventory to player (behind turtle)
function cashout()
    for i=1,16 do
        turtle.select(i)
        turtle.drop()
    end
end


-- Helper function that compares blocks in up/down/forward positions
function compareBlock(direction, itemName)
 
    local info = info
 
    if direction == "up" then
        local _, inspected = turtle.inspectUp()
        info = inspected
    elseif direction == "down" then
        local _, inspected = turtle.inspectDown()
        info = inspected
    elseif direction == "forward" then
        local _, inspected = turtle.inspect()
        info = inspected
    end
 
    if info.name == itemName then
         return true
    else
        return false
    end
end


while true do
    reward = 0
    if redstone.getInput("right")then 

        -- Read input bet
        local bet = calculateBet()
        local res = bet - 64

        -- Deposits bet in storage
        deposit()

        -- Max bet 64
        if res > 0 then
            withdraw(res)
            cashout()
            bet = 64
        end

        -- Signal a spin
        print("Signaling to spin with bet: " .. bet)
        rednet.open("left")
        rednet.broadcast(bet, "1836299479664403")


        -- Wait for response
        print("Waiting for response")
        local _, reward, _ = rednet.receive("1836299479664404")
        print("Response received. Reward: ".. reward)
        
        -- Close connection
        rednet.close("left")

        -- Give reward
        if reward > 0 then 
            withdraw(reward)
            cashout()
        end
        sleep(3.5)
    end

    sleep(0.5)
end
