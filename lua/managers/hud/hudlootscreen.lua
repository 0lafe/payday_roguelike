-- gets the texture path of a random mask
local function _get_random_mask_texture()
  local masks = tweak_data.blackmarket.masks
  local mask_keys = {}
  for k, v in pairs(masks) do
    table.insert(mask_keys, k)
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

-- animate function to change drop image between masks
local function _mask_anim_function(hudlootscreen, panel, peer_id)
  if hudlootscreen._image_item then
    panel:remove(hudlootscreen._image_item)
  end

  local texture_path = _get_random_mask_texture()

  local item = panel:bitmap({
    blend_mode = "normal",
    layer = 1,
    texture = texture_path
  })
  hudlootscreen._image_item = item

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

  item:set_size(math.round(dw * panel_width), math.round(dh * panel_height))
  item:set_rotation(360)
  item:set_center(panel:w() * 0.5, panel:h() * 0.5)

  if hudlootscreen._need_item and hudlootscreen._need_item[peer_id] then
    hudlootscreen._need_item[peer_id] = false

    hudlootscreen:show_item(peer_id)
  end
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

  local texture_loaded_clbk = callback(self, self, "texture_loaded_clbk", {
    peer_id,
    drop_name
  })
  local texture_path = nil

  if drop_name == "xp" then
    texture_path = "guis/textures/pd2/blackmarket/xp_drop"
  elseif drop_name == "coins" then
    texture_path = "guis/dlcs/chill/textures/pd2/safehouse/continental_coins_drop"
  elseif drop_name == "masks" then
    texture_path = "guis/textures/pd2/blackmarket/cash_drop"
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
  local panel = self._peers_panel:child("peer" .. tostring(peer_id)):child("item")
  local item = panel:bitmap({
    blend_mode = "normal",
    layer = 1,
    texture = texture_idstring
  })
  self._image_item = item

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

  item:set_size(math.round(dw * panel_width), math.round(dh * panel_height))
  item:set_rotation(360)
  item:set_center(panel:w() * 0.5, panel:h() * 0.5)

  if self._need_item and self._need_item[peer_id] then
    self._need_item[peer_id] = false

    self:show_item(peer_id)
  end

  if drop_name == "masks" then
    panel:animate(function(o)
      while true do
        _G.wait(0.5)
        _mask_anim_function(self, panel, peer_id)
      end
    end)
  end
end

function HUDLootScreen:flipcard(card_panel, timer, done_clbk, peer_id, effects)
  log("flip card")
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
  log("make_cards")
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
  local max_quality = peer_info_panel:child("max_quality")

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

  max_quality:set_text(managers.localization:to_upper_text("menu_l_max_quality", {
    quality = max_pc
  }))
  self:make_fine_text(peer_name)
  self:make_fine_text(max_quality)
  peer_name:set_right(peer_info_panel:w())
  max_quality:set_right(peer_info_panel:w())

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
  log("begin_choose_card")
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

    upcard:set_color(Color(math.random(), math.random(), math.random()))

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
  log("begin_flip_card")
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
  log("showing item")
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
    local item_text = managers.localization:text(drop_name .. "_roguelike_lootdrop")

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

function HUDLootScreen:create_stars_giving_animation()
  log("create_stars_giving_animation")
  local lootdrops = self:fetch_local_lootdata()
  local human_players = managers.network:session() and managers.network:session():amount_of_alive_players() or 1
  local all_humans = human_players == tweak_data.max_players

  if not lootdrops or not lootdrops[5] then
    return
  end

  local max_pc = lootdrops[5]
  local job_stars = managers.job:has_active_job() and managers.job:current_job_and_difficulty_stars() or 1
  local difficulty_stars = managers.job:has_active_job() and managers.job:current_difficulty_stars() or 0
  local player_stars = managers.experience:level_to_stars()
  local bonus_stars = all_humans and 1 or 0
  local level_stars = player_stars < max_pc and tweak_data.lootdrop.level_limit or 0
  local max_number_of_stars = job_stars

  if self._stars_panel then
    self._stars_panel:stop()
    self._stars_panel:parent():remove(self._stars_panel)

    self._stars_panel = nil
  end

  self._stars_panel = self._foreground_layer_safe:panel()

  self._stars_panel:set_left(self._foreground_layer_safe:child("loot_text"):right() + 10)

  local star_reason_text = self._stars_panel:text({
    text = "",
    font = tweak_data.menu.pd2_medium_font,
    font_size = tweak_data.menu.pd2_medium_font_size
  })

  star_reason_text:set_left(max_number_of_stars * 35)
  star_reason_text:set_h(tweak_data.menu.pd2_medium_font_size)
  star_reason_text:set_world_center_y(math.round(self._foreground_layer_safe:child("loot_text"):world_center_y()) + 2)

  local function animation_func(o)
    local texture, rect = tweak_data.hud_icons:get_icon_data("risk_pd")
    local latest_star = 0

    wait(1.35)

    for i = 1, max_number_of_stars do
      wait(0.1)

      local star = self._stars_panel:bitmap({
        h = 32,
        w = 32,
        blend_mode = "add",
        name = "star_" .. tostring(i),
        texture = texture,
        texture_rect = rect,
        color = i > max_number_of_stars - difficulty_stars and tweak_data.screen_colors.risk or
            tweak_data.screen_colors.text
      })
      local star_color = star:color()

      star:set_alpha(0)
      star:set_x((i - 1) * 35)
      star:set_world_center_y(math.round(self._foreground_layer_safe:child("loot_text"):world_center_y()))
      managers.menu_component:post_event("Play_star_hit")
      over(0.45, function(p)
        star:set_alpha(math.min(p * 10, 1))
        star:set_color(math.lerp(star_color, star_color, p) - math.clamp(math.sin(p * 180), 0, 1) * Color(1, 1, 1))
        star:set_color(star:color():with_alpha(1))
      end)

      latest_star = i
    end

    over(0.5, function(p)
      star_reason_text:set_alpha(1 - p)
    end)
  end

  self._stars_panel:animate(animation_func)
end

function HUDLootScreen:update(t, dt)
  for peer_id = 1, tweak_data.max_players do
    if self._peer_data[peer_id].wait_t then
      self._peer_data[peer_id].wait_t = math.max(self._peer_data[peer_id].wait_t - dt, 0)
      local panel = self._peers_panel:child("peer" .. tostring(peer_id))
      local card_info_panel = panel:child("card_info")
      local main_text = card_info_panel:child("main_text")

      main_text:set_text(managers.localization:to_upper_text("menu_l_choose_card_chosen", {
        time = math.ceil(self._peer_data[peer_id].wait_t)
      }))

      local _, _, _, hh = main_text:text_rect()

      main_text:set_h(hh + 2)

      if self._peer_data[peer_id].wait_t == 0 then
        main_text:set_text(managers.localization:to_upper_text("menu_l_choose_card_chosen_suspense"))

        local joker = self._peer_data[peer_id].joker
        local steam_drop = self._peer_data[peer_id].steam_drop
        local effects = self._peer_data[peer_id].effects

        panel:child("card" .. self._peer_data[peer_id].selected):animate(callback(self, self, "flipcard"),
          steam_drop and 5.5 or 2.5, callback(self, self, "show_item"), peer_id, effects)

        self._peer_data[peer_id].wait_t = false
      end
    end
  end
end

function HUDLootScreen:init(hud, workspace, saved_lootdrop, saved_selected, saved_chosen, saved_setup)
  self._backdrop = MenuBackdropGUI:new(workspace)

  if not _G.IS_VR then
    self._backdrop:create_black_borders()
  end

  self._active = false
  self._hud = hud
  self._workspace = workspace
  local massive_font = tweak_data.menu.pd2_massive_font
  local large_font = tweak_data.menu.pd2_large_font
  local medium_font = tweak_data.menu.pd2_medium_font
  local small_font = tweak_data.menu.pd2_small_font
  local massive_font_size = tweak_data.menu.pd2_massive_font_size
  local large_font_size = tweak_data.menu.pd2_large_font_size
  local medium_font_size = tweak_data.menu.pd2_medium_font_size
  local small_font_size = tweak_data.menu.pd2_small_font_size
  self._background_layer_safe = self._backdrop:get_new_background_layer()
  self._background_layer_full = self._backdrop:get_new_background_layer()
  self._foreground_layer_safe = self._backdrop:get_new_foreground_layer()
  self._foreground_layer_full = self._backdrop:get_new_foreground_layer()
  self._baselayer_two = self._backdrop:get_new_base_layer()

  self._backdrop:set_panel_to_saferect(self._background_layer_safe)
  self._backdrop:set_panel_to_saferect(self._foreground_layer_safe)

  self._callback_handler = {}
  local lootscreen_string = managers.localization:to_upper_text("menu_l_lootscreen")
  local loot_text = self._foreground_layer_safe:text({
    vertical = "top",
    name = "loot_text",
    align = "center",
    text = lootscreen_string,
    font_size = large_font_size,
    font = large_font,
    color = tweak_data.screen_colors.text
  })

  self:make_fine_text(loot_text)

  local bg_text = self._background_layer_full:text({
    vertical = "top",
    h = 90,
    align = "left",
    alpha = 0.4,
    text = loot_text:text(),
    font_size = massive_font_size,
    font = massive_font,
    color = tweak_data.screen_colors.button_stage_3
  })

  self:make_fine_text(bg_text)

  local x, y = managers.gui_data:safe_to_full_16_9(loot_text:world_x(), loot_text:world_center_y())

  bg_text:set_world_left(loot_text:world_x())
  bg_text:set_world_center_y(loot_text:world_center_y())
  bg_text:move(-13, 9)

  local icon_path, texture_rect = tweak_data.hud_icons:get_icon_data("downcard_overkill_deck")
  self._downcard_icon_path = icon_path
  self._downcard_texture_rect = texture_rect
  self._hud_panel = self._foreground_layer_safe:panel()

  self._hud_panel:set_y(25)
  self._hud_panel:set_h(self._hud_panel:h() - 25 - 150)

  self._peer_data = {}
  self._peers_panel = self._hud_panel:panel({})

  for i = 1, tweak_data.max_players do
    self:create_peer(self._peers_panel, i)
  end

  self._num_visible = 1

  self:set_num_visible(self:get_local_peer_id())

  if saved_setup then
    for _, setup in ipairs(saved_setup) do
      self:make_cards(setup.peer, setup.max_pc, setup.left_card, setup.right_card)
    end
  end

  self._lootdrops = self._lootdrops or {}

  if saved_lootdrop then
    for _, lootdrop in ipairs(saved_lootdrop) do
      self:make_lootdrop(lootdrop)
    end
  end

  if saved_selected then
    for peer_id, selected in pairs(saved_selected) do
      self:set_selected(peer_id, selected)
    end
  end

  if saved_chosen then
    for peer_id, card_id in pairs(saved_chosen) do
      self:begin_choose_card(peer_id, card_id)
    end
  end

  local local_peer_id = self:get_local_peer_id()
  local panel = self._peers_panel:child("peer" .. tostring(local_peer_id))
  local peer_info_panel = panel:child("peer_info")
  local peer_name = peer_info_panel:child("peer_name")
  local peer_name_string = tostring(managers.network.account:username() or
    managers.blackmarket:get_preferred_character_real_name())
  local color_range_offset = utf8.len(peer_name_string) + 2
  local experience, color_ranges = managers.experience:gui_string(managers.experience:current_level(),
    managers.experience:current_rank(), color_range_offset)

  peer_name:set_text(peer_name_string .. " (" .. experience .. ")")

  for _, color_range in ipairs(color_ranges or {}) do
    peer_name:set_range_color(color_range.start, color_range.stop, color_range.color)
  end

  self:make_fine_text(peer_name)
  peer_name:set_right(peer_info_panel:w())

  if managers.experience:current_rank() > 0 then
    peer_info_panel:child("peer_infamy"):set_visible(true)
    peer_info_panel:child("peer_infamy"):set_right(peer_name:x())
    peer_info_panel:child("peer_infamy"):set_top(peer_name:y() + 4)
  else
    peer_info_panel:child("peer_infamy"):set_visible(false)
  end

  panel:set_alpha(1)
  peer_info_panel:show()
  panel:child("card_info"):hide()
end
