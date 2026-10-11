local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 起動時の文字サイズ
config.font_size = 16.0

-- 新しいタブは直前のタブのディレクトリを引き継がず、ホームディレクトリで開く
local spawn_tab_in_home = wezterm.action.SpawnCommandInNewTab({ cwd = wezterm.home_dir })

config.keys = {
  { key = "t", mods = "CMD", action = spawn_tab_in_home },
  { key = "t", mods = "CTRL|SHIFT", action = spawn_tab_in_home },
}

-- タブバーの「+」ボタン
wezterm.on("new-tab-button-click", function(window, pane, button, default_action)
  if button == "Left" then
    window:perform_action(spawn_tab_in_home, pane)
    return false
  end
end)

return config
