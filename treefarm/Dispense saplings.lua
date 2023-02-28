-- 06.06.2021.
-- Dispenses saplings into dispenser when a given amount is in its inventory

function dispenseSaplings()
    for i=1, 16 do
        if turtle.getItemDetail(i) ~= nil then
            if turtle.getItemDetail(i).name == "minecraft:sapling" then
                turtle.select(i)
                if turtle.getItemCount() >= 4 then 
                    turtle.drop()
                end
            end
        end
    end
end

while true do
    dispenseSaplings()
    sleep(240)
end