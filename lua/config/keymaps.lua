-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")

local map = vim.keymap.set

map("n", "<leader>a", "gg0vG$", { desc = "Mark entire file", remap = true })
map("v", "<C-r>", '"hy:%s/<C-r>h//gc<left><left><left>', { desc = "Replace current word in file", remap = true })
map("n", "<leader><Tab>p", function()
  vim.cmd("tabprevious")
end, { desc = "Previous Tab" })
map("n", "<leader><Tab>n", function()
  vim.cmd("tabnext")
end, { desc = "Next Tab" })
map({ "n", "v" }, "<leader>rr", "<Plug>(RestNvim)", { desc = "Run REST under cursor" })
map({ "n", "v" }, "<leader>rp", "<Plug>(RestNvimPreview)", { desc = "Preview the request cURL command" })
map({ "n", "v" }, "<leader>rl", "<Plug>(RestNvimLast)", { desc = "Rerun the last request" })
-- wk.register({ ["<leader>r"] = { name = "+REST" } })
wk.add({ "<leader>r", group = "REST" }, { "<leader>p", group = "+Copilot" })
map("n", "<leader>m", vim.cmd.make, { desc = ":make" })
-- wk.register({ ["<leader>p"] = { name = "+Copilot" } })
-- wk.register({ ["<leader>p"] = { mode = "v", name = "+Copilot" } })
map({ "n", "v" }, "<leader>pc", ":CopilotChat<Enter>", { desc = "Open Copilot Chat" })
map({ "n", "v" }, "<leader>pe", ":CopilotChatExplain<Enter>", { desc = "Explain selection" })
map({ "n", "v" }, "<leader>pf", ":CopilotChatFix<Enter>", { desc = "Fix" })
map({ "n", "v" }, "<leader>pd", ":CopilotChatDocs<Enter>", { desc = "Document selection" })
