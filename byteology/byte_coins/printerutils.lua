local printerutils = {}
local PAGE_WIDTH = 25
local PAGE_HEIGHT = 21
local BG_CHAR = string.char(127)

function printerutils.centerText(printer, text, y)
    local textLength = #text
    
    -- Calculate the starting x position to center the text
    local startX = math.floor((PAGE_WIDTH - textLength) / 2) + 1
    
    -- Set the cursor position to start writing centered text
    printer.setCursorPos(startX, y)
    printer.write(text)
end

function printerutils.printCircleOutlineWithText(printer, radius, text)
    local centerX = math.floor(PAGE_WIDTH / 2) + 1  -- Center of the page width (1-indexed)
    local centerY = math.floor(PAGE_HEIGHT / 2) + 1 -- Center of the page height (1-indexed)
    
    -- Function to draw the circle outline
    for y = -radius, radius do
        for x = -radius, radius do
            local distance = math.sqrt(x * x + y * y)
            if distance >= radius - 0.5 and distance <= radius + 0.5 then
                local drawX = centerX + x
                local drawY = centerY + y
                if drawX >= 1 and drawX <= PAGE_WIDTH and drawY >= 1 and drawY <= PAGE_HEIGHT then
                    printer.setCursorPos(drawX, drawY)
                    printer.write(BG_CHAR)
                end
            end
        end
    end
    
    -- Function to write the text in the middle of the circle
    local textLength = #text
    local textStartX = centerX - math.floor(textLength / 2)
    local textStartY = centerY
    
    printer.setCursorPos(textStartX, textStartY)
    printer.write(text)
end

function printerutils.printCircleOutlineWithTextUp(printer, radius, text)
    local centerX = math.floor(PAGE_WIDTH / 2) + 1  -- Center of the page width (1-indexed)
    local centerY = -16
    
    -- Function to draw the circle outline
    for y = -radius, radius do
        for x = -radius, radius do
            local distance = math.sqrt(x * x + y * y)
            if distance >= radius - 0.5 and distance <= radius + 0.5 then
                local drawX = centerX + x
                local drawY = centerY + y
                if drawX >= 1 and drawX <= PAGE_WIDTH and drawY >= 1 and drawY <= PAGE_HEIGHT then
                    printer.setCursorPos(drawX, drawY)
                    printer.write(BG_CHAR)
                end
            end
        end
    end
    
    -- Function to write the text in the middle of the circle
    local textLength = #text
    local textStartX = centerX - math.floor(textLength / 2)
    local textStartY = centerY
    
    printer.setCursorPos(textStartX, textStartY)
    printer.write(text)
end

function printerutils.printCircleOutlineWithTextDown(printer, radius, text)
    local centerX = math.floor(PAGE_WIDTH / 2) + 1  -- Center of the page width (1-indexed)
    local centerY = PAGE_HEIGHT + 17
    
    -- Function to draw the circle outline
    for y = -radius, radius do
        for x = -radius, radius do
            local distance = math.sqrt(x * x + y * y)
            if distance >= radius - 0.5 and distance <= radius + 0.5 then
                local drawX = centerX + x
                local drawY = centerY + y
                if drawX >= 1 and drawX <= PAGE_WIDTH and drawY >= 1 and drawY <= PAGE_HEIGHT then
                    printer.setCursorPos(drawX, drawY)
                    printer.write(BG_CHAR)
                end
            end
        end
    end
    
    -- Function to write the text in the middle of the circle
    local textLength = #text
    local textStartX = centerX - math.floor(textLength / 2)
    local textStartY = centerY
    
    printer.setCursorPos(textStartX, textStartY)
    printer.write(text)
end

function printerutils.printMoney(printer, note)
    local denomination = tostring(note.denomination)
    local UID = note.serial_number .. "-" .. note.timestamp .. "-" .. denomination
    
    printer.newPage()
    printer.setPageTitle(denomination .. " BYTE COINS")
    printerutils.printCircleOutlineWithText(printer, 4, denomination)
    printerutils.printCircleOutlineWithTextUp(printer, 20, denomination)
    printerutils.printCircleOutlineWithTextDown(printer, 20, denomination) 
    
    printerutils.centerText(printer, note.denomination .. " BYTE COINS", 1)
    printerutils.centerText(printer, UID, 21)
    
    printer.setCursorPos(2, math.floor(21 / 2) + 1)
    printer.write("BYTE")
    printer.setCursorPos(20, math.floor(21 / 2) + 1)
    printer.write("COINS")
    printer.endPage()
end

return printerutils
