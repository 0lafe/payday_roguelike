-- Removes perkdeck categories
Hooks:PostHook(SkillTreeTweakData, "init", "init_roguelike_skill_tweak_data", function(self)
  self.specialization_category = {
    {
      name_id = "menu_st_category_all",
      category = "all"
    }
  }

  self.specializations[23][1].upgrades = {}
  self.specializations[23][3].upgrades = {}
  self.specializations[23][5].upgrades = {}
  self.specializations[23][7].upgrades = {}
end)
