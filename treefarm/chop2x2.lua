-- 06.06.2021.
-- Chops a 2x2 spruce tree even after chunk reload. Turtle should be placed in front of the south-east sapling, above a chest.
-- This sapling should be under coarse dirt.

-- Initial function. Figures out whether the turtle was idle/chopping or flying down before chunk reload. 
function checkState()
    local state = ""

    if compareBlock("forward", "minecraft:sapling") then
        state = "idle"
    elseif not blockExists("up") and not blockExists("down") then
        state = "descending"
    elseif compareBlock("up", "minecraft:log") or compareBlock("up", "minecraft:leaves") then
        state = "chopping"
    else
        state = "searching"
    end

    print("Currently ".. state)
    return state
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


-- Helper function that returnts true if a block is present in the given direction
function blockExists(direction)
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

    if info.name == nil then
         return false
    else
        return true
    end
end


-- Checks every 5 seconds whether tree has grown
function idle()
    local waiting = true 
    while waiting do
        sleep(5)
        if not compareBlock("forward", "minecraft:sapling") then
            waiting = false
        end
    end
end


-- Turtle descends until hits ground
function descend()
    while not turtle.detectDown() do
        turtle.down()
    end
end


-- Turtle keeps chopping above itself
function chop()
    while turtle.detectUp() do
        turtle.digUp()
        turtle.up()
    end
end


-- Turtle tries to find next log column to chop
function search()
    if compareBlock("forward", "minecraft:log") then 
        turtle.dig()
        turtle.forward()
    else
        turtle.forward()
        if compareBlock("up", "minecraft:log") then
            return
        elseif compareBlock("forward", "minecraft:log") then
            turtle.dig()
            turtle.forward()
        else
            turtle.turnLeft()
            if compareBlock("forward", "minecraft:log") then
                turtle.dig()
                turtle.forward()
            else
                turtle.turnRight()
                turtle.back()
                turtle.turnLeft()
            end
        end
    end
end


-- Turtle finds a way back to its idle position
function returnToIdlePos()
    while true do
        local _, inspectDown = turtle.inspectDown()
        if inspectDown.metadata == 1 then -- coarse dirt underneath
            turtle.forward()
            local _, inspectDown = turtle.inspectDown()
            if inspectDown.name == "minecraft:chest" then
                turtle.turnLeft()
                turtle.turnLeft()
                return
            else
                turtle.back()
                turtle.turnLeft()
                turtle.back()
                return
            end
        elseif inspectDown.name == "minecraft:dirt" then
            turtle.forward()
        else
            turtle.back()
            turtle.turnLeft()
        end
    end 
end


-- Checks whether fuel limit is under threshold and refuels with the items in given slot. If refueled, returns true
function refuel(threshold)
    if turtle.getFuelLevel() < threshold then
        for i=1, 16 do
            if turtle.getItemDetail(i) ~= nil then
                if turtle.getItemDetail(i).name == "minecraft:log" then
                    turtle.select(i)
                    turtle.refuel()
                end
            end
        end
    end
end


-- Empties all logs in the inventory
function depositLogs()
    for i=1, 16 do
        if turtle.getItemDetail(i) ~= nil then
            if turtle.getItemDetail(i).name == "minecraft:log" then
                turtle.select(i)
                turtle.dropDown()
            end
        end
    end
end


-- if turtle can't find a log 4 times in a row, the tree has been chopped down
local searchCounter = 0

-- Main loop
while true do

    -- Checks current state and acts accordingly
    local state = checkState()

    if state == "idle" then
        idle()
    elseif state == "descending" then
        descend()
    elseif state == "chopping" then
        chop()
        searchCounter = 0
    elseif searchCounter >= 4 then
        returnToIdlePos()
        print("Idle position found. Activating redstone.")
        redstone.setOutput("back", true)
        sleep(1)
        redstone.setOutput("back", false)
        searchCounter = 0
        refuel(500)
        print("Depositing logs: ")
        depositLogs()
        print("Returning to idle mode.")
    elseif state == "searching" then
        search()
        searchCounter = searchCounter + 1
    end
end
     