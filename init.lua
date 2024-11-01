--Don't do setup twice
if _G.Roguelike then
  return
end

_G.Roguelike = _G.Roguelike or {}
Roguelike._mod_path = ModPath
Roguelike._save_path = SavePath .. "roguelike.json"
Roguelike._settings = {
  roguelike_toggle_pro_job = false,
  roguelike_toggle_hard_mode = false
}

function Roguelike:hard_mode()
  return Roguelike._settings.roguelike_toggle_hard_mode
end

--Load settings function
function Roguelike:load_settings()
  if io.file_is_readable(self._save_path) then
    Roguelike._settings = io.load_as_json(self._save_path).settings
  end
end

function Roguelike:save_settings()
  local save_data = io.load_as_json(self._save_path)
  save_data.settings = Roguelike._settings
  if io.file_is_readable(self._save_path) then
    io.save_as_json(save_data, self._save_path)
  end
end

Hooks:Add("MenuManagerInitialize", "roguelike_hook_MenuManagerInitialize", function(menu_manager)
  MenuCallbackHandler.roguelike_toggle_menu_item = function(self, item)
    if item.selected == 1 then
      Roguelike._settings[item:name()] = true
    else
      Roguelike._settings[item:name()] = false
    end
    Roguelike:save_settings()
  end

  Roguelike:load_settings()
  MenuHelper:LoadFromJsonFile(Roguelike._mod_path .. "menus/main.json", Roguelike, Roguelike._settings)
end)
