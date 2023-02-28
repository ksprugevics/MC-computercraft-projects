-- remove this line for disabling process termination
--os.pullEvent = os.pullEventRaw

local counter = 0
while true do
    term.clear()
    term.setCursorPos(1, 1)
    term.setTextColor(colors.white)
    print("Enter password: ")
    local input = read("*")
    if input == "abols123" then
        term.setTextColor(colors.green)
        print("Password correct!")
        redstone.setOutput("bottom", true)
        sleep(5)
        redstone.setOutput("bottom", false)
    else
        term.setTextColor(colors.red)
        print("Password incorrect!")
        sleep(2)
    end
end