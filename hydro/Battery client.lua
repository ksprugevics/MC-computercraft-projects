rednet.open("top")
while(true) do

-- Read comparator analog values
local bat1 = redstone.getAnalogInput("left")
local bat2 = redstone.getAnalogInput("back")
local bat3 = redstone.getAnalogInput("right") 

print("Battery 1: " .. bat1)
print("Battery 2: " .. bat2)
print("Battery 3: " .. bat3)

-- Broadcast values with current position as protocol to distinguish monitors
rednet.broadcast(bat1, "Row1Bat1")
rednet.broadcast(bat2, "Row1Bat2")
rednet.broadcast(bat3, "Row1Bat3")
sleep(5)
end
rednet.close("top")