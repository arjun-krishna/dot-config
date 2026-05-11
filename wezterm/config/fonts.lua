local wezterm = require('wezterm')
local platform = require('utils.platform')

local font_family = 'FiraCode Nerd Font'
local font_size = platform.is_linux and 12.0 or 12.5

---@type Config
return {
    font = wezterm.font({ family = font_family, weight = 'Medium' }),
    font_size = font_size,

    freetype_load_target = 'Normal', ---@type 'Normal' | 'Light' | 'Mono' | 'HorizontalLcd'
    freetype_render_target = 'Normal', ---@type 'Normal' | 'Light' | 'Mono' | 'HorizontalLcd'
}
