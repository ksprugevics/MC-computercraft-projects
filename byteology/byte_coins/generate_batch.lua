local crypto = require("crypto")
local pu = require("printerutils")

local LOG_FILE = "disk/log1.txt"
local VALID_DENOMINATIONS = {1, 5, 10, 50, 100, 500}

local printer = peripheral.find("printer")
local log = io.open(LOG_FILE, "a+")
local args = { ... }

local function checkIfTableContains(tab, val) 
    for _, v in pairs(tab) do
        if v == val then return true end
    end

    return false
end

local function checkArgs(denomination, count)
    if denomination == nil or not checkIfTableContains(VALID_DENOMINATIONS, denomination) then
        print("INVALID DENOMINATION")
        return false
    end

    if count == nil or count <= 0 or count > 6 then
        print("INVALID COUNT")
        return false
    end

    return true
end

local denomination = tonumber(args[1])
local count = tonumber(args[2])
local ok = checkArgs(denomination, count)
if not ok then return end

print("Printing " .. tostring(count) .. " notes of denomination " .. tostring(denomination))
for i = 1, count do
    note = crypto.generate_note(denomination)
    pu.printMoney(printer, note)

    UID = note.serial_number .. "-" .. note.timestamp .. "-" .. note.denomination
    print(UID)
    log:write(UID .. "\n")
end
