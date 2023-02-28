-- 12.06.2021.
-- Passes saplings back to chopper, drops logs down.

function manageInventory()
    for i=1, 16 do
        if turtle.getItemDetail(i) ~= nil then
            if turtle.getItemDetail(i).name == "minecraft:sapling" then
                turtle.select(i)
                turtle.dropUp()
            elseif turtle.getItemDetail(i).name == "minecraft:log" then
                turtle.select(i)
                turtle.dropDown()
            end
        end
    end
end

while true do
    manageInventory()
    sleep(120)
end
