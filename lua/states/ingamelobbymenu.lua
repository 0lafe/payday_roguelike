function IngameLobbyMenuState:set_lootdrop(drop_category, drop_item_id)
  if self._mass_drop_data then
    if drop_item_id ~= nil then
      self._mass_drop_data.inventory_reward = {
        global_value = managers.blackmarket:get_global_value(drop_category, drop_item_id),
        type_items = drop_category,
        item_entry = drop_item_id
      }
    end

    managers.lootdrop:set_mass_drop(self._mass_drop_data)

    self._mass_drop_data.ready = true

    return
  end

  local global_value, item_category, item_id, max_pc, item_pc = nil
  local allow_loot_drop = true
  allow_loot_drop = not managers.crime_spree:is_active()

  if drop_item_id and drop_category then
    global_value = managers.blackmarket:get_global_value(drop_category, drop_item_id)
    item_category = drop_category
    item_id = drop_item_id
    max_pc = math.max(math.ceil(managers.experience:current_level() / 10), 1)
    item_pc = math.ceil(4)
  elseif allow_loot_drop then
    self._lootdrop_data = {}

    managers.lootdrop:new_make_drop(self._lootdrop_data)

    global_value = self._lootdrop_data.global_value or "normal"
    item_category = self._lootdrop_data.type_items
    item_id = self._lootdrop_data.item_entry
    max_pc = self._lootdrop_data.total_stars
    item_pc = self._lootdrop_data.joker and 0 or math.ceil(self._lootdrop_data.item_payclass / 10)
  end

  local peer = managers.network:session() and managers.network:session():local_peer() or false
  local disable_weapon_mods = not managers.lootdrop:can_drop_weapon_mods() and true or nil
  local card_left_pc = managers.lootdrop:new_fake_loot_pc(nil, {
    weapon_mods = disable_weapon_mods
  })
  local card_right_pc = managers.lootdrop:new_fake_loot_pc(nil, {
    weapon_mods = disable_weapon_mods
  })
  local lootdrop_data = {
    peer,
    global_value,
    item_category,
    item_id,
    max_pc,
    item_pc,
    card_left_pc,
    card_right_pc
  }

  managers.hud:make_lootdrop_hud(lootdrop_data)

  if not Global.game_settings.single_player and managers.network:session() then
    local global_values = tweak_data.lootdrop.global_value_list_map
    local global_index = global_values[global_value] or 1

    managers.network:session():send_to_peers("feed_lootdrop", global_index, item_category, item_id, max_pc, item_pc,
      card_left_pc, card_right_pc)
  end
end
