function drawFilledRectangle(x1, y1, x2, y2, color)
    monitor.setBackgroundColor(color)
    for y=y1, y2 do
        for x=x1, x2 do
            monitor.setCursorPos(x, y)
            monitor.write(" ")
        end
    end
end

function getCellStatus(minBattery)
    cellsFull = 0
    minBatteryEmpty = false
    maxBatteryFull = false
    if rs.testBundledInput("back", colors.white) then cellsFull = cellsFull + 1 end
    if rs.testBundledInput("back", colors.orange) then 
        cellsFull = cellsFull + 1
        maxBatteryFull = true
    end
    if rs.testBundledInput("back", colors.magenta) then cellsFull = cellsFull + 1 end
    if rs.testBundledInput("back", colors.lightBlue) then cellsFull = cellsFull + 1 end
    if rs.testBundledInput("back", colors.yellow) then cellsFull = cellsFull + 1 end
    if rs.testBundledInput("back", colors.lime) then cellsFull = cellsFull + 1 end
    if rs.testBundledInput("back", colors.pink) then cellsFull = cellsFull + 1 end
    if rs.testBundledInput("back", colors.gray) then
        cellsFull = cellsFull + 1
    else
        minBatteryEmpty = true
    end
    if rs.testBundledInput("back", colors.lightGray) then cellsFull = cellsFull + 1 end

    return cellsFull, minBatteryEmpty, maxBatteryFull
end

function getDieselStatus()
    tank1 = rs.getAnalogInput("bottom")
    tank2 = rs.getAnalogInput("right")
    tank3 = rs.getAnalogInput("left")
    totalDiesel =  TANK_CAPACITY_STEP_MB * tank1 + TANK_CAPACITY_STEP_MB * tank2 + TANK_CAPACITY_STEP_MB * tank3 

    return tank1, tank2, tank3, totalDiesel
end

CELL_COUNT = 9
CELL_CAPACITY_MFE = 4
CELL_CAPACITY_MAX_MFE = 4 * 9

TANK_CAPACITY_MAX_MB = 512000
TANK_CAPACITY_STEP_MB = 34133

monitor = peripheral.find("monitor")
local energyDetector = peripheral.find("energyDetector")
local running = "OFF"
monitor.setTextScale(1)
monitor.setBackgroundColor(colors.blue)

while true do

    cellsFull, minBatteryEmpty, maxBatteryFull  = getCellStatus()
    tank1, tank2, tank3, totalDiesel = getDieselStatus()
    
    if minBatteryEmpty then 
        running = "ON"
        rs.setOutput("front", false)
    elseif maxBatteryFull then 
        running = "OFF"
        rs.setOutput("front", true)
    end

    print("STATUS: " .. running)

    monitor.setBackgroundColor(colors.blue)
    monitor.clear()
    monitor.setCursorPos(29, 1)
    monitor.write("STATUS: ")

    if running == "ON" then
        monitor.setTextColor(colors.green)
    else
        monitor.setTextColor(colors.red)
    end
    monitor.write(running)
    monitor.setTextColor(colors.white)

    monitor.setCursorPos(1, 1)
    monitor.write("Total biodiesel: ")
    if totalDiesel < TANK_CAPACITY_MAX_MB then 
        monitor.setTextColor(colors.red)
    else
        monitor.setTextColor(colors.green)
    end
    monitor.write(tostring(totalDiesel) .. "mB")
    monitor.setTextColor(colors.white)

    monitor.setCursorPos(1, 2)
    monitor.write("Using: " .. tostring(energyDetector.getTransferRate()) .. "FE/t")
    monitor.setCursorPos(25, 4)
    monitor.write(tostring(CELL_CAPACITY_MFE * cellsFull) .. "MFE / " .. tostring(CELL_CAPACITY_MAX_MFE) .. "MFE")

    monitor.setCursorPos(2, 12)
    monitor.write("Tank 1")
    monitor.setCursorPos(9, 12)
    monitor.write("Tank 2")
    monitor.setCursorPos(16, 12)
    monitor.write("Tank 3")

    drawFilledRectangle(2, 4, 7, 11, colors.gray)
    drawFilledRectangle(9, 4, 14, 11, colors.gray)
    drawFilledRectangle(16, 4, 21, 11, colors.gray)
    
    if tank1 ~= 0 then 
        drawFilledRectangle(3, 10 - math.floor(tank1 / 3), 6, 10, colors.orange)
    end
    if tank2 ~= 0 then
        drawFilledRectangle(10, 10 - math.floor(tank2 / 3), 13, 10, colors.orange)
    end
    if tank3 ~= 0 then
        drawFilledRectangle(17, 10 - math.floor(tank3 / 3), 20, 10, colors.orange)
    end

    drawFilledRectangle(23, 5, 37, 10, colors.lightGray)
    drawFilledRectangle(37, 7, 38, 8, colors.lightGray)

    if cellsFull <= 3 then
        drawFilledRectangle(24, 6, 24 + math.floor(1.3 * cellsFull), 9, colors.red)
    elseif cellsFull <= 6 then
        drawFilledRectangle(24, 6, 24 + math.floor(1.3 * cellsFull), 9, colors.yellow)
    else
        drawFilledRectangle(24, 6, 24 + math.floor(1.3 * cellsFull), 9, colors.green)
    end

    sleep(5)
end
