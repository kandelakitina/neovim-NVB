local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

opt.swapfile = false -- Disable swap files
opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Time in milliseconds to wait for a mapped sequence to complete.
opt.timeoutlen = 300

-- local opt = vim.opt
-- opt.winbar = "%{%v:lua.require'config.winbar'.get_winbar()%}"

-- Undercurls in TMUX
--[[
vim.cmd [[
  set -g default-terminal "${TERM}"
  set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
  set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
 ]]

--]]

opt.cmdheight = 0

opt.wildignorecase = true
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/.git/*"
opt.wildignore:append "**/build/*"

-- Better Netrw
g.netrw_banner = 0 -- Hide banner
g.netrw_browse_split = 4 -- Open in previous window
g.netrw_altv = 1 -- Open with right splitting
g.netrw_liststyle = 3 -- Tree-style view
g.netrw_list_hide = (vim.fn["netrw_gitignore#Hide"]()) .. [[,\(^\|\s\s\)\zs\.\S\+]] -- use .gitignore