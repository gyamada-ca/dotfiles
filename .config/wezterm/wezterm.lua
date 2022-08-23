local wezterm = require 'wezterm'

return {
    font = wezterm.font_with_fallback {
        'Hack Nerd Font Mono',
    },
    font_size = 14,
    color_scheme = 'Gruvbox Dark',
    enable_tab_bar = false,
}
