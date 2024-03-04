-- disables perkdecks from displaying
local old_init = SpecializationListItem.init
function SpecializationListItem:init(parent, panel_data, info_data)
  if info_data and info_data.spec_data and info_data.spec_id then
    local tier = managers.skilltree:get_specialization_value(info_data.spec_id, "tiers", "current_tier")
    if tier and tier < 9 then
      self.SKIP_CARD = true
      return
    end
  end
  old_init(self, parent, panel_data, info_data)
end
