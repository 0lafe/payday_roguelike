-- Allow all difficulties from level 0
function MenuCallbackHandler:is_contract_difficulty_allowed(item)
  if not managers.menu:active_menu() then
    return false
  end

  if not managers.menu:active_menu().logic then
    return false
  end

  if not managers.menu:active_menu().logic:selected_node() then
    return false
  end

  if not managers.menu:active_menu().logic:selected_node():parameters().menu_component_data then
    return false
  end

  local job_data = managers.menu:active_menu().logic:selected_node():parameters().menu_component_data

  if not job_data.job_id then
    return false
  end

  if job_data.professional and item:value() < 3 then
    return false
  end

  return true
end

-- Handles main menu changes
Hooks:PostHook(MenuManager, "init", "init_show_career", function(self, is_start_menu)
  if not is_start_menu then
    return
  end

  local menu = self._registered_menus.menu_main
  local nodes = menu.data._nodes
  local lobby_node = nodes and nodes.lobby
  local story_missions = lobby_node and lobby_node:item("story_missions")

  -- shows career mode menu as client in lobby
  if story_missions then
    story_missions._visible_callback_list = nil
    story_missions:set_visible(true)
    story_missions._parameters.trial_buy = true
  end

  -- Hides extra menu options
  local main_node = nodes and nodes.main

  local crimenet_index
  local social_hub_index
  local story_missions_index
  for k, v in pairs(main_node._items) do
    if v._parameters and v._parameters.name then
      local name = v._parameters.name
      if name == "crimenet" then
        crimenet_index = k
      elseif name == "social_hub" then
        social_hub_index = k
      elseif name == "story_missions" then
        story_missions_index = k
      end
    end
  end

  if crimenet_index and social_hub_index and story_missions_index then
    local temp_crimenet = main_node._items[crimenet_index]
    local temp_social_hud = main_node._items[social_hub_index]
    local temp_story_missions = main_node._items[story_missions_index]

    main_node._items[crimenet_index] = temp_story_missions
    main_node._items[social_hub_index] = temp_crimenet
    main_node._items[story_missions_index] = temp_social_hud
  end

  local node = main_node:item("crimenet_offline")
  if node then
    node:set_visible(false)
  end

  local story_node = main_node:item("story_missions")
  if story_node then
    story_node._parameters.trial_buy = true
  end

  for _, v in pairs({ "crimenet_nj", "crimenet_j", "side_jobs" }) do
    local node = lobby_node:item(v)
    if node then
      node:set_visible(false)
    end
  end
end)

-- Handles resetting roguelike data when account progression is reset
Hooks:PostHook(MenuCallbackHandler, "_dialog_clear_progress_yes", "_dialog_clear_progress_yes_roguelike", function(self)
  managers.roguelike:reset_progress()
end)
