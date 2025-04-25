-- gets the texture path of a random mask
local function _get_random_mask_texture()
  local masks = tweak_data.blackmarket.masks
  local mask_keys = {}
  for k, v in pairs(masks) do
    if not v.inaccessible then
      table.insert(mask_keys, k)
    end
  end
  local guis_mask_id = mask_keys[math.random(#mask_keys)]
  local mask = masks[guis_mask_id]
  local guis_catalog = "guis/"
  local bundle_folder = mask and mask.texture_bundle_folder
  if bundle_folder then
    guis_catalog = guis_catalog .. "dlcs/" .. tostring(bundle_folder) .. "/"
  end
  if mask.guis_id then
    guis_mask_id = mask.guis_id
  end

  return guis_catalog .. "textures/pd2/blackmarket/icons/masks/" .. guis_mask_id
end

-- maps rarity to color value
local rarity_colors = {
  common = tweak_data.economy.rarities.common.color,
  uncommon = tweak_data.economy.rarities.uncommon.color,
  rare = tweak_data.economy.rarities.rare.color,
  epic = tweak_data.economy.rarities.epic.color,
  legendary = tweak_data.economy.rarities.legendary.color
}

-- returns color value for a given drop type
local function _get_rarity_color(reward)
  local mappings = {
    masks = "common",
    mods = "uncommon",
    xp = "rare",
    weapons = "epic",
    perk_deck = "legendary"
  }

  local test = mappings[reward]
  return rarity_colors[test]
end

function HUDLootScreen:make_lootdrop(lootdrop_data)
  local peer = lootdrop_data[1]
  local peer_id = peer and peer:id() or 1
  self._peer_data[peer_id].lootdrops = lootdrop_data
  self._peer_data[peer_id].active = true
  self._peer_data[peer_id].wait_for_lootdrop = nil
  local panel = self._peers_panel:child("peer" .. tostring(peer_id))
  local item_panel = panel:child("item")
  local drop_name = lootdrop_data[4]
  local drop_meta = lootdrop_data[5]

  local texture_loaded_clbk = callback(self, self, "texture_loaded_clbk", {
    peer_id,
    drop_name,
    drop_meta
  })
  local texture_path = nil

  if drop_name == "xp" then
    texture_path = "guis/textures/pd2/blackmarket/xp_drop"
  elseif drop_name == "masks" then
    texture_path = _get_random_mask_texture()
  elseif drop_name == "mods" then
    texture_path = "guis/textures/pd2/icon_modbox_df"
  elseif drop_name == "weapons" then
    texture_path = managers.blackmarket:get_weapon_icon_path(tweak_data.roguelike.all_weapon_keys
      [math.random(#tweak_data.roguelike.all_weapon_keys)]
    )
  elseif drop_name == "perk_deck" then
    local specialization_data = tweak_data.skilltree.specializations[drop_meta]
    local tier_data = specialization_data[9]
    local guis_catalog = "guis/"
    if tier_data.texture_bundle_folder then
      guis_catalog = guis_catalog .. "dlcs/" .. tostring(tier_data.texture_bundle_folder) .. "/"
    end
    texture_path = guis_catalog .. "textures/pd2/specialization/icons_atlas"
    self._peer_data[peer_id].effects = {
      show_wait = "lootdrop_safe_drop_show_wait",
      show_item = "lootdrop_safe_drop_show_item",
      flip_card = "lootdrop_safe_drop_flip_card"
    }
  end

  if DB:has(Idstring("texture"), texture_path) then
    TextureCache:request(texture_path, "NORMAL", texture_loaded_clbk, 100)
  else
    item_panel:rect({
      color = Color.red
    })
  end

  if not self._peer_data[peer_id].wait_for_choice then
    self:begin_flip_card(peer_id)
  end
end

function HUDLootScreen:texture_loaded_clbk(params, texture_idstring)
  if not alive(self._peers_panel) then
    TextureCache:unretrieve(texture_idstring)

    return
  end

  local peer_id = params[1]
  local drop_name = params[2]
  local drop_meta = params[3]
  local panel = self._peers_panel:child("peer" .. tostring(peer_id)):child("item")
  local item

  if drop_name == "perk_deck" then
    local specialization_data = tweak_data.skilltree.specializations[drop_meta]
    local tier_data = specialization_data[9]
    local texture_rect_x = tier_data.icon_xy and tier_data.icon_xy[1] or 0
    local texture_rect_y = tier_data.icon_xy and tier_data.icon_xy[2] or 0
    local texture_rect = {
      texture_rect_x * 64,
      texture_rect_y * 64,
      64,
      64
    }

    item = panel:bitmap({
      blend_mode = "normal",
      layer = 1,
      texture = texture_idstring,
      texture_rect = texture_rect
    })
  else
    item = panel:bitmap({
      blend_mode = "normal",
      layer = 1,
      texture = texture_idstring
    })
  end
  TextureCache:unretrieve(texture_idstring)

  local texture_width = item:texture_width()
  local texture_height = item:texture_height()
  local panel_width = 100
  local panel_height = 100

  if texture_width == 0 or texture_height == 0 or panel_width == 0 or panel_height == 0 then
    panel:remove(item)

    local rect = panel:rect({
      blend_mode = "add",
      w = 100,
      h = 100,
      rotation = 360,
      color = Color.red
    })

    rect:set_center(panel:w() * 0.5, panel:h() * 0.5)

    return
  end

  local s = math.min(texture_width, texture_height)
  local dw = texture_width / s
  local dh = texture_height / s

  if drop_name == "perk_deck" then
    item:set_size(panel_width, panel_height)
  else
    item:set_size(math.round(dw * panel_width), math.round(dh * panel_height))
  end
  item:set_rotation(360)
  item:set_center(panel:w() * 0.5, panel:h() * 0.5)

  if self._need_item and self._need_item[peer_id] then
    self._need_item[peer_id] = false

    self:show_item(peer_id)
  end
end

function HUDLootScreen:flipcard(card_panel, timer, done_clbk, peer_id, effects)
  local downcard = card_panel:child("downcard")
  local upcard = card_panel:child("upcard")
  local bg = card_panel:child("bg")
  effects = effects or {}

  downcard:set_valign("scale")
  downcard:set_halign("scale")
  upcard:set_valign("scale")
  upcard:set_halign("scale")
  bg:set_valign("scale")
  bg:set_halign("scale")

  local start_rot = downcard:rotation()
  local start_w = downcard:w()
  local cx, cy = downcard:center()

  card_panel:set_alpha(1)
  downcard:show()
  upcard:hide()

  local start_rotation = downcard:rotation()
  local end_rotation = start_rotation * -1
  local diff = end_rotation - start_rotation

  bg:set_rotation(downcard:rotation())
  bg:set_shape(downcard:shape())

  if effects.flip_wait then
    local func = SimpleGUIEffectSpewer[effects.flip_wait]

    if func then
      func(card_panel)
    end
  end

  wait(0.5)

  if effects.flip_card then
    local func = SimpleGUIEffectSpewer[effects.flip_card]

    if func then
      func(card_panel)
    end
  end

  managers.menu_component:post_event("loot_flip_card")
  over(0.25, function(p)
    downcard:set_rotation(start_rotation + math.sin(p * 45) * diff)

    if downcard:rotation() == 0 then
      downcard:set_rotation(360)
    end

    downcard:set_w(start_w * math.cos(p * 90))
    downcard:set_center(cx, cy)
    bg:set_rotation(downcard:rotation())
    bg:set_shape(downcard:shape())
  end)
  upcard:set_shape(downcard:shape())
  upcard:set_rotation(downcard:rotation())

  start_rotation = upcard:rotation()
  diff = end_rotation - start_rotation

  bg:set_color(Color.black)
  bg:set_rotation(upcard:rotation())
  bg:set_shape(upcard:shape())
  downcard:hide()
  upcard:show()
  over(0.25, function(p)
    upcard:set_rotation(start_rotation + math.sin(p * 45 + 45) * diff)

    if upcard:rotation() == 0 then
      upcard:set_rotation(360)
    end

    upcard:set_w(start_w * math.sin(p * 90))
    upcard:set_center(cx, cy)
    bg:set_rotation(upcard:rotation())
    bg:set_shape(upcard:shape())
  end)

  local extra_time = 0

  if effects.show_wait then
    local func = SimpleGUIEffectSpewer[effects.show_wait]

    if func then
      func(card_panel)
    end
  end

  wait(timer - 1.5 + extra_time)

  if effects.show_item then
    local func = SimpleGUIEffectSpewer[effects.show_item]

    if func then
      func(card_panel)
    end
  end

  if not done_clbk then
    managers.menu_component:post_event("loot_fold_cards")
  end

  over(0.25, function(p)
    card_panel:set_alpha(math.cos(p * 45))
  end)

  if done_clbk then
    done_clbk(peer_id)
  end

  local cx, cy = card_panel:center()
  local w, h = card_panel:size()

  over(0.25, function(p)
    card_panel:set_alpha(math.cos(p * 45 + 45))
    card_panel:set_size(w * math.cos(p * 90), h * math.cos(p * 90))
    card_panel:set_center(cx, cy)
  end)
end

function HUDLootScreen:make_cards(peer, max_pc, left_card, right_card)
  if not self:is_active() then
    self:show()
  end

  local peer_id = peer and peer:id() or 1
  local is_local_peer = self:get_local_peer_id() == peer_id
  local peer_name_string = is_local_peer and
      tostring(managers.network.account:username() or managers.blackmarket:get_preferred_character_real_name()) or
      peer and peer:name() or ""
  local player_level = is_local_peer and managers.experience:current_level() or peer and peer:level()
  local player_rank = is_local_peer and managers.experience:current_rank() or peer and peer:rank() or 0
  self._peer_data[peer_id].lootdrops = {
    [2] = left_card,
    [3] = right_card
  }
  self._peer_data[peer_id].active = true
  local panel = self._peers_panel:child("peer" .. tostring(peer_id))
  local peer_info_panel = panel:child("peer_info")
  local peer_name = peer_info_panel:child("peer_name")

  if player_level then
    local color_range_offset = utf8.len(peer_name_string) + 2
    local experience, color_ranges = managers.experience:gui_string(player_level, player_rank, color_range_offset)

    peer_name:set_text(peer_name_string .. " (" .. experience .. ")")

    for _, color_range in ipairs(color_ranges or {}) do
      peer_name:set_range_color(color_range.start, color_range.stop, color_range.color)
    end
  else
    peer_name:set_text(peer_name_string)
  end

  self:make_fine_text(peer_name)
  peer_name:set_right(peer_info_panel:w())

  if player_level then
    local peer_infamy = peer_info_panel:child("peer_infamy")
    local infamy_texture, infamy_texture_rect = managers.experience:rank_icon_data(player_rank)

    if infamy_texture then
      local x, y, w, h = unpack(infamy_texture_rect)

      peer_infamy:set_image(infamy_texture, x, y, w, h)
    end

    peer_infamy:set_visible(player_rank > 0)
    peer_infamy:set_right(peer_name:x())
    peer_infamy:set_top(peer_name:y() + 4)
  else
    local peer_infamy = peer_info_panel:child("peer_infamy")

    peer_infamy:set_visible(false)
  end

  peer_info_panel:show()
  panel:child("card_info"):show()

  for i = 1, 3 do
    panel:child("card" .. i):show()
  end

  local function anim_fadein(o)
    over(1, function(p)
      o:set_alpha(p)
    end)
  end

  panel:animate(anim_fadein)

  local item_panel = panel:panel({
    name = "item",
    layer = 2,
    w = panel:h(),
    h = panel:h()
  })

  item_panel:hide()
  self:set_num_visible(math.max(self:get_local_peer_id(), peer_id))

  if self._peer_data[peer_id].delayed_card_id then
    self:begin_choose_card(peer_id, self._peer_data[peer_id].delayed_card_id)

    self._peer_data[peer_id].delayed_card_id = nil
  end
end

function HUDLootScreen:begin_choose_card(peer_id, card_id)
  if not self._peer_data[peer_id].active then
    self._peer_data[peer_id].delayed_card_id = card_id

    return
  end

  local panel = self._peers_panel:child("peer" .. tostring(peer_id))

  panel:stop()
  panel:set_alpha(1)

  local wait_for_lootdrop = self._peer_data[peer_id].wait_for_lootdrop
  self._peer_data[peer_id].wait_t = not wait_for_lootdrop and 5
  local card_info_panel = panel:child("card_info")
  local main_text = card_info_panel:child("main_text")

  main_text:set_text(managers.localization:to_upper_text(
    wait_for_lootdrop and "menu_l_choose_card_waiting" or "menu_l_choose_card_chosen", {
      time = 5
    }))

  local _, _, _, hh = main_text:text_rect()

  main_text:set_h(hh + 2)

  local lootdrop_data = self._peer_data[peer_id].lootdrops
  local left_pc = lootdrop_data[2]
  local right_pc = lootdrop_data[3]

  local cards = {}
  local card_one = card_id
  cards[card_one] = 3
  local card_two = #cards + 1
  cards[card_two] = left_pc
  local card_three = #cards + 1
  cards[card_three] = right_pc
  self._peer_data[peer_id].chosen_card_id = wait_for_lootdrop and card_id

  for i, pc in ipairs(cards) do
    local card_panel = panel:child("card" .. i)
    local downcard = card_panel:child("downcard")
    local texture, rect, coords = tweak_data.hud_icons:get_icon_data("upcard_safe")
    local upcard = card_panel:bitmap({
      name = "upcard",
      halign = "scale",
      blend_mode = "add",
      valign = "scale",
      layer = 1,
      texture = texture,
      w = math.round(0.7111111111111111 * card_panel:h()),
      h = card_panel:h()
    })

    upcard:set_rotation(downcard:rotation())
    upcard:set_shape(downcard:shape())

    local color_keys = {}
    for k, _ in pairs(rarity_colors) do
      table.insert(color_keys, k)
    end
    if card_id == i then
      item_color = _get_rarity_color(lootdrop_data[4])
      upcard:set_color(item_color or Color.white)
    else
      upcard:set_color(rarity_colors[color_keys[math.random(#color_keys)]])
    end

    if coords then
      local tl = Vector3(coords[1][1], coords[1][2], 0)
      local tr = Vector3(coords[2][1], coords[2][2], 0)
      local bl = Vector3(coords[3][1], coords[3][2], 0)
      local br = Vector3(coords[4][1], coords[4][2], 0)

      upcard:set_texture_coordinates(tl, tr, bl, br)
    else
      upcard:set_texture_rect(unpack(rect))
    end

    upcard:hide()
  end

  panel:child("card" .. card_two):animate(callback(self, self, "flipcard"), 5)
  panel:child("card" .. card_three):animate(callback(self, self, "flipcard"), 5)

  self._peer_data[peer_id].wait_for_choice = nil
end

function HUDLootScreen:begin_flip_card(peer_id)
  self._peer_data[peer_id].wait_t = 5
  local type_to_card = {
    weapon_mods = 2,
    materials = 5,
    colors = 6,
    safes = 8,
    cash = 3,
    masks = 1,
    xp = 4,
    textures = 7,
    drills = 9,
    weapon_bonus = 10
  }
  local card_nums = {
    "upcard_mask",
    "upcard_weapon",
    "upcard_cash",
    "upcard_xp",
    "upcard_material",
    "upcard_color",
    "upcard_pattern",
    "upcard_safe",
    "upcard_drill",
    "upcard_weapon_bonus"
  }

  table.insert(card_nums, "upcard_cosmetic")

  type_to_card.weapon_skins = #card_nums
  type_to_card.armor_skins = #card_nums
  local lootdrop_data = self._peer_data[peer_id].lootdrops
  local item_category = lootdrop_data[3]
  local item_id = lootdrop_data[4]
  local item_pc = lootdrop_data[6]

  if item_category == "weapon_mods" and managers.weapon_factory:get_type_from_part_id(item_id) == "bonus" then
    item_category = "weapon_bonus"
  end

  local card_i = type_to_card[item_category] or math.max(item_pc, 1)
  local texture, rect, coords = tweak_data.hud_icons:get_icon_data(card_nums[card_i] or "downcard_overkill_deck")
  local panel = self._peers_panel:child("peer" .. tostring(peer_id))
  local card_info_panel = panel:child("card_info")
  local main_text = card_info_panel:child("main_text")

  main_text:set_text(managers.localization:to_upper_text("menu_l_choose_card_chosen", {
    time = 5
  }))

  local _, _, _, hh = main_text:text_rect()

  main_text:set_h(hh + 2)

  local card_panel = panel:child("card" .. self._peer_data[peer_id].chosen_card_id)
  local upcard = card_panel:child("upcard")

  upcard:set_image(texture)

  if coords then
    local tl = Vector3(coords[1][1], coords[1][2], 0)
    local tr = Vector3(coords[2][1], coords[2][2], 0)
    local bl = Vector3(coords[3][1], coords[3][2], 0)
    local br = Vector3(coords[4][1], coords[4][2], 0)

    upcard:set_texture_coordinates(tl, tr, bl, br)
  else
    upcard:set_texture_rect(unpack(rect))
  end

  self._peer_data[peer_id].chosen_card_id = nil
end

function HUDLootScreen:show_item(peer_id)
  if not self._peer_data[peer_id].active then
    return
  end

  local panel = self._peers_panel:child("peer" .. peer_id)

  if panel:child("item") then
    panel:child("item"):set_center(panel:child("selected_panel"):center())
    panel:child("item"):show()

    for _, child in ipairs(panel:child("item"):children()) do
      child:set_center(panel:child("item"):w() * 0.5, panel:child("item"):h() * 0.5)
    end

    local function anim_fadein(o)
      over(1, function(p)
        o:set_alpha(p)
      end)
    end

    panel:child("item"):animate(anim_fadein)

    local card_info_panel = panel:child("card_info")
    local main_text = card_info_panel:child("main_text")
    local quality_text = card_info_panel:child("quality_text")
    local global_value_text = card_info_panel:child("global_value_text")
    local lootdrop_data = self._peer_data[peer_id].lootdrops
    local drop_name = lootdrop_data[4]
    local drop_meta = lootdrop_data[5]
    local item_text = managers.localization:to_upper_text(drop_name .. "_roguelike_lootdrop")
    if drop_name == "perk_deck" then
      item_text =
          item_text .. ": " .. managers.localization:text(tweak_data.skilltree.specializations[drop_meta].name_id)
    end

    main_text:set_text(managers.localization:to_upper_text("menu_l_you_got", {
      category = managers.localization:text("bm_menu_roguelike_lootdrop"),
      item = item_text
    }))

    local _, _, _, hh = main_text:text_rect()

    main_text:set_h(hh + 2)
    self:make_fine_text(quality_text)
    main_text:set_y(0)
    quality_text:set_y(main_text:bottom())
    global_value_text:set_y(quality_text:visible() and quality_text:bottom() or main_text:bottom())
    card_info_panel:set_h(global_value_text:visible() and global_value_text:bottom() or
      quality_text:visible() and quality_text:bottom() or main_text:bottom())
    card_info_panel:set_center_y(panel:h() * 0.5)

    self._peer_data[peer_id].ready = true
    local clbk = self._callback_handler.on_peer_ready

    if clbk then
      clbk()
    end
  else
    self._need_item = self._need_item or {}
    self._need_item[peer_id] = true
  end
end
