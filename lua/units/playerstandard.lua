-- force loud when hard mode enabled
Hooks:PostHook(PlayerStandard, "init", "toggle_forced_loud", function(self, unit)
  if Network:is_server() and Roguelike:hard_mode() then
    managers.groupai:state():set_whisper_mode(false)
  end
end)
