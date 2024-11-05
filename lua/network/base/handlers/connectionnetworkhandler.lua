function ConnectionNetworkHandler:feed_lootdrop(card_left_pc, card_right_pc, drop_name, _, _, _, _, sender)
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

  managers.hud:make_cards_hud(peer, 10, card_left_pc, card_right_pc)
end
