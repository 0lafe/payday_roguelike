-- Removes perkdeck categories
Hooks:PostHook(SkillTreeTweakData, "init", "init_roguelike_skill_tweak_data", function(self)
  self.specialization_category = {
    {
      name_id = "menu_st_category_all",
      category = "all"
    }
  }
end)
