local function blacklisted_heist()
  local blacklist = {
    train_trade = true
  }
  return blacklist[managers.job:current_job_id()] or false
end

-- force loud when hard mode enabled
Hooks:PostHook(PlayerStandard, "init", "toggle_forced_loud", function(self, unit)
  if Network:is_server() and Roguelike:hard_mode() and not blacklisted_heist() then
    managers.groupai:state():on_police_called("met_criminal")
  end
end)
