-- -----------------------------------------------------------------------------
--        _             _           
--  _ __ | |_   _  __ _(_)_ __  ___ 
-- | '_ \| | | | |/ _` | | '_ \/ __|
-- | |_) | | |_| | (_| | | | | \__ \
-- | .__/|_|\__,_|\__, |_|_| |_|___/
-- |_|            |___/             
-- -----------------------------------------------------------------------------

-- User plugins
lvim.plugins = {
  { "navarasu/onedark.nvim" }, -- One Dark Colorscheme
  { "ckipp01/nvim-jenkinsfile-linter", ft = "groovy" },
  { "windwp/nvim-spectre" }, -- Find and Replace tool
}

-- Remove `ansiblels` from `skipped_servers` list
lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "ansiblels"
end, lvim.lsp.automatic_configuration.skipped_servers)

-- -----------------------------------------------------------------------------
--              _   _                 
--   ___  _ __ | |_(_) ___  _ __  ___ 
--  / _ \| '_ \| __| |/ _ \| '_ \/ __|
-- | (_) | |_) | |_| | (_) | | | \__ \
--  \___/| .__/ \__|_|\___/|_| |_|___/
--       |_|                          
-- -----------------------------------------------------------------------------

vim.opt.timeoutlen = 100                          -- show whichkey faster
vim.opt.foldmethod = "expr"                       -- enable folding by expression
vim.opt.foldexpr   = "nvim_treesitter#foldexpr()" -- use treesitter for folding
vim.opt.foldenable = false                        -- don't fold on file open
vim.opt.foldlevel  = 99                           -- don't fold everything by default

-- -----------------------------------------------------------------------------
--  _                                          _                 
-- | | _____ _   _ _ __ ___   __ _ _ __  _ __ (_)_ __   __ _ ___ 
-- | |/ / _ \ | | | '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` / __|
-- |   <  __/ |_| | | | | | | (_| | |_) | |_) | | | | | (_| \__ \
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
--           |___/                |_|   |_|            |___/     
-- -----------------------------------------------------------------------------

-- Navigate between buffers
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<cr>"

-- Whichkey remaps
lvim.builtin.which_key.mappings.b['c'] = { "<cmd>enew<CR>", "Create" }
lvim.builtin.which_key.mappings['F'] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" }
lvim.builtin.which_key.mappings['n'] = { "<cmd>set filetype=yaml.ansible<CR>", "AnsibleLS" }
lvim.builtin.which_key.mappings['r'] = { "<cmd>set wrap!<CR>", "Toggle Wrap" }
lvim.builtin.which_key.mappings['q'] = { "<cmd>confirm qa<CR>", "Quit" }

-- Show in whichkey bindings for folds, spelling and others prefixed with z
lvim.builtin.which_key.setup.plugins.presets.z = true

-- Unmap toggleterm keybindings
lvim.keys.term_mode["<C-h>"] = {}
lvim.keys.term_mode["<C-j>"] = {}
lvim.keys.term_mode["<C-k>"] = {}
lvim.keys.term_mode["<C-l>"] = {}

-- Nvim-tree remaps
local function custom_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  local useful_keys = {
    ["h"] = { api.node.navigate.parent_close, opts "Close Directory" },
    ["l"] = { api.node.open.edit, opts "Open" },
    ["o"] = { api.node.run.system, opts "Run System" },
    ["<CR>"] = { api.node.open.edit, opts "Open" },
    ["v"] = { api.node.open.vertical, opts "Open: Vertical Split" },
    ["s"] = { api.node.open.horizontal, opts "Open: Horizontal Split" },
    ["C"] = { api.tree.change_root_to_node, opts "CD" },
  }

  require("lvim.keymappings").load_mode("n", useful_keys)
end
lvim.builtin.nvimtree.setup.on_attach = custom_on_attach

-- -----------------------------------------------------------------------------
--              _                           _ 
--   __ _ _   _| |_ ___   ___ _ __ ___   __| |
--  / _` | | | | __/ _ \ / __| '_ ` _ \ / _` |
-- | (_| | |_| | || (_) | (__| | | | | | (_| |
--  \__,_|\__,_|\__\___/ \___|_| |_| |_|\__,_|
--                                            
-- -----------------------------------------------------------------------------

-- Automatic filetype for Ansible files
-- vim.api.nvim_create_autocmd({"BufRead"}, {
--   pattern = {
--     "*playbook*.yml",
--     "*playbook*.yaml",
--     "playbooks/*.yml",
--     "playbooks/*.yaml",
--     "*/roles/*/tasks/*.yml",
--     "*/roles/*/tasks/*.yaml",
--   },
--   command = "set filetype=yaml.ansible",
-- })

-- Automatic filetype for Jenkinsfiles
vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = {
    "Jenkinsfile",
  },
  command = "set filetype=groovy",
})

-- Disable terraform-ls for .tfvars files
vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = {
    "*.tfvars",
  },
  command = "set filetype=config",
})

-- -----------------------------------------------------------------------------
--  _          _                     
-- | |__   ___| |_ __   ___ _ __ ___ 
-- | '_ \ / _ \ | '_ \ / _ \ '__/ __|
-- | | | |  __/ | |_) |  __/ |  \__ \
-- |_| |_|\___|_| .__/ \___|_|  |___/
--              |_|                  
-- -----------------------------------------------------------------------------

-- Groovy highlighting
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.groovy = {
  install_info = {
    url = "https://github.com/Decodetalkers/tree-sitter-groovy.git", -- local path or git repo
    files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "master", -- default branch in case of git repo if different from master
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "groovy", -- if filetype does not match the parser name
}
