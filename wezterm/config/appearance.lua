local gpu_adapters = require('utils.gpu-adapter')
---@type Config
return {
    color_scheme = 'Tokyo Night (Gogh)',
    max_fps = 120,
    front_end = 'WebGpu',
    webgpu_power_preference = 'HighPerformance',
    webgpu_preferred_adapter = gpu_adapters:pick_best(),
    underline_thickness = '1.5pt',
    use_resize_increments = true,

    -- cursor
    animation_fps = 120,
    cursor_blink_ease_in = 'EaseOut',
    cursor_blink_ease_out = 'EaseOut',
    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 600,

    -- scrollbar
    enable_scroll_bar = true,
    scrollback_lines = 10000,

    -- tabbar
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = false,
    use_fancy_tab_bar = true,
    tab_max_width = 30,
    show_tab_index_in_tab_bar = true,
    switch_to_last_active_tab_when_closing_tab = true,

    -- command palette
    command_palette_fg_color = '#b4befe',
    command_palette_bg_color = '#11111b',
    command_palette_font_size = 12.0,
    command_palette_rows = 25,

    -- window
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    adjust_window_size_when_changing_font_size = false,
    window_close_confirmation = 'NeverPrompt',
    window_frame = {
        active_titlebar_bg = '#090909',
    },
    inactive_pane_hsb = {
        saturation = 1.0,
        brightness = 1.0,
    },
    visual_bell = {
        fade_in_function = 'EaseIn',
        fade_in_duration_ms = 250,
        fade_out_function = 'EaseOut',
        fade_out_duration_ms = 250,
        target = 'CursorColor',
    },
    colors = {
        tab_bar = {
            -- background = '#090909',
            -- active_tab = {
            --     bg_color = '#090909',
            --     fg_color = '#b4befe',
            --     intensity = 'Bold',
            -- },
            -- inactive_tab = {
            --     bg_color = '#090909',
            --     fg_color = '#b4befe',
            -- },
            background = '#090909',
            -- Active tab colors
            active_tab = {
              bg_color = '#1b1b1b',
              fg_color = '#ffffff',
              intensity = 'Bold',
              underline = 'Single',
              italic = false,
              strikethrough = false,
            },
            -- Inactive tab colors
            inactive_tab = {
              bg_color = '#000000',
              fg_color = '#a0a0a0',
            },
            -- Inactive tab on hover
            inactive_tab_hover = {
              bg_color = '#3b3052',
              fg_color = '#ffffff',
            },
        },
    },
}
