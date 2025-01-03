function ConnectionNetworkHandler:feed_lootdrop(card_left_pc, card_right_pc, drop_name, sender)
  local peer = self._verify_sender(sender)

  if not peer then
    return
  end

  if not managers.hud then
    return
  end

  local lootdrop_data = {
    peer,
    card_left_pc,
    card_right_pc,
    drop_name
  }

  if drop_name == "" then
    managers.hud:make_cards_hud(peer, 10, card_left_pc, card_right_pc)
  else
    managers.hud:make_lootdrop_hud(lootdrop_data)
  end
end
