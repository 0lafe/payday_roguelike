function MenuCallbackHandler:start_job(job_data)
  if not managers.job:activate_job(job_data.job_id) then
    return
  end

  Global.game_settings.level_id = managers.job:current_level_id()
  Global.game_settings.mission = managers.job:current_mission()
  Global.game_settings.world_setting = managers.job:current_world_setting()
  Global.game_settings.difficulty = job_data.difficulty
  Global.game_settings.one_down = job_data.one_down
  Global.game_settings.weekly_skirmish = job_data.weekly_skirmish

  if managers.platform then
    managers.platform:update_discord_heist()
  end

  local matchmake_attributes = self:get_matchmake_attributes()

  if Network:is_server() then
    local job_id_index = tweak_data.narrative:get_index_from_job_id(managers.job:current_job_id())
    local level_id_index = tweak_data.levels:get_index_from_level_id(Global.game_settings.level_id)
    local difficulty_index = tweak_data:difficulty_to_index(Global.game_settings.difficulty)
    local one_down = Global.game_settings.one_down
    local weekly_skirmish = Global.game_settings.weekly_skirmish

    managers.network:session():send_to_peers("sync_game_settings", job_id_index, level_id_index, difficulty_index,
      one_down, weekly_skirmish)
    managers.network.matchmake:set_server_attributes(matchmake_attributes)
    managers.mutators:update_lobby_info()
    managers.menu_component:on_job_updated()
    managers.menu:open_node("lobby")
    managers.menu:active_menu().logic:refresh_node("lobby", true)
  else
    managers.network.matchmake:create_lobby(matchmake_attributes)
  end

  managers.platform:refresh_rich_presence_state()
end
