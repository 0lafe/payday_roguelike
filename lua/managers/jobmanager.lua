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
  managers.story:award_roguelike(self:current_job_id(), self._global.current_job.current_stage)
end
