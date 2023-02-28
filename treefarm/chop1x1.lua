-- 12.06.2021.
-- Chops a single column tree. Turtle should be placed in front of a sapling, over an item deposit block.


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


-- Checks whether fuel limit is under threshold and refuels using the given fuel name
function refuel(threshold, fuel)
    if turtle.getFuelLevel() < threshold then
        for i=1, 16 do
            if turtle.getItemDetail(i) ~= nil then
                if turtle.getItemDetail(i).name == fuel then
                    turtle.select(i)
                    turtle.refuel()
                end
            end
        end
    end
end

-- Turtle descends until hits ground
function descend()
    while not turtle.detectDown() do
        turtle.down()
    end
end

-- Initial function, that figures out the whether the turtle was idle/chopping before chunk reload
function checkState()
    local state = ""

    if compareBlock("down", "quark:pipe") and not blockExists("forward") then
        state = "service"
    elseif compareBlock("up", "minecraft:log") then
        state = "chopping"
    elseif compareBlock("down", "minecraft:dirt") then
        state = "returning"
    elseif compareBlock("forward", "minecraft:log") then
        turtle.dig()
        turtle.forward()
    elseif compareBlock("forward", "minecraft:sapling") then
        state = "idle"
    elseif not blockExists("up") then
        turtle.up()
        if blockExists("up") then
            state = "chopping"
        else
            state = "descending"
            descend()
        end
    end

    print("Currently ".. state)
    return state
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





-- Turtle keeps chopping above itself
function chop()
    while turtle.detectUp() do
        turtle.digUp()
        turtle.up()
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

function replantSapling()
    for i=1, 16 do
        if turtle.getItemDetail(i) ~= nil then
            if turtle.getItemDetail(i).name == "minecraft:sapling" then
                turtle.select(i)
                turtle.place()
            end
        end
    end
end


-- Deposits logs, refuels and replants sapling
function service()
    refuel(60, "minecraft:log")
    depositLogs()
    replantSapling()
end

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
    elseif state == "returning" then
        turtle.back()
    elseif state == "service" then
        service()
    end
end
     