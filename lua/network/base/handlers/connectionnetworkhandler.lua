function ConnectionNetworkHandler:feed_lootdrop(drop, item_category, item_id, max_pc, item_pc, left_pc, right_pc,
                                                sender)
  Utils.PrintTable(drop, 2)
  Utils.PrintTable(sender, 2)

  local peer
  if sender then
    peer = self._verify_sender(sender)
  end

  if not peer then
    return
  end

  if not managers.hud then
    return
  end

  local global_values = tweak_data.lootdrop.global_value_list_index
  local lootdrop_data = {
    peer,
    "normal",
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
