local wezterm = require('wezterm')

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

--config.color_scheme = 'Firewatch'
--config.color_scheme = 'Solarized Dark Higher Contrast'
--config.color_scheme = 'GitHub Dark'
config.color_scheme = 'DimmedMonokai'

config.font = wezterm.font('Hack', { weight = 'Regular' })
config.font_size = 18

config.use_ime = true
config.ime_preedit_rendering = 'Builtin'
-- config.xim_im_name = 'fcitx'
-- MEMO: fcitx5-configtool -> Addons -> X Input Method Frontend -> Use On The Spot Style

config.hide_tab_bar_if_only_one_tab = true

config.keys = {
  {
    key = '\\',
    mods = 'CTRL|ALT',
    action = wezterm.action.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  {
    key = 'a',
    mods = 'CTRL|ALT',
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
}

return config
