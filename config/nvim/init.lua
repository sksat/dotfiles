function env_or_default(env, default)
	local e = os.getenv(env)
	if e == nil then
		return default
	end
	return e
end

function exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

function isdir(path)
   -- "/" works on both Unix and Windows
   return exists(path.."/")
end

local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local home = env_or_default("HOME", "~")
local cfg_home = env_or_default("XDG_CONFIG_HOME", home .. "/.config")
local cache_home = env_or_default("XDG_CACHE_HOME", home .. "/.cache")

local cfg_dir = cfg_home .. "/nvim"

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup("lazy-plugins") -- load lua/lazy-plugins.lua

-- vim.o.{option}: global option
-- vim.bo.{option}: buffer option
-- vim.wo.{option}: window option

vim.wo.number = true
vim.wo.list = true
vim.o.listchars = 'tab:»-,trail:-,extends:»,precedes:«,nbsp:%'

vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

vim.o.modeline = true
vim.o.modelines = 5

vim.o.clipboard = 'unnamedplus'
vim.o.helplang = 'ja'


-- keymap

vim.api.nvim_set_keymap('', ':', ';', {noremap = true})
vim.api.nvim_set_keymap('', ';', ':', {noremap = true})

vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>', {silent = true})
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', {noremap = true})

-- autocmd: https://github.com/neovim/neovim/pull/12378
vim.cmd("autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab")
vim.cmd("autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab")

vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
