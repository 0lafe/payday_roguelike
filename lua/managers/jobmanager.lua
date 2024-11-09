-- function JobManager:is_job_finished()
--   return true
-- end

-- function JobManager:next_stage()
--   if not self:has_active_job() then
--     return
--   end

--   if not self._is_synced_from_server then
--     self._global.current_job.last_completed_stage = self._global.current_job.current_stage
--     self._global.interupt_stage = nil
--   end

--   if self:is_job_finished() and not self._global.next_interupt_stage then
--     self:_check_add_to_cooldown()
--     managers.achievment:award("no_turning_back")

--     return
--   end

--   if not self._is_synced_from_server then
--     self._global.alternative_stage = self._global.next_alternative_stage
--   end

--   self._global.next_alternative_stage = nil

--   if not self._is_synced_from_server then
--     self._global.interupt_stage = self._global.next_interupt_stage
--   end

--   self._global.next_interupt_stage = nil

--   if not self._global.interupt_stage and not self._is_synced_from_server then
--     self:set_current_stage(self._global.current_job.current_stage + 1)
--   end

--   Global.game_settings.level_id = managers.job:current_level_id()
--   Global.game_settings.mission = managers.job:current_mission()
--   Global.game_settings.world_setting = managers.job:current_world_setting()

--   if Network:is_server() then
--     MenuCallbackHandler:update_matchmake_attributes()

--     local level_id_index = tweak_data.levels:get_index_from_level_id(Global.game_settings.level_id)
--     local interupt_level_id_index = self._global.interupt_stage and
--     tweak_data.levels:get_index_from_level_id(self._global.interupt_stage) or 0

--     managers.network:session():send_to_peers("sync_stage_settings", level_id_index,
--       self._global.current_job.current_stage, self._global.alternative_stage or 0, interupt_level_id_index)
--   end
-- end
