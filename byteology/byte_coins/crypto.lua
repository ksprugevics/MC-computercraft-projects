local MODULUS = 1000000007
local SECRET_KEY = "KA34AIU2394A234L2I43"

local crypto = {}

-- Custom hash function
function crypto.custom_hash(input_str)
    local hash_value = 0
    local multiplier = 31
    for i = 1, #input_str do
        local char = string.byte(input_str, i)
        hash_value = (hash_value * multiplier + char) % MODULUS
    end
    return tostring(hash_value)
end

-- Function to generate a note
function crypto.generate_note(denomination)
    local serial_number = tostring(math.random(1000000, 9999999))
    local timestamp = tostring(os.time())
    local data = serial_number .. timestamp .. SECRET_KEY .. tostring(denomination)
    local signature = crypto.custom_hash(data)
    
    local note = {
        serial_number = serial_number,
        timestamp = timestamp,
        denomination = denomination,
        signature = signature
    }
    
    return note
end

-- Function to validate a note
function crypto.validate_note(note)
    local data = note.serial_number .. note.timestamp .. SECRET_KEY .. tostring(note.denomination)
    local signature = crypto.custom_hash(data)
    
    return signature == note.signature
end

return crypto
