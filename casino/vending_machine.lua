local mon = peripheral.wrap("back")
local w, h = mon.getSize()

local credits = 0
local userOrder = -1

Food = {}
Food[1] = {18, "BBQ chips"}
Food[2] = {18, "Deviled Egg"}
Food[3] = {5, "Pizza Slice"}
Food[4] = {13, "Creeper Cookie"}
Food[5] = {8, "Strawberry MS"}
Food[6] = {15, "Root Beer Float"}
Food[7] = {13, "Energy Drink"}
Food[8] = {8, "Cherry soda"}


function Vending()
    DrawProcessingMessage()
    sleep(1)
    if turtle.getItemCount(userOrder) <= 1 then
        DrawErrorMessage("Item is out of stock!")
    elseif credits < Food[userOrder][1] then
        DrawErrorMessage("Insufficient funds!")
    else
        turtle.select(9)
        turtle.dropUp(Food[userOrder][1])
        turtle.select(userOrder)
        turtle.drop(1)
        DrawOkMessage()
    end
    turtle.select(9)
    turtle.drop()
    sleep(3)
    return -1
end

-- Functions for drawing -- 
function DrawOkMessage()    
    DrawFilledRectangle(1, 2, w, 5, colors.green)
    mon.setCursorPos(5, 3)
    mon.write("Transaction complete!")
    mon.setCursorPos(9, 4)
    mon.write("Returning: " .. turtle.getItemCount(9))
end

function DrawErrorMessage(text)    
    DrawFilledRectangle(1, 2, w, 5, colors.red)
    mon.setCursorPos(6, 3)
    mon.write(text)
    mon.setCursorPos(9, 4)
    mon.write("Returning: " .. turtle.getItemCount(9))
end

function DrawIdleMessage()    
    DrawFilledRectangle(1, 2, w, 5, colors.lightGray)
    mon.setCursorPos(6, 3)
    mon.write("Waiting for order..")
end

function DrawProcessingMessage()
    DrawFilledRectangle(1, 2, w, 5, colors.orange)
    mon.setCursorPos(6, 3)
    mon.write("Processing order...")
end

function DrawFilledRectangle(x1, y1, x2, y2, color)
    mon.setBackgroundColor(color)
    for y=y1, y2 do
        for x=x1, x2 do
            mon.setCursorPos(x, y)
            mon.write(" ")
        end
    end
end

function DrawHeader()
    DrawFilledRectangle(1, 1, w, 1, colors.purple)
    mon.setCursorPos(1, 1)
    mon.write("Vending Machine")
    mon.setCursorPos(19, 1)
    mon.write("Credits: " .. credits)
end


-- Script starts here
mon.clear()
DrawHeader()
DrawIdleMessage()

while true do
    local newCredits = turtle.getItemCount(9)

    -- Update header when credits change
    if newCredits ~= credits then
        credits = newCredits
        DrawHeader()
    end

    if credits > 0 then
        if rs.testBundledInput("left", colors.red) then userOrder = 1
        elseif rs.testBundledInput("left", colors.green) then userOrder = 2
        elseif rs.testBundledInput("left", colors.blue) then userOrder = 3
        elseif rs.testBundledInput("left", colors.white) then userOrder = 4
        elseif rs.testBundledInput("right", colors.red) then userOrder = 5
        elseif rs.testBundledInput("right", colors.green) then userOrder = 6
        elseif rs.testBundledInput("right", colors.blue) then userOrder = 7
        elseif rs.testBundledInput("right", colors.white) then userOrder = 8
        end

        if userOrder ~= -1 then
            Vending()
            userOrder = -1
            DrawIdleMessage()
        end
    end
    sleep(0.5)
end
