--[[

  A simple Neovim configuration in Lua
  Author: Gemini
  Description: Provides the Gruvbox theme and basic quality-of-life features.

  Installation:
  1. Make sure you have Neovim v0.8.0+ installed.
  2. Create the config directory if it doesn't exist:
     mkdir -p ~/.config/nvim
  3. Place this file as `init.lua` inside that directory:
     ~/.config/nvim/init.lua
  4. Start Neovim (`nvim`). The plugins will be installed automatically.
  5. Restart Neovim to see the changes.

--]]

--==============================================================================
-- OPTIONS
--==============================================================================
-- For more options, see `:help option-list`

vim.g.mapleader = " " -- Set the leader key to the space bar
vim.g.maplocalleader = " " -- Set the local leader key to the space bar

local opt = vim.opt -- A shorthand for setting options

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 -- Hide * markup for bold and italic in markdown
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case in search patterns
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3 -- global statusline
opt.list = true -- Show some invisible characters (tabs, newlines, etc.)
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print the line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Show relative line numbers
opt.scrolloff = 8 -- Lines of context around the cursor
opt.shiftwidth = 2 -- Size of an indent
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context around the cursor
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spell = false
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300 -- Lower timeout for keypress combinations
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wrap = false -- Disable line wrapping

--==============================================================================
-- LAZY.NVIM - PLUGIN MANAGER
--==============================================================================

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

-- Define plugins to install
local plugins = {

	-- Gruvbox Theme
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- Load the colorscheme here
			vim.cmd.colorscheme("gruvbox")
		end,
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "gruvbox",
					-- ... other lualine options
				},
			})
		end,
	},

	-- File Explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
		config = function()
			require("nvim-tree").setup({
				-- default settings
			})
		end,
	},
}

-- Setup lazy.nvim
require("lazy").setup(plugins, {})

--==============================================================================
-- KEYMAPS
--==============================================================================
-- For more information, see `:help vim.keymap.set()`

local keymap = vim.keymap -- Shorthand for keymap functions

-- General Keymaps
keymap.set("n", "<leader>pv", vim.cmd.Ex) -- Open file explorer on current file

-- Nvim-tree Keymaps
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Clear search highlighting
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlight" })

-- Move between windows
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

print("Simple Neovim config loaded!")

