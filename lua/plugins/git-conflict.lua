require("which-key").add({ { "<leader>gr", group = "resolve conflict" } })

return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = true,
  keys = {
    { "<leader>gro", "<Plug>(git-conflict-ours)", desc = "Ours" },
    { "<leader>grt", "<Plug>(git-conflict-theirs)", desc = "Theirs" },
    { "<leader>grb", "<Plug>(git-conflict-both)", desc = "Both" },
    { "<leader>gr0", "<Plug>(git-conflict-none)", desc = "None" },
    { "<leader>grp", "<Plug>(git-conflict-prev-conflict)", desc = "Previous" },
    { "<leader>grn", "<Plug>(git-conflict-next-conflict)", desc = "Next" },
  },
}
