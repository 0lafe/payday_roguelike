-- handle custom reward logic
function StoryMissionsManager:_reward(reward)
	if reward.perkdeck_reward then
		managers.roguelike:add_perkdeck(1)
	elseif reward.weapon_reward then
		managers.roguelike:add_weapons(reward.quantity)
	elseif reward.mod_reward then
		managers.roguelike:add_weapon_mods(reward.quantity)
	else
		Application:error("[Story] Failed to give reward")
	end
	managers.savefile:save_progress()
end

-- removes default award logic
function StoryMissionsManager:award(id, steps)
end

-- re-does completion logic a bit to handle better COOP and single day heists
function StoryMissionsManager:award_roguelike(job_id, job_stage)
	local current_mission = self:current_mission() or {}

	if current_mission.completed then
		return
	end

	local job_name = nil
	for k, v in pairs(tweak_data.roguelike.missions) do
		if v.job and v.job == job_id then
			if v.day_id then
				if v.day_id == job_stage then
					job_name = k
				end
			else
				job_name = k
			end
		end
	end

	local objective = current_mission.objectives_flat and current_mission.objectives_flat["story_" .. job_name]

	-- if client it completes the objective if its in the same tier as your current mission
	if Network:is_client() then
		if current_mission.tier then
			if tweak_data.story:heist_in_tier(current_mission.tier, job_name) then
				for _, v in pairs(current_mission.objectives_flat) do
					objective = v
					objective.completed = true
				end
			end
		end
	else
		if objective and not objective.completed then
			objective.completed = true
		end
	end

	if objective and objective.completed then
		self:_check_complete(current_mission)
	end
end

-- Overwrite with logic for hardmode
function StoryMissionsManager:start_mission(mission, objective_id)
	if mission.completed then
		return
	end

	local m = self:_get_or_current(mission) or {
		objectives_flat = {}
	}
	local o = nil

	if not objective_id then
		local left_to_do = table.filter_list(m.objectives_flat, function(o)
			return not o.completed
		end)
		o = table.random(left_to_do)
	else
		o = objective_id and m.objectives_flat[objective_id]
	end

	if not o then
		return
	end

	local level = table.random(o.levels or {})

	if not level then
		return
	end

	if Global.game_settings.single_player then
		MenuCallbackHandler:play_single_player()
	else
		MenuCallbackHandler:play_online_game()
	end

	local difficulty = "normal"
	local customize_difficulty = true
	if Roguelike:hard_mode() then
		difficulty = "sm_wish"
		customize_difficulty = false
	end

	local job_data = tweak_data.narrative:job_data(level)
	local data = {
		customize_difficulty = customize_difficulty,
		difficulty = difficulty,
		difficulty_id = tweak_data:difficulty_to_index(difficulty),
		job_id = level,
		contract_visuals = job_data and job_data.contract_visuals,
	}
	self._global.story_level_opened = level

	managers.menu:open_node(
		Global.game_settings.single_player and "crimenet_contract_singleplayer" or "crimenet_contract_host", {
			data
		})
end

-- helper to get previous mission in order
function StoryMissionsManager:previous_mission(mission)
	local previous_index = nil
	for k, v in pairs(self:missions_in_order()) do
		if v.id == mission.id then
			previous_index = k - 1
		end
	end

	if previous_index then
		return self:get_mission_at(previous_index)
	end
end
