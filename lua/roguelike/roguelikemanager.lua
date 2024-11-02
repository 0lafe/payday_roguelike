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
    rolled_heists = {},
    highest_tier = 4,
    settings = {}
  }
  io.save_as_json(schema, self.save_path)
  return schema
end

-- general purpose function to save the current save_data value
function RoguelikeManager:_save_to_file()
  self.save_data.settings = Roguelike._settings
  io.save_as_json(self.save_data, self.save_path)
end

-- Complete all sidejobs to unlock certain items
function RoguelikeManager:_complete_sidejobs()
  for _, challenge in pairs(managers.tango:challenges()) do
    managers.tango:completed_challenge(challenge.id)
  end
  for _, challenge in pairs(managers.event_jobs:challenges()) do
    managers.event_jobs:completed_challenge(challenge.id)
  end
  for _, challenge in pairs(managers.raid_jobs:challenges()) do
    managers.raid_jobs:completed_challenge(challenge.id)
  end
end

-- unlocks all inventory slots
function RoguelikeManager:_unlock_slots()
  for _, category in pairs({ "primaries", "secondaries" }) do
    for i = 10, (tweak_data.gui.MAX_WEAPON_SLOTS or 72) do
      managers.blackmarket:_unlock_weapon_slot(category, i)
    end
  end
  for i = 10, (tweak_data.gui.MAX_MASK_SLOTS or 72) do
    managers.blackmarket:_unlock_mask_slot(i)
  end
end

function RoguelikeManager:add_perkdeck(quantity)
  local quantity = quantity or 1
  self._dropped_perkdecks = {}

  for i = 1, quantity do
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

    if #perkdeck_list == 0 then
      return
    end

    local selected_deck = perkdeck_list[math.random(#perkdeck_list)]

    managers.skilltree:give_specialization_points(1370000)
    managers.skilltree:spend_specialization_points(13700, selected_deck)

    -- Logic to run on initial deck unlock
    if #completed_decks == 0 then
      managers.skilltree:set_current_specialization(selected_deck)
      self:_unlock_slots()
      self:_complete_sidejobs()
    end
    table.insert(self._dropped_perkdecks, selected_deck)
  end
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

  -- track highest tier achieved
  if mission.tier > self.save_data.highest_tier then
    self.save_data.highest_tier = mission.tier
    self:_save_to_file()
  end

  local objectives = self.save_data.rolled_heists[mission.id]
  -- generate a heist based on list for given tier
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

  -- add option to skip to completed tiers
  if mission.tier == 0 and self.save_data.highest_tier > 0 then
    mission.tier_skip = true
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

-- handles adding rewards when skipping tiers
function RoguelikeManager:tier_skip_rewards(tier)
  -- perkdeck, weapon, weapon mods, money, level
  local values = {
    { 1, 1,  5,   50000,    25 },
    { 2, 4,  20,  500000,   60 },
    { 3, 10, 50,  5000000,  80 },
    { 4, 20, 100, 20000000, 100 },
  }

  self:add_perkdeck(values[tier][1])
  self:add_weapons(values[tier][2])
  self:add_weapon_mods(values[tier][3])
  managers.money:_set_total(values[tier][4])
  for i = managers.experience:current_level(), values[tier][5] - 1 do
    managers.experience:_level_up()
  end
end

-- Skips to given tier by setting missions to complete
function RoguelikeManager:skip_to_tier(tier)
  local current_mission = managers.story:current_mission()
  while not current_mission.tier or current_mission.tier < tier do
    current_mission.rewarded = true
    current_mission.completed = true
    current_mission = managers.story:_find_next_mission()
    self:build_objectives(current_mission)
  end

  self:tier_skip_rewards(tier)
end
