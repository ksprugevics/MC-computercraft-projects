local PAGE_WIDTH = 25
local PAGE_HEIGHT = 21

function centerText(printer, text, y)
    local textLength = #text
    
    -- Calculate the starting x position to center the text
    local startX = math.floor((PAGE_WIDTH - textLength) / 2) + 1
    
    -- Set the cursor position to start writing centered text
    printer.setCursorPos(startX, y)
    printer.write(text)
end

local pr = peripheral.find("printer")

pr.newPage()
pr.setPageTitle("Receipt")
centerText(pr, "==Porsche==", 1)
pr.setCursorPos(1, 4)
pr.write("Owner: ComradeJonny")
pr.setCursorPos(1, 6)
pr.write("Model: 980")
pr.setCursorPos(1, 7)
pr.write("Price: 250 BTC")

pr.setCursorPos(1, 9)
pr.write("Extra: DMD engine")
pr.setCursorPos(1, 10)
pr.write("Price: 50 BTC")

-- pr.setCursorPos(1, 9)
-- pr.write("Accesories: piekabe")
-- pr.setCursorPos(1, 10)
-- pr.write("Price: 23 BTC")

pr.setCursorPos(1, 12)
pr.write("TOTAL: 300 BTC")

pr.setCursorPos(1, 13)
pr.write("-------------------------")

pr.setCursorPos(1, 16)
pr.write("Date: 09.07.2024.")
pr.setCursorPos(1, 17)
pr.write("Salesman: silly_raf")

pr.setCursorPos(1, 20)
pr.write("Porsche dealership")
pr.setCursorPos(1, 21)
pr.write("Bankas iela 2")
pr.endPage()