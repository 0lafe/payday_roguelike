Hooks:PostHook(NarrativeTweakData, "init", "roguelike_init_narrative_tweak_data", function(self, tweak_data)
  self.jobs.breaking_ballot = deep_clone(self.jobs.election_day)
  self.jobs.breaking_ballot.name_id = "heist_election_day_3_hl"
  self.jobs.breaking_ballot.crimenet_videos = { "cn_elcday3" }
  self.jobs.breaking_ballot.chain = {
    {
      level_id = "election_day_3",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.right_track = deep_clone(self.jobs.election_day)
  self.jobs.right_track.name_id = "heist_election_day_1_hl"
  self.jobs.right_track.crimenet_videos = { "cn_elcday1" }
  self.jobs.right_track.chain = {
    {
      level_id = "election_day_1",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.swing_vote = deep_clone(self.jobs.election_day)
  self.jobs.swing_vote.name_id = "heist_election_day_2_hl"
  self.jobs.swing_vote.crimenet_videos = { "cn_elcday2" }
  self.jobs.swing_vote.chain = {
    {
      level_id = "election_day_2",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.framing_frame_1 = deep_clone(self.jobs.framing_frame)
  self.jobs.framing_frame_1.name_id = "heist_framing_frame_1_hl"
  self.jobs.framing_frame_1.crimenet_videos = { "cn_framingframe1" }
  self.jobs.framing_frame_1.chain = {
    {
      level_id = "framing_frame_1",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.train_trade = deep_clone(self.jobs.framing_frame)
  self.jobs.train_trade.name_id = "heist_framing_frame_2_hl"
  self.jobs.train_trade.crimenet_videos = { "cn_framingframe2" }
  self.jobs.train_trade.chain = {
    {
      level_id = "framing_frame_2",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.framing = deep_clone(self.jobs.framing_frame)
  self.jobs.framing.name_id = "heist_framing_frame_3_hl"
  self.jobs.framing.crimenet_videos = { "cn_framingframe3" }
  self.jobs.framing.chain = {
    {
      level_id = "framing_frame_3",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.lions_den = deep_clone(self.job.born)
  self.jobs.lions_den.name_id = "heist_born_hl"
  self.jobs.lions_den.crimenet_videos = { "cn_elcday1" }
  self.jobs.lions_den.chain = {
    {
      level_id = "born",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.interception = deep_clone(self.job.born)
  self.jobs.interception.name_id = "heist_chew_hl"
  self.jobs.interception.crimenet_videos = { "cn_elcday2" }
  self.jobs.interception.chain = {
    {
      level_id = "chew",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.hotline_miami = deep_clone(self.job.mia)
  self.jobs.hotline_miami.name_id = "heist_mia_1_hl"
  self.jobs.hotline_miami.crimenet_videos = { "cn_hlm1" }
  self.jobs.hotline_miami.chain = {
    {
      level_id = "mia_1",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.four_floors = deep_clone(self.job.mia)
  self.jobs.four_floors.name_id = "heist_mia_2_hl"
  self.jobs.four_floors.crimenet_videos = { "cn_hlm2" }
  self.jobs.four_floors.chain = {
    {
      level_id = "mia_2",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.truck_load = deep_clone(self.job.watchdogs)
  self.jobs.truck_load.name_id = "heist_watchdogs_1_d_hl"
  self.jobs.truck_load.crimenet_videos = { "cn_hlm2" }
  self.jobs.truck_load.chain = {
    {
      level_id = "watchdogs_1_d",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.boat_load = deep_clone(self.job.watchdogs)
  self.jobs.boat_load.name_id = "heist_watchdogs_2_n_hl"
  self.jobs.boat_load.crimenet_videos = { "cn_hlm2" }
  self.jobs.boat_load.chain = {
    {
      level_id = "watchdogs_2_n",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.the_breakout = deep_clone(self.job.hox)
  self.jobs.the_breakout.name_id = "heist_hox_1_hl"
  self.jobs.the_breakout.crimenet_videos = { "cn_hox1" }
  self.jobs.the_breakout.chain = {
    {
      level_id = "hox_1",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.the_search = deep_clone(self.job.hox)
  self.jobs.the_search.name_id = "heist_hox_2_hl"
  self.jobs.the_search.crimenet_videos = { "cn_hox2" }
  self.jobs.the_search.chain = {
    {
      level_id = "hox_2",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.the_search = deep_clone(self.job.hox)
  self.jobs.the_search.name_id = "heist_hox_2_hl"
  self.jobs.the_search.crimenet_videos = { "cn_hox2" }
  self.jobs.the_search.chain = {
    {
      level_id = "hox_2",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.airport = deep_clone(self.job.firestarter)
  self.jobs.airport.name_id = "heist_firestarter_1_hl"
  self.jobs.airport.crimenet_videos = { "cn_fires1" }
  self.jobs.airport.chain = {
    {
      level_id = "firestarter_1",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.fbi_server = deep_clone(self.job.firestarter)
  self.jobs.fbi_server.name_id = "heist_firestarter_2_hl"
  self.jobs.fbi_server.crimenet_videos = { "cn_fires2" }
  self.jobs.fbi_server.chain = {
    {
      level_id = "firestarter_2",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.bank_heist_good = deep_clone(self.job.firestarter)
  self.jobs.bank_heist_good.name_id = "heist_firestarter_3_hl"
  self.jobs.bank_heist_good.crimenet_videos = { "cn_fires3" }
  self.jobs.bank_heist_good.chain = {
    {
      level_id = "firestarter_3",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.club_house = deep_clone(self.job.welcome_to_the_jungle_wrapper_prof)
  self.jobs.club_house.name_id = "heist_welcome_to_the_jungle_1_d_hl"
  self.jobs.club_house.crimenet_videos = { "cn_fires3" }
  self.jobs.club_house.chain = {
    {
      level_id = "welcome_to_the_jungle_1_d",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.engine_problems = deep_clone(self.job.welcome_to_the_jungle_wrapper_prof)
  self.jobs.engine_problems.name_id = "heist_welcome_to_the_jungle_2_hl"
  self.jobs.engine_problems.crimenet_videos = { "cn_fires3" }
  self.jobs.engine_problems.chain = {
    {
      level_id = "welcome_to_the_jungle_2",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.cook_off = deep_clone(self.job.alex)
  self.jobs.cook_off.name_id = "heist_alex_1_hl"
  self.jobs.cook_off.crimenet_videos = { "cn_rat1" }
  self.jobs.cook_off.chain = {
    {
      level_id = "alex_1",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.code_for_meth = deep_clone(self.job.alex)
  self.jobs.code_for_meth.name_id = "heist_alex_2_hl"
  self.jobs.code_for_meth.crimenet_videos = { "cn_rat2" }
  self.jobs.code_for_meth.chain = {
    {
      level_id = "alex_2",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.bus_stop = deep_clone(self.job.alex)
  self.jobs.bus_stop.name_id = "heist_alex_3_hl"
  self.jobs.bus_stop.crimenet_videos = { "cn_rat3" }
  self.jobs.bus_stop.chain = {
    {
      level_id = "alex_3",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.highland_mortuary = deep_clone(self.job.rvd)
  self.jobs.highland_mortuary.name_id = "heist_rvd_1_hl"
  self.jobs.highland_mortuary.crimenet_videos = { "cn_rat1" }
  self.jobs.highland_mortuary.chain = {
    {
      level_id = "rvd_1",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  self.jobs.garnet_group_boutique = deep_clone(self.job.rvd)
  self.jobs.garnet_group_boutique.name_id = "heist_rvd_2_hl"
  self.jobs.garnet_group_boutique.crimenet_videos = { "cn_rat1" }
  self.jobs.garnet_group_boutique.chain = {
    {
      level_id = "rvd_2",
      type_id = "heist_type_knockover",
      type = "d",
    }
  }

  table.insert(self._jobs_index, "breaking_ballot")
  table.insert(self._jobs_index, "right_track")
  table.insert(self._jobs_index, "swing_vote")
  table.insert(self._jobs_index, "framing_frame_1")
  table.insert(self._jobs_index, "train_trade")
  table.insert(self._jobs_index, "framing")
  table.insert(self._jobs_index, "lions_den")
  table.insert(self._jobs_index, "interception")
  table.insert(self._jobs_index, "hotline_miami")
  table.insert(self._jobs_index, "four_floors")
  table.insert(self._jobs_index, "truck_load")
  table.insert(self._jobs_index, "boat_load")
  table.insert(self._jobs_index, "the_breakout")
  table.insert(self._jobs_index, "the_search")
  table.insert(self._jobs_index, "airport")
  table.insert(self._jobs_index, "fbi_server")
  table.insert(self._jobs_index, "bank_heist_good")
  table.insert(self._jobs_index, "club_house")
  table.insert(self._jobs_index, "engine_problems")
  table.insert(self._jobs_index, "cook_off")
  table.insert(self._jobs_index, "code_for_meth")
  table.insert(self._jobs_index, "bus_stop")
  table.insert(self._jobs_index, "highland_mortuary")
  table.insert(self._jobs_index, "garnet_group_boutique")
end)
