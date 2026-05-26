local wezterm = require('wezterm')
local platform = require('utils.platform')

local act = wezterm.action
local mod = {}

if platform.is_mac then
    mod.SUPER = 'SUPER'
    mod.SUPER_REV = 'SUPER|CTRL'
elseif platform.is_linux then
    mod.SUPER = 'ALT'
    mod.SUPER_REV = 'ALT|CTRL'
end

local function is_vim(pane)
    -- return pane:get_user_vars().IS_NVIM == 'true'
    local process_name = pane:get_foreground_process_name()
    if process_name then
        process_name = process_name:lower()
        if process_name:find('n?vim') then
            return true
        end
    end
    local title = pane:get_title():lower()
    return title:find('n?vim') ~= nil
end

local direction_keys = {
    h = 'Left',
    j = 'Down',
    k = 'Up',
    l = 'Right',
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end


--- @type Key[]
local keys = {
    --- misc
    { key = 'Enter', mods = 'LEADER', action = act.ActivateCopyMode },
    { key = 'F1', mods = 'NONE', action = act.ActivateCommandPalette },
    { key = 'F2', mods = 'NONE', action = act.ShowLauncher },
    { key = 'F3', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
    {
        key = 'F4',
        mods = 'NONE',
        action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
    },
    { key = 'F11', mods = 'NONE',    action = act.ToggleFullScreen },
    { key = 'F12', mods = 'NONE',    action = act.ShowDebugOverlay },
    { key = 'f',   mods = mod.SUPER, action = act.Search({ CaseInSensitiveString = '' }) },
    {
      key = 'u',
      mods = mod.SUPER_REV,
      action = wezterm.action.QuickSelectArgs({
         label = 'open url',
         patterns = {
            '\\((https?://\\S+)\\)',
            '\\[(https?://\\S+)\\]',
            '\\{(https?://\\S+)\\}',
            '<(https?://\\S+)>',
            '\\bhttps?://\\S+[)/a-zA-Z0-9-]+'
         },
         action = wezterm.action_callback(function(window, pane)
            local url = window:get_selection_text_for_pane(pane)
            wezterm.log_info('opening: ' .. url)
            wezterm.open_with(url)
         end),
      }),
    },

   -- copy/paste --
   { key = 'c',          mods = 'CTRL|SHIFT',  action = act.CopyTo('Clipboard') },
   { key = 'v',          mods = 'CTRL|SHIFT',  action = act.PasteFrom('Clipboard') },
   -- tabs --
   -- tabs: spawn+close
   { key = 't',          mods = mod.SUPER,     action = act.SpawnTab('CurrentPaneDomain') },
   { key = 'w',          mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = false }) },

   -- tabs: navigation
   { key = '[',          mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
   { key = ']',          mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
   { key = '[',          mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
   { key = ']',          mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

   -- tab: title
   { key = '0',          mods = mod.SUPER,     action = act.EmitEvent('tabs.manual-update-tab-title') },
   { key = '0',          mods = mod.SUPER_REV, action = act.EmitEvent('tabs.reset-tab-title') },

   -- tab: hide tab-bar
   { key = 't',          mods = "LEADER",     action = act.EmitEvent('tabs.toggle-tab-bar'), },

   -- window --
   -- window: spawn windows
   { key = 'n',          mods = mod.SUPER,     action = act.SpawnWindow },

   -- window: zoom window
   {
      key = '-',
      mods = mod.SUPER,
      action = wezterm.action_callback(function(window, _pane)
         local dimensions = window:get_dimensions()
         local new_width = dimensions.pixel_width - 50
         local new_height = dimensions.pixel_height - 50
         window:set_inner_size(new_width, new_height)
      end)
   },
   {
      key = '=',
      mods = mod.SUPER,
      action = wezterm.action_callback(function(window, _pane)
         local dimensions = window:get_dimensions()
         local new_width = dimensions.pixel_width + 50
         local new_height = dimensions.pixel_height + 50
         window:set_inner_size(new_width, new_height)
      end)
   },
   {
      key = 'Enter',
      mods = mod.SUPER_REV,
      action = wezterm.action_callback(function(window, _pane)
         window:maximize()
      end)
   },
    --- panes --
   -- panes: split panes
   {
      key = "-",
      mods = "LEADER",
      action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
   },
   {
      key = "=",
      mods = "LEADER",
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
   },
   {
      key = "\\",
      mods = "LEADER",
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
   },

   -- panes: zoom+close pane
   { key = 'z',     mods = "LEADER",     action = act.TogglePaneZoomState },
   { key = 'w',     mods = "LEADER",     action = act.CloseCurrentPane({ confirm = false }) },

   -- panes: navigation
   split_nav('move', 'h'),
   split_nav('move', 'j'),
   split_nav('move', 'k'),
   split_nav('move', 'l'),

   -- resize panes
   split_nav('resize', 'h'),
   split_nav('resize', 'j'),
   split_nav('resize', 'k'),
   split_nav('resize', 'l'),

   -- pane selection
   {
      key = 'p',
      mods = 'LEADER',
      action = act.PaneSelect({ mode = 'Activate' }),
   },
   {
      key = 's',
      mods = 'LEADER',
      action = act.PaneSelect({ mode = 'SwapWithActiveKeepFocus' }),
   },


   -- panes: scroll pane
   { key = 'u',        mods = mod.SUPER, action = act.ScrollByLine(-5) },
   { key = 'd',        mods = mod.SUPER, action = act.ScrollByLine(5) },
   { key = 'PageUp',   mods = 'NONE',    action = act.ScrollByPage(-0.75) },
   { key = 'PageDown', mods = 'NONE',    action = act.ScrollByPage(0.75) },

   -- key-tables --
   -- resizes fonts
   {
      key = 'f',
      mods = 'LEADER',
      action = act.ActivateKeyTable({
         name = 'resize_font',
         one_shot = false,
         timeout_milliseconds = 1000,
      }),
   },

   -- resizes panes
   {
        key = 'w',
        mods = 'LEADER',
        action = act.ActivateKeyTable({
            name = 'resize_pane',
            one_shot = false,
            timeout_milliseconds = 1000,
        }),
    },

   -- rename
   {
        key = 'r',
        mods = 'LEADER',
        action = act.PromptInputLine({
            description = 'Enter new name for tab',
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        }),
   },

    -- trigger clear sequence
    {
        key = 'l',
        mods = 'LEADER',
        action = act.Multiple {
            act.ClearScrollback 'ScrollbackAndViewport',
            act.SendKey { key = 'l', mods = 'CTRL' },
        },
    },
}

-- stylua: ignore
---@type table<string, Key[]>
local key_tables = {
   resize_font = {
      { key = 'k',      action = act.IncreaseFontSize },
      { key = 'j',      action = act.DecreaseFontSize },
      { key = 'r',      action = act.ResetFontSize },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q',      action = 'PopKeyTable' },
   },
   resize_pane = {
      { key = 'k',      action = act.AdjustPaneSize({ 'Up', 1 }) },
      { key = 'j',      action = act.AdjustPaneSize({ 'Down', 1 }) },
      { key = 'h',      action = act.AdjustPaneSize({ 'Left', 1 }) },
      { key = 'l',      action = act.AdjustPaneSize({ 'Right', 1 }) },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q',      action = 'PopKeyTable' },
   },
}

---@type MouseBinding[]
local mouse_bindings = {
   -- Ctrl-click will open the link under the mouse cursor
   {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
   },
}

--- @type Config
return {
    disable_default_key_bindings = true,
    leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = keys,
    key_tables = key_tables,
    mouse_bindings = mouse_bindings,
}
