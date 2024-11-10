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
    interception = {
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
    right_track = {
      job = "election_day",
      day_id = 1
    },
    swing_vote = {
      job = "election_day",
      day_id = 2
    },
    green_bridge = {
      job = "glace"
    },
    no_mercy = {
      job = "nmh"
    },
    truck_load = {
      job = "watchdogs",
      day_id = 1
    },
    boat_load = {
      job = "watchdogs",
      day_id = 2
    },
    airport = {
      job = "firestarter",
      day_id = 1
    },
    fbi_server = {
      job = "firestarter",
      day_id = 2
    },
    club_house = {
      job = "welcome_to_the_jungle",
      day_id = 1
    },
    engine_problems = {
      job = "welcome_to_the_jungle",
      day_id = 2
    },
    train_trade = {
      job = "framing_frame",
      day_id = 2
    },
    framing = {
      job = "framing_frame",
      day_id = 3
    },
    cook_off = {
      job = "alex",
      day_id = 1
    },
    code_for_meth = {
      job = "alex",
      day_id = 2
    },
    bus_stop = {
      job = "alex",
      day_id = 3
    },
    go_bank = {
      job = "roberts"
    },
    jewelry_store = {
      job = "jewelry_store"
    },
    bank_heist = {
      job = "firestarter"
    },
    the_breakout = {
      job = "hox",
      day_id = 1
    },
    the_search = {
      job = "hox",
      day_id = 2
    },
    white_xmas = {
      job = "pines"
    },
    bomb_dockyard = {
      job = "crojob1"
    },
    bomb_forest = {
      job = "crojob2"
    },
    meltdown = {
      job = "shoutout_raid"
    },
    alesso = {
      job = "arena"
    },
    aftershock = {
      job = "jolly"
    },
    santas_workshop = {
      job = "cane"
    },
    stealing_xmas = {
      job = "moon"
    },
    highland_mortuary = {
      job = "rvd",
      day_id = 2
    },
    garnet_group_boutique = {
      job = "rvd",
      day_id = 1
    },
    border_crystals = {
      job = "mex_cooking"
    },
    san_martin = {
      job = "bex"
    },
    midland_ranch = {
      job = "ranc"
    },
    lost_in_transit = {
      job = "trai"
    },
    hostile_takeover = {
      job = "corp"
    },
    crude_awakening = {
      job = "deep"
    },
    lab_rats = {
      job = "nail"
    }
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
