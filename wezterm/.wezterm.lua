local wezterm = require("wezterm")
local c = {}
if wezterm.config_builder then
	c = wezterm.config_builder()
end

local tab_title = function(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

c.audible_bell = "Disabled"
c.adjust_window_size_when_changing_font_size = false
c.color_scheme = "Catppuccin Macchiato"
c.font = wezterm.font("JetBrainsMono Nerd Font Mono", { weight = "Medium" })
c.font_size = 13
c.inactive_pane_hsb = { brightness = 0.90 }
c.initial_cols = 150
c.initial_rows = 50
c.hide_tab_bar_if_only_one_tab = true
c.use_fancy_tab_bar = false
c.show_new_tab_button_in_tab_bar = false
c.window_decorations = "RESIZE"
c.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
c.window_frame = { font = wezterm.font("JetBrainsMono Nerd Font Mono"), inactive_titlebar_bg = "#ffffff" }

-- keys
c.keys = {
	{ key = "v", mods = "ALT|CTRL", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "x", mods = "ALT|CTRL", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "b", mods = "CTRL", action = wezterm.action.RotatePanes("Clockwise") },
	{ key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
}

wezterm.on("format-tab-title", function(tab, _, _, config, _, max_width)
	local palette = config.resolved_palette.tab_bar
	local colors = {
		bg = palette.background,
		tab = tab.is_active and palette.active_tab.bg_color or palette.inactive_tab.bg_color,
		fg = tab.is_active and palette.active_tab.fg_color or palette.inactive_tab.fg_color,
	}
	local title = tab_title(tab)
	if #title > max_width then
		title = wezterm.truncate_right(title, max_width - 1) .. "…"
	end

	return {
		{ Background = { Color = colors.bg } },
		{ Foreground = { Color = colors.tab } },
		{ Text = " " },
		{ Background = { Color = colors.tab } },
		{ Foreground = { Color = colors.fg } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = colors.tab } },
		{ Foreground = { Color = colors.bg } },
	}
end)

return c
