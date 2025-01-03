-- applies weapon drop table to roguelike tweak data
-- needs dlc manager setup
Hooks:PostHook(Setup, "init_managers", "add_roguelike_drop_tables", function(self, managers)
  tweak_data.roguelike:initialize_weapon_drop_tables(tweak_data, tweak_data.upgrades.definitions)
end)
