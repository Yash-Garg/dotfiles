local wezterm = require("wezterm")
local utils = require("utils")
local config = wezterm.config_builder()

if utils.is_windows() then
    config.default_prog = { "pwsh" }
end

config.adjust_window_size_when_changing_font_size = false
config.automatically_reload_config = true
config.check_for_updates = false
config.color_scheme = "Aura (Gogh)"
config.default_cursor_style = "BlinkingBar"
config.disable_default_key_bindings = false
config.enable_scroll_bar = false
config.enable_tab_bar = false
config.font = wezterm.font({
    family = "CaskaydiaCove Nerd Font Mono",
    weight = "DemiBold",
    harfbuzz_features = { "ss02", "ss19", "ss20" },
})
config.font_size = 17
config.initial_cols = 130
config.initial_rows = 35
config.macos_window_background_blur = 10
config.scrollback_lines = 5000
config.use_fancy_tab_bar = true
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
    left = 10,
    right = 10,
    top = 15,
    bottom = 0,
}
config.win32_system_backdrop = "Acrylic"

return config
