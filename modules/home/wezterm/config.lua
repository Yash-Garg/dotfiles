local wezterm = require("wezterm");
local config = wezterm.config_builder();
config.color_scheme = "Aura (Gogh)";
config.enable_scroll_bar = true;
config.enable_tab_bar = false;
config.font = wezterm.font("CaskaydiaCove Nerd Font Mono");
config.font_antialias = "Subpixel";
config.font_size = 15;
config.initial_cols = 140;
config.initial_rows = 45;
config.scrollback_lines = 5000;
config.use_fancy_tab_bar = true;
return config;
