Hooks:PostHook(JobManager, "_setup", "roguelike_jobmanager_setup", function(self)
  if self:current_job_id() == "train_trade" then
    for _ = 1, 4 + math.random(5) do
      table.insert(managers.loot._distribution_loot, {
        daily_art = true,
        challenge_art_ghost = true,
        carry_id = "painting",
        multiplier = 1,
        peer_id = 1
      })
    end
  end
end)

Hooks:PostHook(JobManager, "next_stage", "roguelike_complete_job_hook", function(self)
  managers.story:award_roguelike(self:current_job_id())
end)

-- Get some vanilla projob funcitonality if projob is enabled
function JobManager:is_current_job_professional()
  if not self._global.current_job then
    return
  end

  return Roguelike:pro_job()
end
