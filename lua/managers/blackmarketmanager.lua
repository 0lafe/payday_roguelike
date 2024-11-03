-- unlocks all weapons by level and sidejobs
function BlackMarketManager:weapon_unlocked_by_crafted(category, slot)
  return true
end

-- Gets the first free mask slot in your inventory
function BlackMarketManager:_get_free_mask_slot()
  if not self._global.crafted_items["masks"] then
    return 1
  end

  local max_items = tweak_data.gui.MAX_MASK_SLOTS or 72

  for i = 1, max_items do
    if not self._global.crafted_items["masks"][i] then
      return i
    end
  end
end
