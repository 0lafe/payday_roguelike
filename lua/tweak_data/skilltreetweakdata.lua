-- Removes perkdeck categories
Hooks:PostHook(SkillTreeTweakData, "init", "remove_most_perkdecks", function(self)
  self.specialization_category = {
    {
      name_id = "menu_st_category_all",
      category = "all"
    }
  }
end)
