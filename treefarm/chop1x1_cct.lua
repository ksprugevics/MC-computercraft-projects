function checkState()
    local state = ""

    if compareBlock("forward", SAPLING_BLOCK) then
        state = "idle"
    elseif not blockExists("up") and not blockExists("down") then
        state = "descending"
    elseif compareBlock("forward", WOOD_BLOCK) or compareBlock("up", LEAF_BLOCK) then
        state = "chopping"
    end

    print("Currently ".. state)
    return state
end

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

function idle()
    local waiting = true 
    while waiting do
        sleep(DELAY)
        if not compareBlock("forward", SAPLING_BLOCK) then
            waiting = false
        end
    end
end

function descend()
    while not turtle.detectDown() do
        turtle.down()
    end
end

function chop()
    while turtle.detectUp() or turtle.detect() do
        turtle.dig()
        turtle.digUp()
        turtle.up()
    end
end

function refuel(threshold)
    if turtle.getFuelLevel() < threshold then
        for i=1, 16 do
            if turtle.getItemDetail(i) ~= nil then
                if turtle.getItemDetail(i).name == WOOD_BLOCK then
                    turtle.select(i)
                    turtle.refuel()
                end
            end
        end
    end
end

function depositLogs()
    for i=1, 16 do
        if turtle.getItemDetail(i) ~= nil then
            if turtle.getItemDetail(i).name == WOOD_BLOCK then
                turtle.select(i)
                turtle.dropDown()
            end
        end
    end
end

SAPLING_BLOCK = "minecraft:birch_sapling"
LEAF_BLOCK    = "minecraft:birch_leaves"
WOOD_BLOCK    = "minecraft:birch_log"
DELAY = 5

while true do

    local state = checkState()

    if state == "idle" then
        idle()
    elseif state == "descending" then
        descend()
        redstone.setOutput("back", true)
        sleep(1)
        redstone.setOutput("back", false)
        refuel(500)
        print("Depositing logs: ")
        depositLogs()
        print("Returning to idle mode.")
    elseif state == "chopping" then
        chop()
    end
end