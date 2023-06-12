local options = {
  clipboard = "unnamedplus",  -- allows neovim to access the system clipboard
  ignorecase = true,          -- ignore case in search patterns
  smartcase = true,           -- don't ingnore case if the search pattern contains upper case characters
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
