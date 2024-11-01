Hooks:PostHook(StoryMissionsGui, "init", "link_to_roguelike_manager", function(self)
  managers.roguelike:set_story_mission_gui(self)
end)

local padding = 10
local massive_font = tweak_data.menu.pd2_massive_font
local large_font = tweak_data.menu.pd2_large_font
local medium_font = tweak_data.menu.pd2_medium_font
local small_font = tweak_data.menu.pd2_small_font
local massive_font_size = tweak_data.menu.pd2_massive_font_size
local large_font_size = tweak_data.menu.pd2_large_font_size
local medium_font_size = tweak_data.menu.pd2_medium_font_size
local small_font_size = tweak_data.menu.pd2_small_font_size
local done_icon = "guis/textures/menu_singletick"
local reward_icon = "guis/textures/pd2/icon_reward"
local active_mission_icon = "guis/textures/scrollarrow"

function StoryMissionsGui:_update_info(mission)
  self._info_scroll:clear()
  self:_change_legend("select", false)
  self:_change_legend("start_mission", false)

  self._select_btn = nil
  self._level_btns = {}
  self._selected_level_btn = nil

  if self._voice then
    managers.briefing:stop_event()
    self._voice.panel:remove_self()

    self._voice = nil
  end

  mission = mission or managers.story:current_mission()

  if not mission then
    return
  end

  managers.roguelike:build_objectives(mission)

  local canvas = self._info_scroll:canvas()
  local placer = canvas:placer()
  local text_col = tweak_data.screen_colors.text

  if mission.completed and mission.rewarded and mission.last_mission then
    placer:add_row(canvas:fine_text({
      text_id = "menu_sm_all_done",
      font = medium_font,
      font_size = medium_font_size
    }))

    return
  end

  placer:add_row(canvas:fine_text({
    text = managers.localization:to_upper_text(mission.name_id),
    font = medium_font,
    font_size = medium_font_size,
    color = text_col
  }))
  placer:add_row(canvas:fine_text({
    wrap = true,
    word_wrap = true,
    text = managers.localization:text(mission.desc_id),
    font = small_font,
    font_size = small_font_size,
    color = text_col
  }))

  if mission.voice_line then
    self._voice = {}
    local h = small_font_size * 2 + 20
    local pad = 8
    self._voice.panel = ExtendedPanel:new(self, {
      w = 256,
      input = true,
      h = h
    })

    BoxGuiObject:new(self._voice.panel, {
      sides = {
        1,
        1,
        1,
        1
      }
    })

    self._voice.text = self._voice.panel:text({
      x = pad,
      y = pad,
      font = small_font,
      font_size = small_font_size,
      color = text_col,
      text = managers.localization:to_upper_text("menu_cn_message_playing")
    })
    self._voice.button = TextButton:new(self._voice.panel, {
      binding = "menu_toggle_ready",
      x = pad,
      font = small_font,
      font_size = small_font_size,
      text = managers.localization:to_upper_text("menu_stop_sound", {
        BTN_X = managers.localization:btn_macro("menu_toggle_ready")
      })
    }, callback(self, self, "toggle_voice_message", mission.voice_line))

    self._voice.button:set_bottom(self._voice.panel:h() - pad)
    self._voice.panel:set_world_right(self._info_scroll:world_right())
    self:toggle_voice_message(mission.voice_line)
  end

  if mission.tier_list then
    placer:add_row(canvas:fine_text({
      text = managers.localization:to_upper_text("roguelike_tier_heist_title"),
      font = small_font,
      font_size = small_font_size,
      color = tweak_data.screen_colors.challenge_title
    }))
    local tier_heists = tweak_data.story:heist_pool(mission.list_tier)
    local all_heists = ""
    for _, heist in pairs(tier_heists) do
      all_heists = all_heists .. managers.localization:text("menu_sm_" .. heist) .. "\n"
    end
    placer:add_row(canvas:fine_text({
      wrap = true,
      word_wrap = true,
      text = all_heists,
      font = small_font,
      font_size = small_font_size,
      color = text_col
    }), nil, 0)
  else
    placer:add_row(canvas:fine_text({
      text = managers.localization:to_upper_text("menu_challenge_objective_title"),
      font = small_font,
      font_size = small_font_size,
      color = tweak_data.screen_colors.challenge_title
    }))
    placer:add_row(canvas:fine_text({
      wrap = true,
      word_wrap = true,
      text = managers.localization:text(mission.objective_id),
      font = small_font,
      font_size = small_font_size,
      color = text_col
    }), nil, 0)
  end

  local locked = false
  local can_skip_mission = false
  local levels = {}

  if not mission.hide_progress then
    if not mission.completed then
      local reroll_btn = TextButton:new(canvas, {
        text_id = "menu_cs_reroll",
        font = small_font,
        font_size = small_font_size
      }, function()
        managers.roguelike:reroll()
      end)
      placer:add_row(reroll_btn)
    end

    placer:add_row(canvas:fine_text({
      text = managers.localization:to_upper_text("menu_unlock_progress"),
      font = small_font,
      font_size = small_font_size,
      color = tweak_data.screen_colors.challenge_title
    }))

    local num_objective_groups = #mission.objectives
    local obj_padd_x = num_objective_groups > 1 and 15 or nil
    local owned, global_value, gvalue_tweak = nil

    for i, objective_row in ipairs(mission.objectives) do
      for _, objective in ipairs(objective_row) do
        owned = not objective.dlc or managers.dlc:is_dlc_unlocked(objective.dlc)
        global_value = objective.dlc and managers.dlc:dlc_to_global_value(objective.dlc)
        gvalue_tweak = global_value and tweak_data.lootdrop.global_values[global_value]
        local text = placer:add_row(canvas:fine_text({
          wrap = true,
          word_wrap = true,
          text = managers.localization:text(objective.name_id),
          font = small_font,
          font_size = small_font_size,
          color = text_col
        }), obj_padd_x, 0)

        if not mission.completed then
          table.list_append(levels, objective.levels or {})
        end

        if (not mission.completed or objective.basic) and (not objective.completed or objective.basic) and objective.levels and (not objective.basic or not Network:is_server()) and not Network:is_client() and mission.completed == mission.rewarded then
          if not owned and gvalue_tweak and gvalue_tweak.hide_unavailable then
            placer:add_right(canvas:fine_text({
              text = managers.localization:to_upper_text("menu_sm_dlc_unavailable"),
              font = small_font,
              font_size = small_font_size,
              color = tweak_data.screen_colors.important_1
            }), 5)

            can_skip_mission = true
            locked = true
          elseif not owned and not Global.game_settings.single_player then
            placer:add_right(canvas:fine_text({
              text_id = "menu_sm_dlc_locked",
              font = small_font,
              font_size = small_font_size,
              color = tweak_data.screen_colors.important_1
            }), 5)

            locked = true
          else
            local btn = TextButton:new(canvas, {
              text_id = "menu_sm_start_level",
              font = small_font,
              font_size = small_font_size
            }, function()
              managers.story:start_mission(mission, objective.progress_id)
            end)

            placer:add_right(btn, 10)
            table.insert(self._level_btns, btn)
            self:_change_legend("start_mission", true)

            if not self._selected_level_btn then
              self._selected_level_btn = btn

              if not managers.menu:is_pc_controller() then
                btn:_hover_changed(true)
              end
            end
          end
        end

        if objective.max_progress > 1 then
          local progress = placer:add_row(TextProgressBar:new(canvas, {
            h = small_font_size + 2,
            max = objective.max_progress,
            back_color = Color(0, 0, 0, 0),
            progress_color = tweak_data.screen_colors.challenge_completed_color:with_alpha(0.4)
          }, {
            font = small_font,
            font_size = small_font_size,
            color = text_col
          }, objective.progress), nil, 0)
          local box = BoxGuiObject:new(progress, {
            sides = {
              1,
              1,
              1,
              1
            }
          })
        elseif objective.completed or owned or not gvalue_tweak or not gvalue_tweak.hide_unavailable then
          local texture = "guis/textures/menu_tickbox"
          local texture_rect = {
            (objective.completed or mission.completed) and 24 or 0,
            0,
            24,
            24
          }
          local checkbox = canvas:bitmap({
            texture = texture,
            texture_rect = texture_rect
          })

          checkbox:set_right(canvas:w())
          checkbox:set_top(text:top())
        end
      end

      if i < num_objective_groups then
        placer:add_row(canvas:fine_text({
          text_id = "menu_sm_objectives_or",
          font = small_font,
          font_size = small_font_size,
          color = tweak_data.screen_colors.challenge_title
        }), nil, 0)
      end
    end

    if mission.tier_skip then
      for i = 1, managers.roguelike.save_data.highest_tier do
        local text = placer:add_row(canvas:fine_text({
          wrap = true,
          word_wrap = true,
          text = managers.localization:text("roguelike_tierskip_title") .. " " .. i,
          font = small_font,
          font_size = small_font_size,
          color = text_col
        }), obj_padd_x, 0)

        local btn = TextButton:new(canvas, {
          text = managers.localization:text("roguelike_tierskip_button"),
          font = small_font,
          font_size = small_font_size
        }, function()
          managers.roguelike:skip_to_tier(i)

          self:_update()

          local dialog_data = {
            title = managers.localization:text("roguelike_tierskip_title") .. " " .. i,
            text = self:_compile_perkdeck_reward_string() .. self:_compile_weapon_reward_string()
          }
          local ok_button = {
            text = managers.localization:text("dialog_ok"),
            callback_func = function()
              self:_update()
            end
          }
          dialog_data.button_list = {
            ok_button
          }

          managers.system_menu:show(dialog_data)
        end)

        placer:add_right(btn, 10)
      end
    end
  end

  if locked then
    placer:add_row(canvas:fine_text({
      wrap = true,
      word_wrap = true,
      text_id = can_skip_mission and "menu_sm_dlc_unavailable_help_text" or "menu_sm_dlc_locked_help_text",
      font = small_font,
      font_size = small_font_size,
      color = text_col
    }), nil, nil)
  end

  if self:_get_reward_string(mission) then
    local title = placer:add_row(canvas:fine_text({
      text = managers.localization:to_upper_text("menu_reward"),
      font = small_font,
      font_size = small_font_size,
      color = tweak_data.screen_colors.challenge_title
    }))
    local r_panel = GrowPanel:new(canvas, {
      input = true
    })
    local r_placer = r_panel:placer()
    local skipped_mission = managers.story:get_last_skipped_mission() == mission

    for i, reward in ipairs(mission.rewards) do
      local item = StoryMissionGuiRewardItem:new(r_panel, reward, nil, skipped_mission)

      if r_placer:current_right() + item:w() < canvas:w() * 0.5 then
        r_placer:add_right(item)
      else
        r_placer:add_row(item)
      end
    end

    BoxGuiObject:new(r_panel, {
      sides = {
        1,
        1,
        1,
        1
      }
    })
    placer:add_row(r_panel, nil, 0)
    r_panel:set_right(canvas:w())

    local reward_text = canvas:fine_text({
      wrap = true,
      word_wrap = true,
      text = managers.localization:text(self:_get_reward_string(mission)),
      font = small_font,
      font_size = small_font_size,
      keep_w = r_panel:left() - title:left()
    })

    reward_text:set_lefttop(title:left(), r_panel:top())
    placer:set_at_from(reward_text)
  end

  if mission.completed and not mission.rewarded then
    local item = placer:add_row(TextButton:new(canvas, {
      text_id = mission.last_mission and "menu_sm_claim_rewards" or "menu_sm_claim_rewards_goto_next",
      font = medium_font,
      font_size = medium_font_size
    }, function()
      managers.story:claim_rewards(mission)
      managers.menu_component:post_event("menu_skill_investment")

      local dialog_data = {
        title = managers.localization:text("menu_sm_claim_rewards"),
        text = self:_get_reward_dialog_string(mission)
      }
      local ok_button = {
        text = managers.localization:text("dialog_ok"),
        callback_func = function()
          self:_update()
        end
      }
      dialog_data.button_list = {
        ok_button
      }

      managers.system_menu:show(dialog_data)
    end))

    item:set_right(canvas:w())

    self._select_btn = item

    self:_change_legend("select", true)
  end

  if not mission.completed then
    can_skip_mission = can_skip_mission or table.contains(levels, managers.story:get_last_failed_heist())

    if can_skip_mission then
      local btn = TextButton:new(canvas, {
        text_id = "menu_skip_story",
        font = medium_font,
        font_size = medium_font_size
      }, callback(self, self, "_skip_mission_dialog"))

      placer:add_row(btn)
      btn:set_right(canvas:w())
      btn:set_y(btn:y() + 15)
    end

    self:_change_legend("skip_mission", can_skip_mission)
  end
end

function StoryMissionsGui:_compile_weapon_reward_string()
  local compiled_string = "Dropped Weapons: "
  for _, v in pairs(managers.roguelike._dropped_weapons) do
    compiled_string = compiled_string .. "\n"
    compiled_string = compiled_string .. managers.localization:text(v)
  end
  compiled_string = compiled_string .. "\n"
  compiled_string = compiled_string .. "\n"

  compiled_string = compiled_string .. "Dropped Weapon Mods: "
  for _, v in pairs(managers.roguelike._dropped_mods) do
    compiled_string = compiled_string .. "\n"
    compiled_string = compiled_string .. managers.localization:text(v)
  end
  compiled_string = compiled_string .. "\n"
  compiled_string = compiled_string .. "\n"

  return compiled_string
end

function StoryMissionsGui:_compile_perkdeck_reward_string()
  local compiled_string = "Dropped Perk Decks: "
  for _, v in pairs(managers.roguelike._dropped_perkdecks or {}) do
    compiled_string = compiled_string .. "\n"
    compiled_string = compiled_string .. managers.localization:text(tweak_data.skilltree.specializations[v].name_id)
  end
  compiled_string = compiled_string .. "\n"
  compiled_string = compiled_string .. "\n"

  return compiled_string
end

function StoryMissionsGui:_get_reward_dialog_string(mission)
  if mission.reward_id == 'menu_sm_default_reward' then
    return self:_compile_weapon_reward_string()
  elseif mission.reward_id == "menu_sm_perkdeck_reward" then
    return self:_compile_perkdeck_reward_string()
  else
    return managers.localization:text(self:_get_reward_string(mission))
  end
end

local function set_defaults(target, source)
  target = target or {}

  for k, v in pairs(source) do
    if target[k] == nil then
      target[k] = v
    end
  end

  return target
end

function StoryMissionGuiRewardItem:init(panel, reward_data, config, skipped_mission)
  config = set_defaults(config, {
    input = true,
    w = self.SIZE,
    h = self.SIZE
  })

  StoryMissionGuiRewardItem.super.init(self, panel, config)

  local texture_path, texture_rect, reward_string = nil

  if reward_data.perkdeck_reward then
    local specialization_data = tweak_data.skilltree.specializations[math.random(23)]
    local tier_data = specialization_data[9]
    local texture_rect_x = tier_data.icon_xy and tier_data.icon_xy[1] or 0
    local texture_rect_y = tier_data.icon_xy and tier_data.icon_xy[2] or 0

    local guis_catalog = "guis/"
    if tier_data.texture_bundle_folder then
      guis_catalog = guis_catalog .. "dlcs/" .. tostring(tier_data.texture_bundle_folder) .. "/"
    end
    texture_path = guis_catalog .. "textures/pd2/specialization/icons_atlas"
    texture_rect = {
      texture_rect_x * 64,
      texture_rect_y * 64,
      64,
      64
    }

    if reward_data.perkdeck_reward == "first_deck" then
      reward_string = managers.localization:text("roguelike_initial_perkdeck_reward")
    else
      reward_string = managers.localization:text("roguelike_perkdeck_reward")
    end

    local function perkdeck_anim_func(reward_item)
      reward_item._image:set_size(0, 0)
      local specialization_data = tweak_data.skilltree.specializations[math.random(23)]
      local tier_data = specialization_data[9]
      local texture_rect_x = tier_data.icon_xy and tier_data.icon_xy[1] or 0
      local texture_rect_y = tier_data.icon_xy and tier_data.icon_xy[2] or 0

      local guis_catalog = "guis/"
      if tier_data.texture_bundle_folder then
        guis_catalog = guis_catalog .. "dlcs/" .. tostring(tier_data.texture_bundle_folder) .. "/"
      end
      texture_path = guis_catalog .. "textures/pd2/specialization/icons_atlas"
      texture_rect = {
        texture_rect_x * 64,
        texture_rect_y * 64,
        64,
        64
      }

      local scale = 0.7
      reward_item._image = reward_item:fit_bitmap({
        texture = texture_path,
        texture_rect = texture_rect
      }, scale * reward_item:w(), scale * reward_item:h())

      reward_item._image:set_center_y(reward_item:h() * 0.5)
      reward_item._image:set_center_x(reward_item:w() * 0.5)
    end

    panel:animate(function(o)
      while true do
        _G.wait(0.5)
        perkdeck_anim_func(self)
      end
    end)
  elseif reward_data.weapon_reward then
    texture_path = managers.blackmarket:get_weapon_icon_path(tweak_data.roguelike.all_weapon_keys
      [math.random(#tweak_data.roguelike.all_weapon_keys)]
    )
    reward_string = managers.localization:text("roguelike_weapon_reward_2")

    local function weapon_anim_func(reward_item)
      reward_item._image:set_size(0, 0)
      local texture_path = managers.blackmarket:get_weapon_icon_path(tweak_data.roguelike.all_weapon_keys
        [math.random(#tweak_data.roguelike.all_weapon_keys)]
      )

      local scale = 0.7
      reward_item._image = reward_item:fit_bitmap({
        texture = texture_path,
        texture_rect = nil
      }, scale * reward_item:w(), scale * reward_item:h())

      reward_item._image:set_center_y(reward_item:h() * 0.5)
      reward_item._image:set_center_x(reward_item:w() * 0.5)
    end

    panel:animate(function(o)
      while true do
        _G.wait(0.5)
        weapon_anim_func(self)
      end
    end)
  elseif reward_data.mod_reward then
    texture_path = "guis/textures/pd2/icon_modbox_df"
    reward_string = managers.localization:text("roguelike_mod_reward_5")
  end

  local scale = 0.7
  self._image = self:fit_bitmap({
    texture = texture_path,
    texture_rect = texture_rect
  }, scale * self:w(), scale * self:h())

  self._image:set_center_y(self:h() * 0.5)
  self._image:set_center_x(self:w() * 0.5)

  self._text = self:fine_text({
    vertical = "bottom",
    blend_mode = "add",
    align = "left",
    visible = false,
    font_size = small_font_size,
    font = small_font,
    color = tweak_data.screen_colors.title,
    text = reward_string,
    w = self:w(),
    h = small_font_size * 2
  })

  self.scale_font_to_fit(self._text, self:w())
  self._text:set_bottom(self:h())
  self._text:set_x(self:w() * 0.5 - self._text:w() * 0.5)
end
