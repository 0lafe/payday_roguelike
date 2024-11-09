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
  self.missions = {
    cursed_kill_room = {
      job = "hvh"
    },
    black_cat = {
      job = "chca"
    },
    brooklyn_bank = {
      job = "brb"
    },
    brooklyn_10_10 = {
      job = "spa"
    },
    heat_street = {
      job = "run"
    },
    birth_of_sky = {
      job = "pbr2"
    },
    bank_heist_deposit = {
      job = "branchbank_deposit"
    },
    hells_island = {
      job = "bph"
    },
    reservoir_dogs = {
      job = "rvd"
    },
    first_world_bank = {
      job = "red2"
    },
    nightclub = {
      job = "nightclub"
    },
    undercover = {
      job = "man"
    },
    lions_den = {
      job = "born",
      day_id = 1
    },
    road_rage = {
      job = "born",
      day_id = 2
    },
    hotline_miami = {
      job = "mia",
      day_id = 1
    },
    diamond_store = {
      job = "family"
    },
    art_gallery = {
      job = "gallery"
    },
    bank_heist_cash = {
      job = "branchbank_cash"
    },
    ukrainian_job = {
      job = "ukrainian_job_prof"
    },
    breakfast_in_tijuana = {
      job = "pex"
    },
    henrys_rock = {
      job = "des"
    },
    the_diamond = {
      job = "mus"
    },
    white_house = {
      job = "vit"
    },
    slaughterhouse = {
      job = "dinner"
    },
    transport_train = {
      job = "arm_for"
    },
    goat_simulator = {
      job = "peta"
    },
    big_bank = {
      job = "big"
    },
    mallcrasher = {
      job = "mallcrasher"
    },
    bank_heist_gold = {
      job = "branchbank_gold_prof"
    },
    prison_nightmare = {
      job = "help"
    },
    counterfeit = {
      job = "pal"
    },
    hoxton_revenge = {
      job = "hox_3"
    },
    bulucs_mansion = {
      job = "fex"
    },
    ukrainian_prisoner = {
      job = "sand"
    },
    beneath_the_mountain = {
      job = "pbr"
    },
    shacklethorne_auction = {
      job = "sah"
    },
    diamond_heist = {
      job = "dah"
    },
    scarface_mansion = {
      job = "friend"
    },
    safe_house_nightmare = {
      job = "haunted"
    },
    panic_room = {
      job = "flat"
    },
    dragon_heist = {
      job = "chas"
    },
    election_day = {
      job = "election_day"
    },
    four_floors = {
      job = "mia",
      day_id = 2
    },
    mountain_master = {
      job = "pent"
    },
    four_store = {
      job = "four_stores"
    },
    alaskan_deal = {
      job = "wwh"
    },
  }

  local lootdrop_table = {
    masks = {
      chance = 50,
      data = {
        name = "masks",
        masks = 10,
        colors = 10,
        patterns = 10
      }
    },
    xp = {
      chance = 25,
      data = {
        name = "xp",
        quantity = 2
      }
    },
    cc = {
      chance = 25,
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
