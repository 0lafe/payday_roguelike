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
    }
  }
  return options
end

-- overwrite of copycat card list to use unlocked cards
function UpgradesTweakData.mrwi_deck9_options()
  local copycat_cards = copycat_cards()
  local noob_lube = {
    tree = 16,
    tier = 1
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
Hooks:PostHook(UpgradesTweakData, "init", "init_roguelike_copycat_options", function(self, tweak_data)
  self.copycat_cards = copycat_cards
end)
