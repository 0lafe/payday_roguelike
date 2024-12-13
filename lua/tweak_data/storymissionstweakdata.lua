-- Contains Overwrites and additions to career mode data
function StoryMissionsTweakData:_init_missions(tweak_data)
  -- game crash without this option but unused in the mod
  self.sm_2_skillpoints = 8

  -- global index trackers
  self.current_act_id = 0
  self.current_mission_id = 1

  self.tier_0_count = 3
  self.tier_1_count = 5
  self.tier_2_count = 7
  self.tier_3_count = 9
  self.tier_4_count = 11
  self.tier_5_count = 6

  -- how many weapons you get from the default reward
  self.weapons_per_reward = 1

  -- how many weapon mods you get from the default reward
  self.mods_per_reward = 10

  self.missions = {
    -- tier 0 divider
    self:_act({
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    }),

    -- tier 0 intro description
    self:_mission({
      reward_id = "menu_sm_perkdeck_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_perkdeck_reward(),
      completed = true,
      hide_progress = true,
      auto_complete = true,
      name_id = "sm_1_name",
      desc_id = "sm_1_desc",
      objective_id = "sm_1_obj"
    }),
  }

  -- create multiple tier 0 missions
  for _ = 1, self.tier_0_count do
    table.insert(self.missions,
      self:_mission({
        reward_id = "menu_sm_default_reward",
        voice_line = "Play_pln_stq_01",
        objectives = {},
        rewards = self:_default_reward(),
        tier = 0
      })
    )
  end

  -- tier 1 divider
  table.insert(self.missions,
    self:_act({
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    })
  )

  -- tier 1 intro description
  table.insert(self.missions,
    self:_mission({
      reward_id = "menu_sm_perkdeck_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_perkdeck_reward(),
      completed = true,
      hide_progress = true,
      tier_list = 1,
      auto_complete = true
    })
  )

  -- create multiple tier 1 missions
  for _ = 1, self.tier_1_count do
    table.insert(self.missions,
      self:_mission({
        reward_id = "menu_sm_default_reward",
        voice_line = "Play_pln_stq_01",
        objectives = {},
        rewards = self:_default_reward(),
        tier = 1
      })
    )
  end

  -- tier 2 divider
  table.insert(self.missions,
    self:_act({
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    })
  )

  -- tier 2 intro description
  table.insert(self.missions,
    self:_mission({
      reward_id = "menu_sm_perkdeck_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_perkdeck_reward(),
      completed = true,
      hide_progress = true,
      tier_list = 2,
      auto_complete = true
    })
  )

  -- create multiple tier 2 missions
  for _ = 1, self.tier_2_count do
    table.insert(self.missions,
      self:_mission({
        reward_id = "menu_sm_default_reward",
        voice_line = "Play_pln_stq_01",
        objectives = {},
        rewards = self:_default_reward(),
        tier = 2,
      })
    )
  end

  -- tier 3 divider
  table.insert(self.missions,
    self:_act({
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    })
  )

  -- tier 3 intro description
  table.insert(self.missions,
    self:_mission({
      reward_id = "menu_sm_perkdeck_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_perkdeck_reward(),
      completed = true,
      hide_progress = true,
      tier_list = 3,
      auto_complete = true
    })
  )

  -- create multiple tier 3 missions
  for _ = 1, self.tier_3_count do
    table.insert(self.missions,
      self:_mission({
        reward_id = "menu_sm_default_reward",
        voice_line = "Play_pln_stq_01",
        objectives = {},
        rewards = self:_default_reward(),
        tier = 3
      })
    )
  end

  -- tier 4 divider
  table.insert(self.missions,
    self:_act({
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    })
  )

  -- tier 4 intro description
  table.insert(self.missions,
    self:_mission({
      reward_id = "menu_sm_perkdeck_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_perkdeck_reward(),
      completed = true,
      hide_progress = true,
      tier_list = 4,
      auto_complete = true
    })
  )

  -- create multiple tier 4 missions
  for _ = 1, self.tier_4_count do
    table.insert(self.missions,
      self:_mission({
        reward_id = "menu_sm_default_reward",
        voice_line = "Play_pln_stq_01",
        objectives = {},
        rewards = self:_default_reward(),
        tier = 4
      })
    )
  end

  -- tier 5 divider
  table.insert(self.missions,
    self:_act({
      rewarded = true,
      completed = true,
      is_header = true,
      objectives = {}
    })
  )

  -- tier 5 intro description
  table.insert(self.missions,
    self:_mission({
      reward_id = "menu_sm_perkdeck_reward",
      voice_line = "Play_pln_stq_01",
      objectives = {},
      rewards = self:_perkdeck_reward(),
      completed = true,
      hide_progress = true,
      tier_list = 5,
      auto_complete = true
    })
  )

  -- create multiple tier 5 missions
  for _ = 1, self.tier_5_count do
    table.insert(self.missions,
      self:_mission({
        reward_id = "menu_sm_default_reward",
        voice_line = "Play_pln_stq_01",
        objectives = {},
        rewards = self:_default_reward(),
        tier = 5
      })
    )
  end

  -- WiP for ending information
  table.insert(self.missions,
    {
      id = "sm_end",
      rewarded = true,
      completed = true,
      last_mission = true,
      objectives = {},
      name_id = "sm_end_name",
      desc_id = "sm_end_desc",
      objective_id = "sm_end_obj"
    }
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
      "hotline_miami",
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
      "jewelry_store",
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
      "right_track",
    },
    [4] = {
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
      quantity = self.weapons_per_reward
    },
    {
      mod_reward = "random",
      quantity = self.mods_per_reward
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

function StoryMissionsTweakData:_act(data)
  local id = "sm_act_" .. self.current_act_id
  -- increment instance variable to automatically create unique ids
  self.current_act_id = self.current_act_id + 1

  return {
    id = id,
    rewarded = true,
    completed = true,
    is_header = true,
    objectives = {},
    name_id = id .. "_name",
    desc_id = id .. "_desc",
    objective_id = id .. "_obj"
  }
end

-- change how missions are built to be more dynamic
function StoryMissionsTweakData:_mission(data)
  local data = data or {}
  local id = "sm_" .. self.current_mission_id
  -- increment instance variable to automatically create unique ids
  self.current_mission_id = self.current_mission_id + 1

  data.id = id
  if data.tier then
    data.name_id = "roguelike_tier_" .. data.tier .. "_name"
    data.desc_id = "roguelike_tier_" .. data.tier .. "_desc"
    data.objective_id = "roguelike_tier_" .. data.tier .. "_obj"
  elseif data.tier_list then
    data.name_id = "roguelike_tier_" .. data.tier_list .. "_intro_title"
    data.desc_id = "roguelike_tier_" .. data.tier_list .. "_intro_desc"
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

  return data
end
