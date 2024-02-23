-- removes the ability to purchase weapons
function BlackMarketGui:choose_weapon_buy_callback(data)
end

-- Allows all weapons to be used at level 0
-- for level, level_data in pairs(tweak_data.upgrades.level_tree) do
--   if level_data.name_id == "weapons" then
--     for _, upgrade in pairs(level_data.upgrades) do
--       table.insert(tweak_data.upgrades.level_tree[0].upgrades, upgrade)
--     end
--     tweak_data.upgrades.level_tree[level] = { upgrades = {}, name_id = "weapons" }
--   end
-- end
