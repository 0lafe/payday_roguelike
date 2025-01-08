if not tweak_data then return end

tweak_data.narrative.jobs.right_track = deep_clone(tweak_data.narrative.jobs.election_day)
tweak_data.narrative.jobs.right_track.original_id = "election_day"
tweak_data.narrative.jobs.right_track.name_id = "heist_election_day_1_hl"
tweak_data.narrative.jobs.right_track.chain = {
  tweak_data.narrative.stages.election_day_1
}

tweak_data.narrative.jobs.swing_vote = deep_clone(tweak_data.narrative.jobs.election_day)
tweak_data.narrative.jobs.swing_vote.original_id = "election_day"
tweak_data.narrative.jobs.swing_vote.name_id = "heist_election_day_2_hl"
tweak_data.narrative.jobs.swing_vote.chain = {
  tweak_data.narrative.stages.election_day_2
}

tweak_data.narrative.jobs.breaking_ballot = deep_clone(tweak_data.narrative.jobs.election_day)
tweak_data.narrative.jobs.breaking_ballot.original_id = "election_day"
tweak_data.narrative.jobs.breaking_ballot.name_id = "heist_election_day_3_hl"
tweak_data.narrative.jobs.breaking_ballot.chain = {
  tweak_data.narrative.stages.election_day_3
}

tweak_data.narrative.jobs.framing_frame_1 = deep_clone(tweak_data.narrative.jobs.framing_frame)
tweak_data.narrative.jobs.framing_frame_1.original_id = "framing_frame"
tweak_data.narrative.jobs.framing_frame_1.name_id = "heist_framing_frame_1_hl"
tweak_data.narrative.jobs.framing_frame_1.chain = {
  tweak_data.narrative.stages.framing_frame_1
}

tweak_data.narrative.jobs.train_trade = deep_clone(tweak_data.narrative.jobs.framing_frame)
tweak_data.narrative.jobs.train_trade.original_id = "framing_frame"
tweak_data.narrative.jobs.train_trade.name_id = "heist_framing_frame_2_hl"
tweak_data.narrative.jobs.train_trade.chain = {
  tweak_data.narrative.stages.framing_frame_2
}

tweak_data.narrative.jobs.framing = deep_clone(tweak_data.narrative.jobs.framing_frame)
tweak_data.narrative.jobs.framing.original_id = "framing_frame"
tweak_data.narrative.jobs.framing.name_id = "heist_framing_frame_3_hl"
tweak_data.narrative.jobs.framing.chain = {
  tweak_data.narrative.stages.framing_frame_3
}

tweak_data.narrative.jobs.lions_den = deep_clone(tweak_data.narrative.jobs.born)
tweak_data.narrative.jobs.lions_den.original_id = "born"
tweak_data.narrative.jobs.lions_den.name_id = "heist_born_hl"
tweak_data.narrative.jobs.lions_den.chain = {
  tweak_data.narrative.stages.born
}

tweak_data.narrative.jobs.interception = deep_clone(tweak_data.narrative.jobs.born)
tweak_data.narrative.jobs.interception.original_id = "born"
tweak_data.narrative.jobs.interception.name_id = "heist_chew_hl"
tweak_data.narrative.jobs.interception.chain = {
  tweak_data.narrative.stages.chew
}

tweak_data.narrative.jobs.hotline_miami = deep_clone(tweak_data.narrative.jobs.mia)
tweak_data.narrative.jobs.hotline_miami.original_id = "mia"
tweak_data.narrative.jobs.hotline_miami.name_id = "heist_mia_1_hl"
tweak_data.narrative.jobs.hotline_miami.chain = {
  tweak_data.narrative.stages.mia_1
}

tweak_data.narrative.jobs.four_floors = deep_clone(tweak_data.narrative.jobs.mia)
tweak_data.narrative.jobs.four_floors.original_id = "mia"
tweak_data.narrative.jobs.four_floors.name_id = "heist_mia_2_hl"
tweak_data.narrative.jobs.four_floors.chain = {
  tweak_data.narrative.stages.mia_2
}

tweak_data.narrative.jobs.truck_load_day = deep_clone(tweak_data.narrative.jobs.watchdogs_wrapper)
tweak_data.narrative.jobs.truck_load_day.original_id = "watchdogs"
tweak_data.narrative.jobs.truck_load_day.job_wrapper = nil
tweak_data.narrative.jobs.truck_load_day.name_id = "heist_watchdogs_1_hl"
tweak_data.narrative.jobs.truck_load_day.chain = {
  tweak_data.narrative.stages.watchdogs_1_d
}

tweak_data.narrative.jobs.truck_load_night = deep_clone(tweak_data.narrative.jobs.watchdogs_wrapper)
tweak_data.narrative.jobs.truck_load_night.original_id = "watchdogs"
tweak_data.narrative.jobs.truck_load_night.job_wrapper = nil
tweak_data.narrative.jobs.truck_load_night.name_id = "heist_watchdogs_1_night_hl"
tweak_data.narrative.jobs.truck_load_night.chain = {
  tweak_data.narrative.stages.watchdogs_1_n
}

tweak_data.narrative.jobs.boat_load_night = deep_clone(tweak_data.narrative.jobs.watchdogs_wrapper)
tweak_data.narrative.jobs.boat_load_night.original_id = "watchdogs"
tweak_data.narrative.jobs.boat_load_night.job_wrapper = nil
tweak_data.narrative.jobs.boat_load_night.name_id = "heist_watchdogs_2_hl"
tweak_data.narrative.jobs.boat_load_night.chain = {
  tweak_data.narrative.stages.watchdogs_2_n
}

tweak_data.narrative.jobs.boat_load_day = deep_clone(tweak_data.narrative.jobs.watchdogs_wrapper)
tweak_data.narrative.jobs.boat_load_day.original_id = "watchdogs"
tweak_data.narrative.jobs.boat_load_day.job_wrapper = nil
tweak_data.narrative.jobs.boat_load_day.name_id = "heist_watchdogs_2_day_hl"
tweak_data.narrative.jobs.boat_load_day.chain = {
  tweak_data.narrative.stages.watchdogs_2_d
}

tweak_data.narrative.jobs.the_breakout = deep_clone(tweak_data.narrative.jobs.hox)
tweak_data.narrative.jobs.the_breakout.original_id = "watchdogs"
tweak_data.narrative.jobs.the_breakout.name_id = "heist_hox_1_hl"
tweak_data.narrative.jobs.the_breakout.chain = {
  tweak_data.narrative.stages.hox_1
}

tweak_data.narrative.jobs.the_search = deep_clone(tweak_data.narrative.jobs.hox)
tweak_data.narrative.jobs.the_search.original_id = "watchdogs"
tweak_data.narrative.jobs.the_search.name_id = "heist_hox_2_hl"
tweak_data.narrative.jobs.the_search.chain = {
  tweak_data.narrative.stages.hox_2
}

tweak_data.narrative.jobs.airport = deep_clone(tweak_data.narrative.jobs.firestarter)
tweak_data.narrative.jobs.airport.original_id = "firestarter"
tweak_data.narrative.jobs.airport.name_id = "heist_firestarter_1_hl"
tweak_data.narrative.jobs.airport.chain = {
  tweak_data.narrative.stages.firestarter_1
}

tweak_data.narrative.jobs.fbi_server = deep_clone(tweak_data.narrative.jobs.firestarter)
tweak_data.narrative.jobs.fbi_server.original_id = "firestarter"
tweak_data.narrative.jobs.fbi_server.name_id = "heist_firestarter_2_hl"
tweak_data.narrative.jobs.fbi_server.chain = {
  tweak_data.narrative.stages.firestarter_2
}

tweak_data.narrative.jobs.bank_heist_good = deep_clone(tweak_data.narrative.jobs.firestarter)
tweak_data.narrative.jobs.bank_heist_good.original_id = "firestarter"
tweak_data.narrative.jobs.bank_heist_good.name_id = "heist_firestarter_3_hl"
tweak_data.narrative.jobs.bank_heist_good.chain = {
  tweak_data.narrative.stages.firestarter_3
}

tweak_data.narrative.jobs.cook_off = deep_clone(tweak_data.narrative.jobs.alex)
tweak_data.narrative.jobs.cook_off.original_id = "alex"
tweak_data.narrative.jobs.cook_off.name_id = "heist_alex_1_hl"
tweak_data.narrative.jobs.cook_off.chain = {
  tweak_data.narrative.stages.alex_1
}

tweak_data.narrative.jobs.code_for_meth = deep_clone(tweak_data.narrative.jobs.alex)
tweak_data.narrative.jobs.code_for_meth.original_id = "alex"
tweak_data.narrative.jobs.code_for_meth.name_id = "heist_alex_2_hl"
tweak_data.narrative.jobs.code_for_meth.chain = {
  tweak_data.narrative.stages.alex_2
}

tweak_data.narrative.jobs.bus_stop = deep_clone(tweak_data.narrative.jobs.alex)
tweak_data.narrative.jobs.bus_stop.original_id = "alex"
tweak_data.narrative.jobs.bus_stop.name_id = "heist_alex_3_hl"
tweak_data.narrative.jobs.bus_stop.chain = {
  tweak_data.narrative.stages.alex_3
}

tweak_data.narrative.jobs.highland_mortuary = deep_clone(tweak_data.narrative.jobs.rvd)
tweak_data.narrative.jobs.highland_mortuary.original_id = "rvd"
tweak_data.narrative.jobs.highland_mortuary.name_id = "heist_rvd1_hl"
tweak_data.narrative.jobs.highland_mortuary.chain = {
  tweak_data.narrative.stages.rvd_1
}

tweak_data.narrative.jobs.garnet_group_boutique = deep_clone(tweak_data.narrative.jobs.rvd)
tweak_data.narrative.jobs.garnet_group_boutique.original_id = "rvd"
tweak_data.narrative.jobs.garnet_group_boutique.name_id = "heist_rvd2_hl"
tweak_data.narrative.jobs.garnet_group_boutique.chain = {
  tweak_data.narrative.stages.rvd_2
}

tweak_data.narrative.jobs.club_house_day = deep_clone(tweak_data.narrative.jobs.welcome_to_the_jungle_wrapper_prof)
tweak_data.narrative.jobs.club_house_day.original_id = "welcome_to_the_jungle_prof"
tweak_data.narrative.jobs.club_house_day.job_wrapper = nil
tweak_data.narrative.jobs.club_house_day.name_id = "heist_welcome_to_the_jungle_1_hl"
tweak_data.narrative.jobs.club_house_day.chain = {
  tweak_data.narrative.stages.welcome_to_the_jungle_1_d
}

tweak_data.narrative.jobs.club_house_night = deep_clone(tweak_data.narrative.jobs.welcome_to_the_jungle_wrapper_prof)
tweak_data.narrative.jobs.club_house_night.original_id = "welcome_to_the_jungle_prof"
tweak_data.narrative.jobs.club_house_night.job_wrapper = nil
tweak_data.narrative.jobs.club_house_night.name_id = "heist_welcome_to_the_jungle_1_n_hl"
tweak_data.narrative.jobs.club_house_night.chain = {
  tweak_data.narrative.stages.welcome_to_the_jungle_1_n
}

tweak_data.narrative.jobs.engine_problems = deep_clone(tweak_data.narrative.jobs.welcome_to_the_jungle_wrapper_prof)
tweak_data.narrative.jobs.engine_problems.original_id = "welcome_to_the_jungle_prof"
tweak_data.narrative.jobs.engine_problems.job_wrapper = nil
tweak_data.narrative.jobs.engine_problems.name_id = "heist_welcome_to_the_jungle_2_hl"
tweak_data.narrative.jobs.engine_problems.chain = {
  tweak_data.narrative.stages.welcome_to_the_jungle_2
}

tweak_data.narrative.jobs.this_was_not_the_deal = deep_clone(tweak_data.narrative.jobs.peta)
tweak_data.narrative.jobs.this_was_not_the_deal.original_id = "peta"
tweak_data.narrative.jobs.this_was_not_the_deal.name_id = "heist_peta_hl"
tweak_data.narrative.jobs.this_was_not_the_deal.chain = {
  tweak_data.narrative.stages.peta_1
}

tweak_data.narrative.jobs.dirty_work = deep_clone(tweak_data.narrative.jobs.peta)
tweak_data.narrative.jobs.dirty_work.original_id = "peta"
tweak_data.narrative.jobs.dirty_work.name_id = "heist_peta2_hl"
tweak_data.narrative.jobs.dirty_work.chain = {
  tweak_data.narrative.stages.peta_2
}

table.insert(tweak_data.narrative._jobs_index, "breaking_ballot")
table.insert(tweak_data.narrative._jobs_index, "right_track")
table.insert(tweak_data.narrative._jobs_index, "swing_vote")
table.insert(tweak_data.narrative._jobs_index, "framing_frame_1")
table.insert(tweak_data.narrative._jobs_index, "train_trade")
table.insert(tweak_data.narrative._jobs_index, "framing")
table.insert(tweak_data.narrative._jobs_index, "lions_den")
table.insert(tweak_data.narrative._jobs_index, "interception")
table.insert(tweak_data.narrative._jobs_index, "hotline_miami")
table.insert(tweak_data.narrative._jobs_index, "four_floors")
table.insert(tweak_data.narrative._jobs_index, "truck_load_day")
table.insert(tweak_data.narrative._jobs_index, "truck_load_night")
table.insert(tweak_data.narrative._jobs_index, "boat_load_day")
table.insert(tweak_data.narrative._jobs_index, "boat_load_night")
table.insert(tweak_data.narrative._jobs_index, "the_breakout")
table.insert(tweak_data.narrative._jobs_index, "the_search")
table.insert(tweak_data.narrative._jobs_index, "airport")
table.insert(tweak_data.narrative._jobs_index, "fbi_server")
table.insert(tweak_data.narrative._jobs_index, "bank_heist_good")
table.insert(tweak_data.narrative._jobs_index, "cook_off")
table.insert(tweak_data.narrative._jobs_index, "code_for_meth")
table.insert(tweak_data.narrative._jobs_index, "bus_stop")
table.insert(tweak_data.narrative._jobs_index, "highland_mortuary")
table.insert(tweak_data.narrative._jobs_index, "garnet_group_boutique")
table.insert(tweak_data.narrative._jobs_index, "club_house_day")
table.insert(tweak_data.narrative._jobs_index, "club_house_night")
table.insert(tweak_data.narrative._jobs_index, "engine_problems")
table.insert(tweak_data.narrative._jobs_index, "this_was_not_the_deal")
table.insert(tweak_data.narrative._jobs_index, "dirty_work")

function NarrativeTweakData:get_index_from_job_id(job_id)
  return tweak_data.story:get_index_from_job_id(job_id) or 0
end
