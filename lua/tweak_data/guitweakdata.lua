-- Remove certain items from crimenet sidebar
local items_to_remove = {
  menu_cn_short = true,
  menu_cn_chill = true,
  menu_cn_premium_buy = true,
  menu_cn_side_jobs = true,
  cn_crime_spree = true,
  menu_cn_skirmish = true,
  menu_cn_leakedrecording_separator = true,
  menu_cn_leakedrecording = true,
}

Hooks:PostHook(GuiTweakData, "init", "remove_criment_sidebar", function(self, tweak_data)
  local new_sidebar = {}
  for _, v in pairs(self.crime_net.sidebar) do
    if not items_to_remove[v.name_id] then
      table.insert(new_sidebar, v)
    end
  end
  self.crime_net.sidebar = new_sidebar
end)
