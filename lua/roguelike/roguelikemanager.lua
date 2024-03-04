-- Manager for custom logic related to the roguelike experience
Hooks:PostHook(Setup, "init_managers", "init_roguelike_manager", function(self, managers)
  managers.roguelike = RoguelikeManager:new()
end)

RoguelikeManager = RoguelikeManager or class()

function RoguelikeManager:init()
  self.save_path = "mods/saves/roguelike.json"
  if io.file_is_readable(self.save_path) then
    self.save_data = io.load_as_json(self.save_path)
  else
    self.save_data = self:_create_save_data()
  end
end

-- creates a new save when none is present
function RoguelikeManager:_create_save_data()
  local schema = {
    unlocked_cards = {},
    rolled_heists = {}
  }
  io.save_as_json(schema, self.save_path)
  return schema
end

-- general purpose function to save the current save_data value
function RoguelikeManager:_save_to_file()
  io.save_as_json(self.save_data, self.save_path)
end

-- initial unlocker for the copycat deck
function RoguelikeManager:unlock_copycat()
  managers.skilltree:give_specialization_points(1370000)
  managers.skilltree:spend_specialization_points(13700, 23)
  managers.skilltree:set_current_specialization(23)

  for _, category in pairs({ "primaries", "secondaries", "masks" }) do
    for i = 10, (tweak_data.gui.MAX_WEAPON_SLOTS or 72) do
      managers.blackmarket:_unlock_weapon_slot(category, i)
    end
  end
end

-- adds random copycat cards for rewards
function RoguelikeManager:add_copycat_card(quantity)
  self._dropped_copycat_cards = {}
  local all_cards = tweak_data.upgrades:copycat_cards()

  for i = 1, quantity or 1 do
    local current_cards = self.save_data.unlocked_cards
    for _, card in pairs(current_cards) do
      all_cards[card] = nil
    end

    local card_names = {}
    for name, _ in pairs(all_cards) do
      table.insert(card_names, name)
    end

    local rolled_card_name = card_names[math.random(#card_names)]
    table.insert(self.save_data.unlocked_cards, rolled_card_name)
    table.insert(self._dropped_copycat_cards, rolled_card_name)
    self:_save_to_file()
  end
  self:_reset_copycat_tweak_data()
end

function RoguelikeManager:add_perkdeck()
  self._dropped_perkdecks = {}
  local perkdeck_list = {}
  local completed_decks = {}
  for i = 1, 23 do
    local tier = managers.skilltree:get_specialization_value(i, "tiers", "current_tier")
    if tier < 9 then
      table.insert(perkdeck_list, i)
    else
      table.insert(completed_decks, tier)
    end
  end

  local selected_deck = perkdeck_list[math.random(#perkdeck_list)]

  managers.skilltree:give_specialization_points(1370000)
  managers.skilltree:spend_specialization_points(13700, selected_deck)

  -- Logic to run on initial deck unlock
  if #completed_decks == 0 then
    managers.skilltree:set_current_specialization(selected_deck)
    for _, category in pairs({ "primaries", "secondaries" }) do
      for i = 10, (tweak_data.gui.MAX_WEAPON_SLOTS or 72) do
        managers.blackmarket:_unlock_weapon_slot(category, i)
      end
    end
    for i = 10, (tweak_data.gui.MAX_MASK_SLOTS or 72) do
      managers.blackmarket:_unlock_mask_slot(i)
    end
  end

  table.insert(self._dropped_perkdecks, selected_deck)
end

function RoguelikeManager:reset_progress()
  self.save_data = self:_create_save_data()
  managers.roguelike:_reset_copycat_tweak_data()
  for _, mission in pairs(managers.story:missions()) do
    if mission.completed == false then
      mission.completed = nil
    end
    if mission.auto_complete then
      mission.completed = true
    end
  end
end

function RoguelikeManager:_reset_copycat_tweak_data()
  tweak_data.upgrades = UpgradesTweakData:new(tweak_data)
  tweak_data.skilltree = SkillTreeTweakData:new()
end

-- adds weapons for rewards
function RoguelikeManager:add_weapons(quantity)
  self._dropped_weapons = {}

  for i = 1, quantity or 1 do
    local weapons = {
      {
        key = tweak_data.roguelike.all_primary_keys[math.random(#tweak_data.roguelike.all_primary_keys)],
        type = "primaries"
      },
      {
        key = tweak_data.roguelike.all_secondary_keys[math.random(#tweak_data.roguelike.all_secondary_keys)],
        type = "secondaries"
      }
    }

    for _, weapon in pairs(weapons) do
      local slot = managers.blackmarket:_get_free_weapon_slot(weapon.type)
      if slot then
        managers.blackmarket:on_buy_weapon_platform(weapon.type, weapon.key, slot, true)
        table.insert(self._dropped_weapons, tweak_data.weapon[weapon.key].name_id)
      else
        table.insert(self._dropped_weapons, "roguelike_error_no_inventory_space")
      end
    end
  end
end

-- adds weapon mods as rewards
function RoguelikeManager:add_weapon_mods(quantity)
  self._dropped_mods = {}
  local all_mods = {}
  for _, type in pairs({ "primaries", "secondaries" }) do
    for k, v in pairs(managers.blackmarket:get_crafted_category(type)) do
      local mods = managers.blackmarket:get_dropable_mods_by_weapon_id(v.weapon_id)
      mods["charm"] = nil
      for kk, vv in pairs(mods) do
        for kkk, vvv in pairs(vv) do
          all_mods[vvv[1]] = true
        end
      end
    end
  end

  local all_keys = {}
  for k, v in pairs(all_mods) do
    table.insert(all_keys, k)
  end

  for i = 1, quantity or 1 do
    local mod = all_keys[math.random(#all_keys)]
    local global_value = managers.blackmarket:get_global_value("weapon_mods", mod)
    managers.blackmarket:add_to_inventory(global_value, "weapon_mods", mod)
    table.insert(self._dropped_mods, tweak_data.blackmarket.weapon_mods[mod].name_id)
  end
end

-- dynamically create objective data for mission
function RoguelikeManager:build_objectives(mission)
  if not mission or not mission.tier then
    return
  end

  local objectives = self.save_data.rolled_heists[mission.id]
  if not objectives then
    local heist_pool = tweak_data.story:heist_pool(mission.tier)
    objectives = { heist_pool[math.random(#heist_pool)] }
    self.save_data.rolled_heists[mission.id] = objectives
    self:_save_to_file()
  end

  self:_assign_objectives(objectives, mission)
end

function RoguelikeManager:_assign_objectives(objectives, mission)
  local built_objectives = {}
  for _, objective in pairs(objectives) do
    table.insert(built_objectives, {
      tweak_data.story:_level_progress("story_" .. objective, 1, {
        name_id = "menu_sm_" .. objective
      })
    })
  end

  mission.objectives = built_objectives

  mission.objectives_flat = {}

  for _, t in pairs(mission.objectives) do
    for _, o in pairs(t) do
      mission.objectives_flat[o.progress_id] = o
      local dlc = nil

      for _, id in pairs(o.levels or {}) do
        local found = tweak_data.narrative.jobs[id].dlc

        if found and dlc and dlc ~= found then
          Application:error("Found multiple DLC's for a single objecitive!", o.progress_id)
        end

        o.dlc = found
      end
    end
  end
end

-- link the story mission gui manager
function RoguelikeManager:set_story_mission_gui(story_mission_gui)
  self.story_mission_gui = story_mission_gui
end

-- function for rerolling heists
function RoguelikeManager:reroll()
  local current_mission = managers.story:current_mission()
  local heist_pool = tweak_data.story:heist_pool(current_mission.tier)
  local unique_heists = {}
  local heist_unique = true
  for _, heist in pairs(heist_pool) do
    for current_heist, _ in pairs(current_mission.objectives_flat) do
      local current_heist_name = current_heist:gsub("story_", "")
      if current_heist_name == heist then
        heist_unique = false
      end
    end
    if heist_unique then
      table.insert(unique_heists, heist)
    end
    heist_unique = true
  end
  local heists = { unique_heists[math.random(#unique_heists)] }
  self.save_data.rolled_heists[current_mission.id] = heists
  self:_save_to_file()
  self.story_mission_gui:_update(current_mission)
end
