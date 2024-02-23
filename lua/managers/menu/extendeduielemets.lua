-- disables perkdecks from displaying
local old_add_item = ScrollItemList.add_item
function ScrollItemList:add_item(item, force_visible, at_index)
  if item and item.SKIP_CARD then
    return
  else
    old_add_item(self, item, force_visible, at_index)
  end
end
