-- assigns roguelike tweak data to the global tweak_data
Hooks:PostHook(WeaponTweakData, "init", "init_roguelike_tweak_data", function(self, tweak_data)
  tweak_data.roguelike = RoguelikeTweakData:new(tweak_data, self)
end)

RoguelikeTweakData = RoguelikeTweakData or class()

-- initialize weapon drop tables for rewards
function RoguelikeTweakData:initialize_weapon_drop_tables(tweak_data, upgrade_tweak_data)
  local all_primary_keys = {}
  local all_secondary_keys = {}
  local all_weapon_keys = {}
  local weapon_tweak_data = tweak_data.weapon
  for k, v in pairs(upgrade_tweak_data) do
    if v.category == 'weapon' then
      local weapon_data = weapon_tweak_data[k]
      if weapon_data and weapon_data.use_data and weapon_data.use_data.selection_index and weapon_data.use_data.selection_index < 3 then
        if weapon_data.use_data.selection_index == 1 then
          table.insert(all_secondary_keys, k)
        else
          table.insert(all_primary_keys, k)
        end
        table.insert(all_weapon_keys, k)
      end
    end
  end

  self.all_primary_keys = all_primary_keys
  self.all_secondary_keys = all_secondary_keys
  self.all_weapon_keys = all_weapon_keys
end

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
    story_alaskan_deal = {
      job = "wwh",
      story = "story_alaskan_deal"
    },
    story_mountain_master = {
      job = "pent",
      story = "story_mountain_master"
    },
    story_scarface_mansion = {
      job = "friend",
      story = "story_scarface_mansion"
    },
    story_heat_street = {
      job = "run",
      story = "story_heat_street"
    },
    story_hells_island = {
      job = "bph",
      story = "story_hells_island"
    },
    story_shacklethorne_auction = {
      job = "sah",
      story = "story_shacklethorne_auction"
    },
    story_beneath_the_mountain = {
      job = "pbr",
      story = "story_beneath_the_mountain"
    },
    story_birth_of_sky = {
      job = "pbr2",
      story = "story_birth_of_sky"
    },
    story_ukrainian_prisoner = {
      job = "sand",
      story = "story_ukrainian_prisoner"
    },
    story_brooklyn_10_10 = {
      job = "spa",
      story = "story_brooklyn_10_10"
    },
    story_biker_heist = {
      job = "born",
      story = "story_biker_heist"
    },
    story_reservoir_dogs = {
      job = "rvd",
      story = "story_reservoir_dogs"
    },
    story_henrys_rock = {
      job = "des",
      story = "story_henrys_rock"
    },
    story_bulucs_mansion = {
      job = "fex",
      story = "story_bulucs_mansion"
    },
    story_black_cat = {
      job = "chca",
      story = "story_black_cat"
    },
    story_prison_nightmare = {
      job = "help",
      story = "story_prison_nightmare"
    },
    story_goat_simulator = {
      job = "peta",
      story = "story_goat_simulator"
    },
    story_transport_train = {
      job = "arm_for",
      story = "story_transport_train"
    },
    story_slaughterhouse = {
      job = "dinner",
      story = "story_slaughterhouse"
    },
    story_white_house = {
      job = "vit",
      story = "story_white_house"
    },
  }

  local lootdrop_table = {
    masks = {
      chance = 100,
      data = {
        name = "masks",
        masks = 10,
        colors = 10,
        patterns = 10
      }
    },
    xp = {
      chance = 0,
      data = {
        name = "xp",
        quantity = 3
      }
    },
    cc = {
      chance = 0,
      data = {
        name = "coins",
        quantity = 12
      }
    }
  }

  self.lootdrop_table = {}
  for _, v in pairs(lootdrop_table) do
    for i = 1, v.chance do
      table.insert(self.lootdrop_table, v.data)
    end
  end
end
