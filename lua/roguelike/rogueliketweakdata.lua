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
        if (v.dlc and managers.dlc:is_dlc_unlocked(v.dlc)) or not v.dlc then
          if weapon_data.use_data.selection_index == 1 then
            table.insert(all_secondary_keys, k)
          else
            table.insert(all_primary_keys, k)
          end
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
  -- maps level name to mission id
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
      job = "lions_den",
    },
    interception = {
      job = "interception",
    },
    hotline_miami = {
      job = "hotline_miami",
    },
    diamond_store = {
      job = "family"
    },
    art_gallery = {
      job = "framing_frame_1"
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
      job = "four_floors",
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
      job = "right_track",
    },
    swing_vote = {
      job = "swing_vote",
    },
    green_bridge = {
      job = "glace"
    },
    no_mercy = {
      job = "nmh"
    },
    truck_load_day = {
      job = "truck_load_day",
    },
    truck_load_night = {
      job = "truck_load_night",
    },
    boat_load_night = {
      job = "boat_load_night",
    },
    boat_load_day = {
      job = "boat_load_day",
    },
    airport = {
      job = "airport",
    },
    fbi_server = {
      job = "fbi_server",
    },
    club_house_day = {
      job = "club_house_day",
    },
    club_house_night = {
      job = "club_house_night",
    },
    engine_problems = {
      job = "engine_problems",
    },
    train_trade = {
      job = "train_trade",
    },
    framing = {
      job = "framing",
    },
    cook_off = {
      job = "cook_off",
    },
    code_for_meth = {
      job = "code_for_meth",
    },
    bus_stop = {
      job = "bus_stop",
    },
    go_bank = {
      job = "roberts"
    },
    jewelry_store = {
      job = "jewelry_store"
    },
    bank_heist = {
      job = "bank_heist_good"
    },
    the_breakout = {
      job = "the_breakout",
    },
    the_search = {
      job = "the_search",
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
      job = "highland_mortuary",
    },
    garnet_group_boutique = {
      job = "garnet_group_boutique",
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
    },
    breaking_ballot = {
      job = "breaking_ballot"
    },
    border_crossing = {
      job = "mex"
    },
  }

  -- data for loot card end screen
  local lootdrop_table = {
    -- masks = {
    --   chance = 50,
    --   data = {
    --     name = "masks",
    --     masks = 10,
    --     colors = 10,
    --     patterns = 10
    --   }
    -- },
    -- mods = {
    --   chance = 30,
    --   data = {
    --     name = "mods",
    --     quantity = 20
    --   }
    -- },
    -- xp = {
    --   chance = 15,
    --   data = {
    --     name = "xp",
    --     quantity = 2
    --   }
    -- },
    -- weapons = {
    --   chance = 4,
    --   data = {
    --     name = "weapons",
    --     quantity = 5
    --   }
    -- },
    perk_deck = {
      chance = 1,
      data = {
        name = "perk_deck",
        quantity = 1
      }
    },
  }

  -- assigns weights to drops in a lazy way
  self.lootdrop_table = {}
  for _, v in pairs(lootdrop_table) do
    for i = 1, v.chance do
      table.insert(self.lootdrop_table, v.data)
    end
  end
end
