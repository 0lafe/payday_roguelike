-- handle custom reward logic
function StoryMissionsManager:_reward(reward)
	if reward.copycat_reward then
		if reward.copycat_reward == "unlock_deck" then
			managers.roguelike:unlock_copycat()
		elseif reward.copycat_reward == "new_card" then
			managers.roguelike:add_copycat_card()
		end
	elseif reward.weapon_reward then
		managers.roguelike:add_weapons(reward.quantity)
	elseif reward.mod_reward then
		managers.roguelike:add_weapon_mods(reward.quantity)
	else
		Application:error("[Story] Failed to give reward")
	end
end

-- temp fix for preventing starting heists when mission is completed
local old_start_mission = StoryMissionsManager.start_mission
function StoryMissionsManager:start_mission(mission, objective_id)
	if mission.completed then
		return
	end

	old_start_mission(self, mission, objective_id)
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
