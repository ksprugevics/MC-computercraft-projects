local crypto = require("crypto")

local LOG_FILE = "disk/log1.txt"

local args = { ... }

local function matchEntriesFromFile(filename, UID)
    for entry in io.lines(filename) do
        if entry == UID then 
            return true
        end
    end

    return false
end

local UID = args[1] -- 8895185-17.421-10
print("Note with UID: " .. UID .. " found: " .. tostring(matchEntriesFromFile(LOG_FILE, UID)))
