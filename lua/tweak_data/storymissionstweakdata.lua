-- Contains Overwrites and additions to career mode data
function StoryMissionsTweakData:_init_missions(tweak_data)
  self.sm_2_skillpoints = 8
  self.missions = {
    self:_mission("sm_act_0", {
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    }),
    self:_mission("sm_1", {
      reward_id = "menu_sm_perkdeck_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_perkdeck_reward(),
      completed = true,
      hide_progress = true,
      auto_complete = true
    }),
    self:_mission("sm_2", {
      reward_id = "menu_sm_default_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_default_reward(),
      tier = 0
    }),
    self:_mission("sm_act_1", {
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    }),
    self:_mission("sm_3", {
      reward_id = "menu_sm_perkdeck_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_perkdeck_reward(),
      completed = true,
      hide_progress = true,
      tier_list = true,
      list_tier = 1,
      auto_complete = true
    }),
  }

  -- create multiple tier 1 missions
  for i = 4, 6 do
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

  -- tier divider
  table.insert(self.missions,
    self:_mission("sm_act_2", {
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    })
  )

  -- tier 2 intro description
  table.insert(self.missions,
    self:_mission("sm_7", {
      reward_id = "menu_sm_perkdeck_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_perkdeck_reward(),
      completed = true,
      hide_progress = true,
      tier_list = true,
      list_tier = 2,
      auto_complete = true
    })
  )
  -- create multiple tier 2 missions
  for i = 8, 13 do
    table.insert(self.missions,
      self:_mission("sm_" .. i, {
        reward_id = "menu_sm_default_reward",
        voice_line = "Play_pln_stq_01",
        objectives = {},
        rewards = self:_default_reward(),
        tier = 2,
      })
    )
  end

  -- tier divider
  table.insert(self.missions,
    self:_mission("sm_act_3", {
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    })
  )

  -- tier 3 intro description
  table.insert(self.missions,
    self:_mission("sm_14", {
      reward_id = "menu_sm_perkdeck_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_perkdeck_reward(),
      completed = true,
      hide_progress = true,
      tier_list = true,
      list_tier = 3,
      auto_complete = true
    })
  )

  -- create multiple tier 3 missions
  for i = 15, 24 do
    table.insert(self.missions,
      self:_mission("sm_" .. i, {
        reward_id = "menu_sm_default_reward",
        voice_line = "Play_pln_stq_01",
        objectives = {},
        rewards = self:_default_reward(),
        tier = 3
      })
    )
  end

  -- tier divider
  table.insert(self.missions,
    self:_mission("sm_act_4", {
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    })
  )

  -- tier 4 intro description
  table.insert(self.missions,
    self:_mission("sm_25", {
      reward_id = "menu_sm_perkdeck_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_perkdeck_reward(),
      completed = true,
      hide_progress = true,
      tier_list = true,
      list_tier = 4,
      auto_complete = true
    })
  )

  -- create multiple tier 4 missions
  for i = 26, 29 do
    table.insert(self.missions,
      self:_mission("sm_" .. i, {
        reward_id = "menu_sm_default_reward",
        voice_line = "Play_pln_stq_01",
        objectives = {},
        rewards = self:_default_reward(),
        tier = 4
      })
    )
  end

  -- WiP for ending information
  table.insert(self.missions,
    self:_mission("sm_end", {
      rewarded = true,
      completed = true,
      last_mission = true,
      objectives = {}
    })
  )

  -- Main list of heist pool by tier
  self._heist_pool = {
    [0] = {
      "four_store",
      "ukrainian_job",
      "mallcrasher",
      "cursed_kill_room"
    },
    [1] = {
      "go_bank",
      "jewelry_store",
      "bank_heist",
      "nightclub",
      "hoxton_revenge",
      "counterfeit"
    },
    [2] = {
      "hotline_miami",
      "four_floors"
    },
    [3] = {
      "alaskan_deal",
      "mountain_master",
      "scarface_mansion",
      "heat_street",
      "hells_island",
      "shacklethorne_auction",
      "beneath_the_mountain",
      "birth_of_sky",
      "ukrainian_prisoner",
      "brooklyn_10_10",
      "biker_heist",
      "reservoir_dogs",
      "bulucs_mansion",
      "black_cat",
      "prison_nightmare"
    },
    [4] = {
      "goat_simulator",
      "transport_train",
      "slaughterhouse",
      "white_house",
      "henrys_rock",
    }
  }

  self.heist_days = {
    hotline_miami = 1,
    four_floors = 2
  }
end

-- standard reward for most heists
function StoryMissionsTweakData:_default_reward()
  return {
    {
      weapon_reward = "random",
      quantity = 1
    },
    {
      mod_reward = "random",
      quantity = 10
    }
  }
end

-- gives a perk deck to the player
function StoryMissionsTweakData:_perkdeck_reward()
  return {
    {
      perkdeck_reward = "new_deck"
    }
  }
end

-- heist pools set by tier
function StoryMissionsTweakData:heist_pool(mission_tier)
  return self._heist_pool[mission_tier]
end

-- change how missions are built to be more dynamic
function StoryMissionsTweakData:_mission(id, data)
  data = data or {}
  data.id = id
  if data.tier then
    data.name_id = "roguelike_tier_" .. data.tier .. "_name"
    data.desc_id = "roguelike_tier_" .. data.tier .. "_desc"
    data.objective_id = "roguelike_tier_" .. data.tier .. "_obj"
  elseif data.tier_list then
    data.name_id = "roguelike_tier_" .. data.list_tier .. "_intro_title"
    data.desc_id = "roguelike_tier_" .. data.list_tier .. "_intro_desc"
  else
    data.name_id = id .. "_name"
    data.desc_id = id .. "_desc"
    data.objective_id = id .. "_obj"
  end

  return data
end
