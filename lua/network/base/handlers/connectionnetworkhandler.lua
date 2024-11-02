function ConnectionNetworkHandler:feed_lootdrop(global_value, item_category, item_id, max_pc, item_pc, left_pc, right_pc,
                                                drop, sender)
  local peer = self._verify_sender(sender)

  if not peer then
    return
  end

  if not managers.hud then
    return
  end

  local global_values = tweak_data.lootdrop.global_value_list_index
  local lootdrop_data = {
    peer,
    global_values[global_value] or "normal",
    item_category,
    item_id,
    max_pc,
    item_pc,
    left_pc,
    right_pc,
    drop
  }

  if item_pc == 0 then
    managers.hud:make_cards_hud(peer, max_pc, left_pc, right_pc)
  else
    managers.hud:make_lootdrop_hud(lootdrop_data)
  end
end
