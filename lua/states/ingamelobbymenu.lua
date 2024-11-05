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

  if not Global.game_settings.single_player and managers.network:session() then
    managers.network:session():send_to_peers("feed_lootdrop", card_left_pc, card_right_pc, drop_name)
  end
end

function IngameLobbyMenuState:make_lootdrop()
  self._mass_drop_data = nil
  local mass_drop_class = self:get_mass_drop_class()

  if mass_drop_class then
    self._mass_drop_data = mass_drop_class:get_mass_drop_data() or {}
    self._mass_drop_data.ready = false
  end

  if self._mass_drop_data then
    local amount_cards = managers.lootdrop:get_amount_mass_drop(self._mass_drop_data)

    managers.hud:make_skirmish_cards_hud(managers.network:session() and managers.network:session():local_peer(),
      amount_cards)

    if not Global.game_settings.single_player and managers.network:session() then
      managers.network:session():send_to_peers("make_lootdrop_skirmish", amount_cards)
    end
  else
    local max_pc = managers.experience:level_to_stars()
    local disable_weapon_mods = not managers.lootdrop:can_drop_weapon_mods() and true or nil
    local card_left_pc = managers.lootdrop:new_fake_loot_pc(nil, {
      weapon_mods = disable_weapon_mods
    })
    local card_right_pc = managers.lootdrop:new_fake_loot_pc(nil, {
      weapon_mods = disable_weapon_mods
    })

    managers.hud:make_cards_hud(managers.network:session() and managers.network:session():local_peer(), max_pc,
      card_left_pc, card_right_pc)

    if not Global.game_settings.single_player and managers.network:session() then
      managers.network:session():send_to_peers("feed_lootdrop", card_left_pc, card_right_pc, "xp")
    end
  end

  self:_set_lootdrop()
end
