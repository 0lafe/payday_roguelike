-- adds neccesary achievements for story quickplay buttons
Hooks:PostHook(AchievementsTweakData, "init", "init_roguelike_achievements", function(self, tweak_data)
  for k, v in pairs(tweak_data.roguelike.achievement_additions) do
    self.complete_heist_achievements[k] = v
  end
end)
