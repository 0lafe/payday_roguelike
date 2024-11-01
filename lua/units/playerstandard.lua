-- force loud when hard mode enabled
Hooks:PostHook(PlayerStandard, "init", "toggle_forced_loud", function(self, unit)
  if Roguelike:hard_mode() then
    managers.groupai:state():set_whisper_mode(false)
  end
end)
