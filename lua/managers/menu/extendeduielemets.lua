-- disables perkdecks from displaying

-- skips displaying items with skip_card flag
local old_add_item = ScrollItemList.add_item
function ScrollItemList:add_item(item, ...)
  if item and item.SKIP_CARD then
    return
  else
    old_add_item(self, item, ...)
  end
end
