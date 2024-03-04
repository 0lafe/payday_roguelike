-- list of all copycat cards
local function copycat_cards()
  local options = {
    tag_vape = {
      tree = 20,
      tier = 1
    },
    kp_injector = {
      tree = 17,
      tier = 1
    },
    grinder_heal = {
      tree = 11,
      tier = 1
    },
    crew_chief_dr = {
      tree = 1,
      tier = 1
    },
    rogue_dodge = {
      desc_id = "menu_deck23_9_7_desc",
      short_id = "menu_deck23_9_7_short",
      name_id = "menu_deck7_7",
      upgrades = {
        "player_tier_dodge_chance_1",
        "player_stand_still_crouch_camouflage_bonus_1",
        "player_stand_still_crouch_camouflage_bonus_2",
        "player_stand_still_crouch_camouflage_bonus_3",
        "player_alarm_pager_speed_multiplier"
      },
      custom_editable_descs = {
        "20%",
        "20%",
        "10%"
      },
      icon_xy = {
        1,
        4
      }
    },
    infil_damage_reduction = {
      tier = 7,
      tree = 8,
      desc_id = "menu_deck8_1_desc",
      upgrades = {
        "player_damage_dampener_close_contact_1",
        "player_damage_dampener_close_contact_2"
      },
      custom_editable_descs = {
        [1.0] = "24%"
      }
    },
    socio_gating = {
      tree = 9,
      tier = 3
    },
    gambler_heal = {
      tree = 10,
      tier = 1
    },
    exprez_heal = {
      desc_id = "menu_deck23_9_13_desc",
      short_id = "menu_deck23_9_13_short",
      tier = 3,
      tree = 13,
      upgrades = {
        "player_armor_health_store_amount_1"
      },
      custom_editable_descs = {
        "8",
        "1",
        "10%"
      }
    },
    hacker_pecm = {
      tree = 21,
      tier = 1
    },
  }
  return options
end

-- overwrite of copycat card list to use unlocked cards
function UpgradesTweakData.mrwi_deck9_options()
  local copycat_cards = copycat_cards()
  local noob_lube = {
    tree = 16,
    tier = 1,
    upgrades = {
      "temporary_mrwi_health_invulnerable_1"
    },
    desc_id = "menu_deck23_noob_lube_desc",
    short_id = "menu_deck23_noob_lube_short",
    name_id = "menu_deck23_noob_lube",
    custom_editable_descs = {
      [1.0] = "5",
      [2.0] = "4",
      [3.0] = "50%",
      [4.0] = "2",
      [5.0] = "15",
    }
  }

  local out = {}
  local save_data
  if managers and managers.roguelike then
    save_data = managers.roguelike.save_data
  else
    if io.file_is_readable("mods/saves/roguelike.json") then
      save_data = io.load_as_json("mods/saves/roguelike.json")
    else
      save_data = { unlocked_cards = {} }
    end
  end

  local unlocked_card_names = save_data.unlocked_cards
  if #unlocked_card_names == 0 then
    table.insert(out, noob_lube)
  else
    for _, card_name in pairs(unlocked_card_names) do
      if copycat_cards[card_name] then
        table.insert(out, copycat_cards[card_name])
      end
    end
  end

  return out
end

-- Assign all copycat card function to self
Hooks:PostHook(UpgradesTweakData, "init", "init_roguelike_upgrade_tweak_data", function(self, tweak_data)
  self.copycat_cards = copycat_cards
  self.specialization_descs[23][1] = {}
  self.specialization_descs[23][3] = {}
  self.specialization_descs[23][5] = {}
  self.specialization_descs[23][7] = {}
  tweak_data.roguelike:initialize_weapon_drop_tables(tweak_data, self.definitions)
end)
