-- disables switching perkdecks from the inventory menu
Hooks:PreHook(PlayerInventoryGui, 'create_box', 'disable_perkdeck_switching_from_inventory', function(self, params)
  if params and params.name == "specialization" then
    params.clbks = {
      right = false,
      left = callback(self, self, "open_specialization_menu"),
      up = false,
      down = false
    }
  end

  if params and params.name == "primary" then
    Utils.PrintTable(params.image, 4)
  end
end)
