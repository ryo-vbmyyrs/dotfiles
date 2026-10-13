local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 起動時の文字サイズ
config.font_size = 16.0

-- 日本語は指定しないと韓国語フォント（Apple SD Gothic Neo）にフォールバックし、漢字の字形が崩れるのでヒラギノを指定
config.font = wezterm.font_with_fallback({
  "JetBrains Mono",
  "Hiragino Sans",
})

-- 番号と今のタブを目立たせ、タブの幅をそろえて位置で見分けやすくする
-- タブバーのフォントを等幅にして、空白で埋めたときにタブの幅がそろうようにする
config.window_frame = {
  font = wezterm.font_with_fallback({
    { family = "JetBrains Mono", weight = "Bold" },
    "Hiragino Sans",
  }),
  font_size = 13.0,
  active_titlebar_bg = "#16161e",
  inactive_titlebar_bg = "#16161e",
}
config.tab_max_width = 32

-- タイトル部分の表示幅（全角は2として数える）
local TAB_TITLE_WIDTH = 16

local tab_colors = {
  bar_bg = "#16161e",
  hover_bg = "#1f2335",
  active_bg = "#3d59a1",
  active_number_fg = "#ff9e64",
  active_title_fg = "#ffffff",
  inactive_number_fg = "#7aa2f7",
  inactive_title_fg = "#565f89",
  hover_title_fg = "#a9b1d6",
}

config.colors = {
  tab_bar = {
    background = tab_colors.bar_bg,
    inactive_tab_edge = tab_colors.bar_bg,
    active_tab = { bg_color = tab_colors.active_bg, fg_color = tab_colors.active_title_fg },
    inactive_tab = { bg_color = tab_colors.bar_bg, fg_color = tab_colors.inactive_title_fg },
    inactive_tab_hover = { bg_color = tab_colors.hover_bg, fg_color = tab_colors.hover_title_fg },
    new_tab = { bg_color = tab_colors.bar_bg, fg_color = tab_colors.inactive_title_fg },
    new_tab_hover = { bg_color = tab_colors.hover_bg, fg_color = tab_colors.hover_title_fg },
  },
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local title = tab.tab_title
  if title == "" then
    title = tab.active_pane.title
  end
  -- Neovim のタイトルの末尾に付く「(~/path)」は途中で切れて読みにくいので外す
  title = title:gsub("%s*%b()$", "")

  local number = tostring(tab.tab_index + 1)
  -- ウィンドウが狭くタブが縮められるときは、番号を残してタイトルを削る
  local width = math.max(0, math.min(TAB_TITLE_WIDTH, max_width - wezterm.column_width(number) - 4))
  title = wezterm.truncate_right(title, width)
  title = title .. string.rep(" ", width - wezterm.column_width(title))

  local bg, number_fg, title_fg
  if tab.is_active then
    bg, number_fg, title_fg = tab_colors.active_bg, tab_colors.active_number_fg, tab_colors.active_title_fg
  elseif hover then
    bg, number_fg, title_fg = tab_colors.hover_bg, tab_colors.inactive_number_fg, tab_colors.hover_title_fg
  else
    bg, number_fg, title_fg = tab_colors.bar_bg, tab_colors.inactive_number_fg, tab_colors.inactive_title_fg
  end

  return {
    { Background = { Color = bg } },
    { Foreground = { Color = number_fg } },
    { Text = " " .. number .. "  " },
    { Foreground = { Color = title_fg } },
    { Text = title .. " " },
  }
end)

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
