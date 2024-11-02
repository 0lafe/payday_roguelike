function IngameLobbyMenuState:set_lootdrop()
  local global_value, item_category, item_id, max_pc, item_pc = nil

  global_value = "armored_transport"
  item_category = "weapon_mods"
  item_id = "wpn_fps_smg_m45_s_folded"
  max_pc = 10
  item_pc = 0

  local peer = managers.network:session() and managers.network:session():local_peer() or false
  local disable_weapon_mods = not managers.lootdrop:can_drop_weapon_mods() and true or nil
  local card_left_pc = managers.lootdrop:new_fake_loot_pc(nil, {
    weapon_mods = disable_weapon_mods
  })
  local card_right_pc = managers.lootdrop:new_fake_loot_pc(nil, {
    weapon_mods = disable_weapon_mods
  })

  local drops = tweak_data.roguelike.lootdrop_table
  local drop = drops[math.random(#drops)]
  local lootdrop_data = {
    peer,
    global_value,
    item_category,
    item_id,
    max_pc,
    item_pc,
    card_left_pc,
    card_right_pc,
    drop
  }

  managers.hud:make_lootdrop_hud(lootdrop_data)

  if not Global.game_settings.single_player and managers.network:session() then
    local global_values = tweak_data.lootdrop.global_value_list_map
    local global_index = global_values[global_value] or 1

    managers.network:session():send_to_peers("feed_lootdrop", global_index, item_category, item_id, max_pc, item_pc,
      card_left_pc, card_right_pc, drop)
  end
end
