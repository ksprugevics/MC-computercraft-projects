function drawFilledRectangle(x1, y1, x2, y2, color)
    monitor.setBackgroundColor(color)
    for y=y1, y2 do
        for x=x1, x2 do
            monitor.setCursorPos(x, y)
            monitor.write(" ")
        end
    end
end


monitor = peripheral.find("monitor")
local width, height = monitor.getSize() -- 3x3 monitor => 29 x 19

drawFilledRectangle(1, 1, width, height, colors.red)

