-- Prevent jobs from appearing on crimenet
function CrimeNetGui:add_preset_job(preset_id)
end

-- Adds tier data to servers
Hooks:PostHook(CrimeNetGui, "add_server_job", "add_tier_to_criment_lobbies", function(self, data)
  local job_index = data.id
  local job = self._jobs[job_index]

  if not job then
    return
  end

  if job.side_panel then
    local mission_name = tweak_data.roguelike:get_mission_name(data.job_id)
    local mission_tier = tweak_data.story:get_mission_tier(mission_name)
    local job_name = job.side_panel:child("job_name")

    job_name:set_text(
      managers.localization:to_upper_text("menu_sm_" .. mission_name) .. " (Tier " .. mission_tier .. ")"
    )
    local _, _, w, h = job_name:text_rect()

    job_name:set_size(w, h)
  end
end)
