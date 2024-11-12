local function train_trade()
  return managers.job:current_job_id() == "framing_frame" and managers.job:current_stage() == 2
end

-- force loud when hard mode enabled
Hooks:PostHook(PlayerStandard, "init", "toggle_forced_loud", function(self, unit)
  if Network:is_server() and Roguelike:hard_mode() and not train_trade() then
    managers.groupai:state():set_whisper_mode(false)
  end
end)
