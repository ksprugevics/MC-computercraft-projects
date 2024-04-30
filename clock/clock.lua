while true do
    local time = os.date("*t")
    local hour = time.hour + 3
    local min = time.min
    
    local hourString = tostring(hour)
    local minString = tostring(min)

    if hour < 10 then hourString = "0" .. hourString end
    if min < 10 then minString = "0" .. minString end

    local hourDig1 = tonumber(string.sub(hourString, 1, 1))
    local hourDig2 = tonumber(string.sub(hourString, 2, 2))
    local minDig1 = tonumber(string.sub(minString, 1, 1))
    local minDig2 = tonumber(string.sub(minString, 2, 2))

    if hourDig1 == 0 then hourDig1 = 10 end
    if hourDig2 == 0 then hourDig2 = 10 end
    if minDig1 == 0 then minDig1 = 10 end
    if minDig2 == 0 then minDig2 = 10 end

    rs.setAnalogOutput("left", hourDig1)
    rs.setAnalogOutput("front", hourDig2)
    rs.setAnalogOutput("right", minDig2)
    rs.setAnalogOutput("top", minDig1)
    
    sleep(10)
end