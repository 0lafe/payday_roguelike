-- removes the ability to purchase weapons
function BlackMarketGui:open_weapon_buy_menu(data)
end

-- Prevent buying weapon mods
function BlackMarketGui:purchase_weapon_mod_callback(data)
end

-- Remove buy weapon mod button
Hooks:PostHook(BlackMarketGui, "_setup", "remove_weapon_mod_buy_button", function(self, ...)
  self._btns["wm_buy_mod"] = nil
end)
