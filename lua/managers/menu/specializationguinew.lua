-- disables perkdecks from displaying

local function any_decks_unlocked()
  local rtn = false
  for i = 1, 23 do
    local tier = managers.skilltree:get_specialization_value(i, "tiers", "current_tier")
    if tier > 1 then
      rtn = true
    end
  end
  return rtn
end

local old_init = SpecializationListItem.init
function SpecializationListItem:init(parent, panel_data, info_data)
  if info_data and info_data.spec_data and info_data.spec_id then
    local tier = managers.skilltree:get_specialization_value(info_data.spec_id, "tiers", "current_tier")
    if tier and tier < 2 and any_decks_unlocked() then
      self.SKIP_CARD = true
      return
    end
  end
  old_init(self, parent, panel_data, info_data)
end
