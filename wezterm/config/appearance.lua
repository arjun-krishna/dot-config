local gpu_adapters = require('utils.gpu-adapter')
---@type Config
return {
   -- wayland (issues with linux)
    enable_wayland=false,

    -- general
    color_scheme = 'Tokyo Night (Gogh)',
    max_fps = 120,
    front_end = 'WebGpu',
    webgpu_power_preference = 'HighPerformance',
    webgpu_preferred_adapter = gpu_adapters:pick_best(),
    underline_thickness = '1.5pt',
    use_resize_increments = false,

    -- cursor
    animation_fps = 120,
    cursor_blink_ease_in = 'EaseOut',
    cursor_blink_ease_out = 'EaseOut',
    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 600,

    -- scrollbar
    enable_scroll_bar = false,
    scrollback_lines = 10000,

    -- command palette
    command_palette_fg_color = '#b4befe',
    command_palette_bg_color = '#11111b',
    command_palette_font_size = 12.0,
    command_palette_rows = 25,

    -- macos
    macos_window_background_blur = 0,
    native_macos_fullscreen_mode = true,

    -- window
    window_decorations = 'TITLE | RESIZE',
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
    enable_tab_bar = false,
}
