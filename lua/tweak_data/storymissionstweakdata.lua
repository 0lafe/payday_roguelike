-- Overwrites and additions to career mode data
function StoryMissionsTweakData:_init_missions(tweak_data)
  self.sm_2_skillpoints = 8
  self.missions = {
    self:_mission("sm_act_1", {
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    }),
    self:_mission("sm_1", {
      reward_id = "menu_sm_unlock_copycat",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_initial_reward(),
      completed = true,
      hide_progress = true
    }),
    self:_mission("sm_2", {
      reward_id = "menu_sm_default_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_default_reward(),
      tier = 0
    })
  }
  -- create multiple tier 1 missions
  for i = 3, 10 do
    table.insert(self.missions,
      self:_mission("sm_" .. i, {
        reward_id = "menu_sm_default_reward",
        voice_line = "Play_pln_stq_01",
        objectives = {},
        rewards = self:_default_reward(),
        tier = 1
      })
    )
  end
  table.insert(self.missions,
    self:_mission("sm_end", {
      rewarded = true,
      completed = true,
      last_mission = true,
      objectives = {}
    })
  )

  self._heist_pool = {
    {
      "four_store",
      "ukrainian_job",
      "mallcrasher"
    },
    {
      "go_bank",
      "jewelry_store",
      "bank_heist",
      "nightclub",
    }
  }
end

-- reward for initially unlocking copycat
function StoryMissionsTweakData:_initial_reward()
  return {
    {
      copycat_reward = "unlock_deck"
    }
  }
end

-- standard reward for most heists
function StoryMissionsTweakData:_default_reward()
  return {
    {
      copycat_reward = "new_card"
    },
    {
      weapon_reward = "random",
      quantity = 2
    },
    {
      mod_reward = "random",
      quantity = 5
    }
  }
end

-- heist pools set by tier
function StoryMissionsTweakData:heist_pool(mission_tier)
  return self._heist_pool[mission_tier + 1]
end

-- change how missions are built to be more dynamic
function StoryMissionsTweakData:_mission(id, data)
  data = data or {}
  data.id = id
  if data.tier then
    data.name_id = "roguelike_tier_" .. data.tier .. "_name"
    data.desc_id = "roguelike_tier_" .. data.tier .. "_desc"
    data.objective_id = "roguelike_tier_" .. data.tier .. "_obj"
  else
    data.name_id = id .. "_name"
    data.desc_id = id .. "_desc"
    data.objective_id = id .. "_obj"
  end

  return data
end
