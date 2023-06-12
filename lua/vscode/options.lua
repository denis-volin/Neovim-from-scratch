local options = {
  clipboard = "unnamedplus",  -- allows neovim to access the system clipboard
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
