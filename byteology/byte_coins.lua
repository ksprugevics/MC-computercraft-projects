-- Constants
local LOG_FILE = "disk/log1.txt"

local notes = {}
for i = 1, 5 do
    table.insert(notes, generate_note(100))
    table.insert(notes, generate_note(5))
end

print(notes[1].serial_number)
print(notes[1].timestamp)
print(notes[1].denomination)

local log = io.open(LOG_FILE, "a+")

for k,v in pairs(notes) do
    print(validate_note(v))
    UID = v.serial_number .. "-" .. v.timestamp .. "-" .. v.denomination
    log:write(UID .. "\n")
end


