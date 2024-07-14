function convertToCoins(bytes)
    local gold_coins = 0
    while bytes >= byte_rate_gold do
        gold_coins = gold_coins + 1
        bytes = bytes - byte_rate_gold
    end
    local silver_coins = 0
    while bytes >= byte_rate_silver do
        silver_coins = silver_coins + 1
        bytes = bytes - byte_rate_silver
    end
    local copper_coins = 0
    while bytes >= byte_rate_copper do
        copper_coins = copper_coins + 1
        bytes = bytes - byte_rate_copper
    end
    return {gold_coins, silver_coins, copper_coins}
end

byte_rate_copper = 10 -- 1 copper coin = 10 byte coins
byte_rate_silver = 90 -- 1 silver coin = 90 byte coins
byte_rate_gold = 810 -- 1 gold coin = 810 byte coins
local args = { ... }
count = 0

if #args == 1 then
    count = tonumber(args[1])

    if count == nil or count <= 0 then
        print("INVALID COUNT")
        return
    end
elseif #args == 5 then
    count = 100 * tonumber(args[1]) + 50 * tonumber(args[2]) + 10 * tonumber(args[3]) + 5 * tonumber(args[4]) + 1 * tonumber(args[5])
end

local conversion = convertToCoins(count)
print(count .." BTC equals to:")
print(conversion[1] .." gold coins")
print(conversion[2] .." silver coins")
print(conversion[3] .." copper coins")
