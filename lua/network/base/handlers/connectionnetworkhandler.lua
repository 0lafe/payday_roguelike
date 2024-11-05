function ConnectionNetworkHandler:feed_lootdrop(card_left_pc, card_right_pc, _, _, _, _, _, sender)
  local peer = self._verify_sender(sender)

  if not peer then
    return
  end

  if not managers.hud then
    return
  end

  managers.hud:make_cards_hud(peer, 10, card_left_pc, card_right_pc)
end
