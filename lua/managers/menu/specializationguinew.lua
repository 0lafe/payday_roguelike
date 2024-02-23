-- disables perkdecks from displaying
local old_init = SpecializationListItem.init
function SpecializationListItem:init(parent, panel_data, info_data)
  if info_data and info_data.spec_data and info_data.spec_id then
    local spec_data = info_data.spec_data
    if spec_data[1] and spec_data[1].name_id and spec_data[1].name_id ~= "menu_deck23_1" then
      self.SKIP_CARD = true
      return
    end
  end
  old_init(self, parent, panel_data, info_data)
end
