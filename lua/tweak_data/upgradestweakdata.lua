Hooks:PostHook(UpgradesTweakData, "init", "init_roguelike_upgrade_tweak_data", function(self, tweak_data)
  tweak_data.roguelike:initialize_weapon_drop_tables(tweak_data, self.definitions)
end)
