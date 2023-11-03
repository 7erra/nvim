-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- User commands
local command = vim.api.nvim_create_user_command
command("SnipsEdit", require("luasnip.loaders").edit_snippet_files, {})

-- Load snippets
require("luasnip.loaders.from_snipmate").lazy_load()
