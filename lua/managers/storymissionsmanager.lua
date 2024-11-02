-- handle custom reward logic
function StoryMissionsManager:_reward(reward)
	if reward.perkdeck_reward then
		managers.roguelike:add_perkdeck()
	elseif reward.weapon_reward then
		managers.roguelike:add_weapons(reward.quantity)
	elseif reward.mod_reward then
		managers.roguelike:add_weapon_mods(reward.quantity)
	else
		Application:error("[Story] Failed to give reward")
	end
	managers.savefile:save_progress()
end

-- redoes completion logic a bit to handle better COOP
function StoryMissionsManager:award(id, steps)
	steps = steps or 1
	local m = self:current_mission() or {}
	local o = m.objectives_flat and m.objectives_flat[id]

	-- completes the objective if you complete a heist of the same tier
	if id and m.tier and Network:is_client() and not o then
		local tier_pool = tweak_data.story:heist_pool(m.tier)
		local completed_heist = id:gsub("story_", "")
		for _, heist in pairs(tier_pool) do
			if heist == completed_heist then
				for k, _ in pairs(m.objectives_flat) do
					o = m.objectives_flat[k]
					break
				end
				break
			end
		end
	end

	if not o or o.completed then
		return
	end

	o.progress = o.progress + 1

	print("[Story]", "progress", id, o.progress)

	if o.max_progress <= o.progress then
		print("[Story]", "objective complete", id, o.progress, o.max_progress)

		o.completed = true
		o.progress = o.max_progress

		self:_check_complete(m)
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
		contract_visuals = job_data and job_data.contract_visuals
	}
	self._global.story_level_opened = level

	managers.menu:open_node(
		Global.game_settings.single_player and "crimenet_contract_singleplayer" or "crimenet_contract_host", {
			data
		})
end
