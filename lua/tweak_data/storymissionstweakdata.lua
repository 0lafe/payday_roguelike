-- Overwrites and additions to career mode data
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

  table.insert(self.missions,
    self:_mission("sm_act_2", {
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    })
  )
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

  table.insert(self.missions,
    self:_mission("sm_act_3", {
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    })
  )
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

  table.insert(self.missions,
    self:_mission("sm_act_4", {
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    })
  )
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

  table.insert(self.missions,
    self:_mission("sm_end", {
      rewarded = true,
      completed = true,
      last_mission = true,
      objectives = {}
    })
  )

  self._heist_pool = {
    [0] = {
      "four_store",
      "ukrainian_job",
      "mallcrasher"
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
      "undercover",
      "panic_room",
      "first_world_bank",
      "diamond_heist",
      "diamond_store",
      "brooklyn_bank",
      "breakfast_in_tijuana",
      "big_bank",
      "the_diamond",
      "hotline_miami",
      "election_day",
      "dragon_heist"
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
end

-- reward for initially unlocking copycat
function StoryMissionsTweakData:_initial_reward()
  return {
    {
      perkdeck_reward = "first_deck"
    }
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

function StoryMissionsTweakData:_copycat_card_reward()
  return {
    {
      copycat_reward = "new_card"
    }
  }
end

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
