local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use "kyazdani42/nvim-web-devicons" -- Icons for various plugins.
  use "kyazdani42/nvim-tree.lua" -- A File Explorer For Neovim Written In Lua
  use "akinsho/bufferline.nvim" -- A snazzy buffer line (with tabpage integration) for Neovim built using lua.
  use "moll/vim-bbye" -- Bbye allows you to do delete buffers (close files) without closing your windows or messing up your layout.
  use "nvim-lualine/lualine.nvim" -- A blazing fast and easy to configure Neovim statusline written in Lua.
  use "akinsho/toggleterm.nvim" -- A neovim plugin to persist and toggle multiple terminals during an editing session
  use "ahmedkhalf/project.nvim" -- all in one neovim plugin written in lua that provides superior project management.
  use "lewis6991/impatient.nvim" -- Speed up loading Lua modules in Neovim to improve startup time.
  use "lukas-reineke/indent-blankline.nvim" -- This plugin adds indentation guides to all lines (including empty lines).
  use "goolord/alpha-nvim" -- fast and fully customizable greeter for neovim.
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim" -- displays a popup with possible key bindings of the command you started typing

  -- Colorschemes
  use "navarasu/onedark.nvim"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- nvim-cmp source for neovim's built-in language server client

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Markdown preview
  use "ellisonleao/glow.nvim" -- A glow preview directly in your neovim buffer.
  use "davidgranstrom/nvim-markdown-preview" -- Markdown preview in the browser using pandoc and live-server through Neovim's job-control API.

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
