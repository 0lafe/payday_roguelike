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
