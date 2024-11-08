function HUDManager:make_cards_hud(peer, max_pc, left_card, right_card)
  self._hud_lootscreen:make_cards(peer, left_card, right_card)
end

function HUDManager:make_lootdrop_hud(lootdrop_data)
  self._hud_lootscreen:make_lootdrop(lootdrop_data)
end
