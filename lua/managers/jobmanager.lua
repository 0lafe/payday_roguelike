function JobManager:is_job_finished()
  return self._global.roguelike_completed_job or false
end

function JobManager:next_stage()
  if not self:has_active_job() then
    return
  end

  if not self._is_synced_from_server then
    self._global.current_job.last_completed_stage = self._global.current_job.current_stage
    self._global.interupt_stage = nil
  end

  self._global.roguelike_completed_job = true
  managers.story:award_roguelike(self:current_job_id(), self:current_stage())
end

Hooks:PostHook(JobManager, "_setup", "roguelike_jobmanager_setup", function(self)
  if self:current_job_id() == "framing_frame" and self:current_stage() == 2 then
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
