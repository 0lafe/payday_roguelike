-- Increase size of roguelike mode menu node element
Hooks:PreHook(MenuNodeGui, "_create_menu_item", "increase_story_mode_font_size", function(self, item)
  if item.name == "story_missions" then
    item.font_size = 35
  end
end)
