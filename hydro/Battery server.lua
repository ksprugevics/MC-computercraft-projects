-- Average amount of IF for a redstone step (for HV capacitors)
local IFStep = 266666
local monitor = peripheral.wrap("left")
local width, height = monitor.getSize()

rednet.open("back")
while(true) do

print(width .. " " .. height)
monitor.setCursorPos(1, 1)

local row1 = {}
local row1Sum = 0

for i = 1, 6 do
local senderID, message, protocol = rednet.receive("Row1Bat" .. i)
row1[i] = message
monitor.clearLine()
monitor.write("Battery" .. i .. ": " .. message  * IFStep .. " IF")
print("Battery" .. i .. ": " .. message  * IFStep .. " IF")
row1Sum = row1Sum + message * IFStep
monitor.setCursorPos(1, i + 1)
end

print("Row1 Total: ".. row1Sum .. "IF")
monitor.write("Row1 Total: ".. row1Sum .. "IF")

local row2 = {}
local row2Sum = 0
monitor.setCursorPos(1, 9)
for i = 1, 6 do
local senderID, message, protocol = rednet.receive("Row2Bat" .. i)
row2[i] = message
monitor.clearLine()
monitor.write("Battery" .. i .. ": " .. message  * IFStep .. " IF")
print("Battery" .. i .. ": " .. message  * IFStep .. " IF")
row2Sum = row2Sum + message * IFStep
monitor.setCursorPos(1, i + 1 + 8)
end

print("Row2 Total: ".. row2Sum .. "IF")
monitor.write("Row2 Total: ".. row2Sum .. "IF")

local row3 = {}
local row3Sum = 0
monitor.setCursorPos(1, 17)
for i = 1, 6 do
local senderID, message, protocol = rednet.receive("Row3Bat" .. i)
row3[i] = message
monitor.clearLine()
monitor.write("Battery" .. i .. ": " .. message  * IFStep .. " IF")
print("Battery" .. i .. ": " .. message  * IFStep .. " IF")
row3Sum = row3Sum + message * IFStep
monitor.setCursorPos(1, i + 1 + 16)
end

print("Row3 Total: ".. row3Sum .. "IF")
monitor.write("Row3 Total: ".. row3Sum .. "IF")


sleep(5)
end
rednet.close("top")