function HUDLootScreen:make_lootdrop(lootdrop_data)
  local peer = lootdrop_data[1]
  local peer_id = peer and peer:id() or 1
  self._peer_data[peer_id].lootdrops = lootdrop_data
  self._peer_data[peer_id].active = true
  self._peer_data[peer_id].wait_for_lootdrop = nil
  local panel = self._peers_panel:child("peer" .. tostring(peer_id))
  local item_panel = panel:child("item")
  local item_id = lootdrop_data[4]
  local category = lootdrop_data[3]

  if category == "weapon_mods" or category == "weapon_bonus" then
    category = "mods"
  end

  local texture_loaded_clbk = callback(self, self, "texture_loaded_clbk", {
    peer_id,
    category == "textures" and true or false
  })
  local texture_path, rarity_path = nil

  texture_path = "guis/textures/pd2/blackmarket/xp_drop"

  if DB:has(Idstring("texture"), texture_path) then
    TextureCache:request(texture_path, "NORMAL", texture_loaded_clbk, 100)
  else
    Application:error("[HUDLootScreen]", "Texture not in DB", texture_path, peer_id)
    item_panel:rect({
      color = Color.red
    })
  end

  if not self._peer_data[peer_id].wait_for_choice then
    self:begin_flip_card(peer_id)
  end
end
