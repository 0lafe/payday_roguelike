-- assigns roguelike tweak data to the global tweak_data
Hooks:PostHook(WeaponTweakData, "init", "init_roguelike_tweak_data", function(self, tweak_data)
  tweak_data.roguelike = RoguelikeTweakData:new(tweak_data)
end)

RoguelikeTweakData = RoguelikeTweakData or class()

function RoguelikeTweakData:init(tweak_data)
  self.achievement_additions = {
    story_four_store = {
      job = "four_stores",
      story = "story_four_store"
    },
    story_ukrainian_job = {
      job = "ukrainian_job_prof",
      story = "story_ukrainian_job"
    },
    story_mallcrasher = {
      job = "mallcrasher",
      story = "story_mallcrasher",
    },
    story_cursed_kill_room = {
      job = "hvh",
      story = "story_cursed_kill_room",
    },
    story_nightclub = {
      job = "nightclub",
      story = "story_nightclub"
    },
    story_art_gallery = {
      job = "gallery",
      story = "story_art_gallery"
    },
    story_bank_heist_deposit = {
      job = "branchbank_deposit",
      story = "story_bank_heist_deposit"
    },
    story_bank_heist_gold = {
      job = "branchbank_gold_prof",
      story = "story_bank_heist_gold"
    },
    story_bank_heist_cash = {
      job = "branchbank_cash",
      story = "story_bank_heist_cash"
    },
    story_hoxton_revenge = {
      job = "hox_3",
      story = "story_hoxton_revenge"
    },
    story_counterfeit = {
      job = "pal",
      story = "story_counterfeit"
    },
    story_undercover = {
      job = "man",
      story = "story_undercover"
    },
    story_panic_room = {
      job = "flat",
      story = "story_panic_room"
    },
    story_first_world_bank = {
      job = "red2",
      story = "story_first_world_bank"
    },
    story_diamond_heist = {
      job = "dah",
      story = "story_diamond_heist"
    },
    story_diamond_store = {
      job = "family",
      story = "story_diamond_store"
    },
    story_safe_house_nightmare = {
      job = "haunted",
      story = "story_safe_house_nightmare"
    },
    story_brooklyn_bank = {
      job = "brb",
      story = "story_brooklyn_bank"
    },
    story_breakfast_in_tijuana = {
      job = "pex",
      story = "story_breakfast_in_tijuana"
    },
    story_big_bank = {
      job = "big",
      story = "story_big_bank"
    },
    story_the_diamond = {
      job = "mus",
      story = "story_the_diamond"
    },
    story_hotline_miami = {
      job = "mia",
      story = "story_hotline_miami"
    },
    story_election_day = {
      job = "election_day",
      story = "story_election_day"
    },
    story_dragon_heist = {
      job = "chas",
      story = "story_dragon_heist"
    },
  }
end
