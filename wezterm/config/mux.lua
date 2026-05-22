---@type Config
return {
    unix_domains = {
        {
            name = 'unix',
        },
    },
    default_gui_startup_args = { 'connect', 'unix' },
    set_clipboard_when_supported = true,
}
