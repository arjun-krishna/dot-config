local Config = require('config')
-- local wezterm = require 'wezterm'
-- local config = {}
--
-- config.font = wezterm.font 'FiraCode Nerd Font'
-- config.font_size = 12.0
--
-- config.color_scheme = 'Tokyo Night (Gogh)'
-- config.window_background_opacity = 0.99

return Config:init()
    :append(require('config.bindings'))
    :append(require('config.appearance'))
    :append(require('config.mux'))
    :append(require('config.fonts')).options
