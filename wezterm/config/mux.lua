---@type Config
return {
    unix_domains = {
        {
            name = 'unix',
        },
    },
    default_gui_startup_args = { 'connect', 'unix' },
    mux_output_size_strategy = 'ActiveClient',
}
