function IngameLobbyMenuState:set_lootdrop()
  local peer = managers.network:session() and managers.network:session():local_peer() or false
  local disable_weapon_mods = not managers.lootdrop:can_drop_weapon_mods() and true or nil
  local card_left_pc = managers.lootdrop:new_fake_loot_pc(nil, {
    weapon_mods = disable_weapon_mods
  })
  local card_right_pc = managers.lootdrop:new_fake_loot_pc(nil, {
    weapon_mods = disable_weapon_mods
  })

  local drop = managers.roguelike:handle_lootdrop()
  local drop_name = drop.name

  local lootdrop_data = {
    peer,
    card_left_pc,
    card_right_pc,
    drop_name
  }

  managers.hud:make_lootdrop_hud(lootdrop_data)

  -- if not Global.game_settings.single_player and managers.network:session() then
  --   managers.network:session():send_to_peers("feed_lootdrop", card_left_pc, card_right_pc, drop_name)
  -- end
end
