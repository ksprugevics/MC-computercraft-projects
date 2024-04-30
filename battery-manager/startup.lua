lastSignal = -1
while true do
    newSignal = redstone.getAnalogInput("back")
    if newSignal ~= lastSignal and newSignal == 0 then
        redstone.setOutput("left", true)
        sleep(1)
        redstone.setOutput("left", false)
    end
    lastSignal = newSignal
    sleep(5)
end