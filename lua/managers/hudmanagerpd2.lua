function HUDManager:make_cards_hud(peer, max_pc, left_card, right_card)
  self._hud_lootscreen:make_cards(peer, left_card, right_card)
end

function HUDManager:make_lootdrop_hud(lootdrop_data)
  log("make_lootdrop_hud")
  self._hud_lootscreen:make_lootdrop(lootdrop_data)
end

function HUDManager:confirm_choose_lootcard(peer_id, card_id)
  self._hud_lootscreen:begin_choose_card(peer_id, card_id)
end
