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

local dein_dir = cache_home .. "/dein"
local dein_repo_dir = dein_dir .. "/repos/github.com/Shougo/dein.vim"

-- bootstrap
if not isdir(dein_repo_dir) then
	print("dein is not installed. start install...")
	vim.cmd("!git clone https://github.com/Shougo/dein.vim " .. dein_repo_dir)
end

vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.mapleader = t'<Space>'

vim.cmd("let &runtimepath = '" .. dein_repo_dir .. "'.','. &runtimepath")
if vim.fn['dein#load_state'](dein_dir) == 1 then
	vim.fn['dein#begin'](dein_dir)
	vim.fn['dein#load_toml'](cfg_dir .. "/dein/dein.toml", {lazy = 0})
	vim.fn['dein#load_toml'](cfg_dir .. "/dein/dein_lazy.toml", {lazy = 1})
	vim.fn['dein#end']()
	vim.fn['dein#save_state']()
end

if (vim.fn['dein#check_install']() ~= 0) then
  vim.fn['dein#install']()
end

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
