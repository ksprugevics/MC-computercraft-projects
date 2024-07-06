function drawFilledRectangle(x1, y1, x2, y2, color)
    monitor.setBackgroundColor(color)
    for y=y1, y2 do
        for x=x1, x2 do
            monitor.setCursorPos(x, y)
            monitor.write(" ")
        end
    end
end


-- Array of colors
local color_tab = {colors.white, colors.orange, colors.magenta, colors.lightBlue, colors.yellow, colors.pink, colors.cyan, colors.purple, colors.green, colors.red, colors.blue}

-- Find monitor peripheral
monitor = peripheral.find("monitor")
print(monitor.getSize())

-- 18x12 monitor size
local monitorWidth, monitorHeight = 80, 80

-- Define number of rows and columns
local rows = 20
local cols = 11

-- Calculate width and height of each rectangle
local rectWidth = math.floor(monitorWidth / cols)
local rectHeight = math.floor(monitorHeight / rows)

while true do
    monitor.clear()

    -- Draw 4x4 grid of rectangles
    for row = 0, rows - 1 do
        for col = 0, cols - 1 do
            local x1 = col * rectWidth
            local y1 = row * rectHeight
            local x2 = x1 + rectWidth - 1
            local y2 = y1 + rectHeight - 1
            drawFilledRectangle(x1, y1, x2, y2, color_tab[math.random(#color_tab)])
        end
    end

    sleep(0.75)
end
