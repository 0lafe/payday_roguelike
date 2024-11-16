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
  for i = 15, 22 do
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
    self:_mission("sm_23", {
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
  for i = 24, 31 do
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

  -- tier divider
  table.insert(self.missions,
    self:_mission("sm_act_5", {
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    })
  )

  -- tier 4 intro description
  table.insert(self.missions,
    self:_mission("sm_32", {
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
  for i = 33, 37 do
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
      "bus_stop",
      "train_trade",
    },
    [1] = {
      "jewelry_store",
      "bank_heist",
      "nightclub",
      "counterfeit",
      "boat_load",
      "club_house",
      "art_gallery",
      "code_for_meth",
      "cook_off",
      "breaking_ballot",
    },
    [2] = {
      "hotline_miami",
      "four_floors",
      "undercover",
      "first_world_bank",
      "diamond_store",
      "breakfast_in_tijuana",
      "big_bank",
      "the_diamond",
      "dragon_heist",
      "interception",
      "no_mercy",
      "fbi_server",
      "hostile_takeover",
      "framing",
      "go_bank",
      "hoxton_revenge",
    },
    [3] = {
      "brooklyn_bank",
      "airport",
      "truck_load",
      "swing_vote",
      "engine_problems",
      "stealing_xmas",
      "panic_room",
      "santas_workshop",
      "bomb_dockyard",
      "mountain_master",
      "diamond_heist",
      "alaskan_deal",
      "shacklethorne_auction",
      "the_search",
      "alesso",
      "crude_awakening",
      "brooklyn_10_10",
    },
    [4] = {
      "right_track",
      "scarface_mansion",
      "heat_street",
      "hells_island",
      "beneath_the_mountain",
      "ukrainian_prisoner",
      "bulucs_mansion",
      "black_cat",
      "prison_nightmare",
      "bomb_forest",
      "meltdown",
      "aftershock",
      "highland_mortuary",
      "border_crystals",
      "san_martin",
      "midland_ranch",
      "lost_in_transit",
      "white_xmas",
    },
    [5] = {
      "the_breakout",
      "goat_simulator",
      "transport_train",
      "slaughterhouse",
      "white_house",
      "henrys_rock",
      "border_crossing",
      "birth_of_sky",
      "lions_den",
      "garnet_group_boutique",
      "green_bridge",
      "lab_rats",
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

-- checks if a heist is in a given tier
function StoryMissionsTweakData:heist_in_tier(mission_tier, heist_name)
  local output = false
  for _, v in pairs(self._heist_pool[mission_tier]) do
    if v == heist_name then
      output = true
    end
  end
  return output
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

-- method for attaching job id data to mission objectives
function StoryMissionsTweakData:_level_progress(progress_id, ...)
  local tweak_data = self._tweak_data or tweak_data
  local data = self:_progress("story_" .. progress_id, ...)
  local heist_data = tweak_data.roguelike.missions[progress_id]

  if not heist_data then
    return data
  end

  data.levels = data.levels or heist_data.job and {
    heist_data.job
  }
  data.single_day_id = heist_data.day_id

  return data
end
