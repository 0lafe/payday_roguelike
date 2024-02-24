-- Manages adding and overwriting localization strings
Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInitRoguelike", function(loc)
  local language_tbl = {
    [("english"):key()] = "en.txt"
  }
  local mod_path = "mods/roguelike/"
  local language = language_tbl[SystemInfo:language():key()] or "en.txt"
  local path = mod_path .. "loc/" .. language
  path = io.file_is_readable(path) and path or mod_path .. "loc/en.txt"

  loc:load_localization_file(path)
end)
