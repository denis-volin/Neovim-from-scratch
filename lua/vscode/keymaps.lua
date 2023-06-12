local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Whichkey
keymap("n", "<Space>", ":call VSCodeNotify('whichkey.show')<CR>", opts)

-- Panels navigation
keymap("n", "<C-h>", ":call VSCodeNotify('workbench.action.navigateLeft')<CR>", opts)
keymap("n", "<C-j>", ":call VSCodeNotify('workbench.action.navigateDown')<CR>", opts)
keymap("n", "<C-k>", ":call VSCodeNotify('workbench.action.navigateUp')<CR>", opts)
keymap("n", "<C-l>", ":call VSCodeNotify('workbench.action.navigateRight')<CR>", opts)

-- Tabs navigation
keymap("n", "<S-l>", ":call VSCodeNotify('workbench.action.nextEditor')<CR>", opts)
keymap("n", "<S-h>", ":call VSCodeNotify('workbench.action.previousEditor')<CR>", opts)

-- Undo/redo
keymap("n", "u", ":call VSCodeNotify('undo')<CR>", opts)
keymap("n", "<C-r>", ":call VSCodeNotify('redo')<CR>", opts)

-- Indent lines
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Surround inside selection
keymap("v", "\"", "xi\"\"<Esc>P", opts)
keymap("v", "\'", "xi\'\'<Esc>P", opts)
keymap("v", "(", "xi()<Esc>P", opts)
keymap("v", ")", "xi()<Esc>P", opts)
keymap("v", "{", "xi{}<Esc>P", opts)
keymap("v", "}", "xi{}<Esc>P", opts)
