-- Change text on mission fail button when pro job is enabled
function GameOverState:_set_continue_button_text()
  local text_id = self._continue_block_timer and Application:time() < self._continue_block_timer and
      "menu_es_calculating_experience" or not self._completion_bonus_done and "menu_es_calculating_experience" or
      (Network:is_server() or managers.dlc:is_trial()) and
      (managers.job:is_current_job_professional() and (Global.game_settings.single_player and "failed_disconnected_continue" or "roguelike_pro_job_failure") or "menu_victory_retry_stage") or
      "victory_client_waiting_for_server"
  local continue_button = managers.menu:is_pc_controller() and "[ENTER]" or nil
  local text = utf8.to_upper(managers.localization:text(text_id, {
    CONTINUE = continue_button
  }))

  managers.menu_component:set_endscreen_continue_button_text(text,
    text_id ~= "failed_disconnected_continue" and text_id ~= "debug_mission_end_continue" and
    text_id ~= "menu_victory_retry_stage" and text_id ~= "roguelike_pro_job_failure")
end

-- Delete save data on fail
Hooks:PostHook(GameOverState, "at_enter", "roguelike_enter_gameover_state", function(self, ...)
  if Roguelike:pro_job() then
    managers.menu:do_clear_progress()

    if managers.menu_component then
      managers.menu_component:refresh_player_profile_gui()
    end

    managers.savefile:save_progress()
    managers.savefile:save_setting(true)
    managers.roguelike:reset_progress()
  end
end)
