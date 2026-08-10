local wezterm = require('wezterm')
local platform = require('utils.platform')

local act = wezterm.action
local mod = platform.is_mac and 'SUPER' or 'ALT'
local mod_rev = platform.is_mac and 'SUPER|CTRL' or 'ALT|CTRL'

---@type Key[]
local keys = {
    -- Terminal UI
    { key = 'F1', mods = 'NONE', action = act.ActivateCommandPalette },
    { key = 'F2', mods = 'NONE', action = act.ShowLauncher },
    { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
    { key = 'F12', mods = 'NONE', action = act.ShowDebugOverlay },

    -- Text and terminal navigation
    { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo('Clipboard') },
    { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom('Clipboard') },
    {
        key = 'u',
        mods = mod_rev,
        action = wezterm.action.QuickSelectArgs({
            label = 'open url',
            patterns = {
                '\\((https?://\\S+)\\)',
                '\\[(https?://\\S+)\\]',
                '\\{(https?://\\S+)\\}',
                '<(https?://\\S+)>',
                '\\bhttps?://\\S+[)/a-zA-Z0-9-]+',
            },
            action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.open_with(url)
            end),
        }),
    },
    { key = 'u', mods = mod, action = act.ScrollByLine(-5) },
    { key = 'd', mods = mod, action = act.ScrollByLine(5) },
    { key = 'PageUp', mods = 'NONE', action = act.ScrollByPage(-0.75) },
    { key = 'PageDown', mods = 'NONE', action = act.ScrollByPage(0.75) },
    {
        key = 'l',
        mods = 'CTRL|SHIFT',
        action = act.Multiple {
            act.ClearScrollback 'ScrollbackAndViewport',
            act.SendKey { key = 'l', mods = 'CTRL' },
        },
    },

    -- OS-level window management (not terminal multiplexing)
    { key = 'n', mods = mod, action = act.SpawnWindow },
    {
        key = '-',
        mods = mod,
        action = wezterm.action_callback(function(window, _)
            local dimensions = window:get_dimensions()
            window:set_inner_size(dimensions.pixel_width - 50, dimensions.pixel_height - 50)
        end),
    },
    {
        key = '=',
        mods = mod,
        action = wezterm.action_callback(function(window, _)
            local dimensions = window:get_dimensions()
            window:set_inner_size(dimensions.pixel_width + 50, dimensions.pixel_height + 50)
        end),
    },
    {
        key = 'Enter',
        mods = mod_rev,
        action = wezterm.action_callback(function(window, _)
            window:maximize()
        end),
    },

    { key = '+', mods = 'CTRL|SHIFT', action = act.IncreaseFontSize },
    { key = '_', mods = 'CTRL|SHIFT', action = act.DecreaseFontSize },
    { key = ')', mods = 'CTRL|SHIFT', action = act.ResetFontSize },
}

---@type MouseBinding[]
local mouse_bindings = {
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = act.OpenLinkAtMouseCursor,
    },
}

return {
    disable_default_key_bindings = true,
    keys = keys,
    mouse_bindings = mouse_bindings,
}
