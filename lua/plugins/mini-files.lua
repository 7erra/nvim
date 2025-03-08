return {
  "echasnovski/mini.files",
  opts = {
    content = {
      filter = function(fs_entry)
        -- List of LaTeX temporary file extensions to exclude
        local exclude_patterns =
          { ".aux", ".log", ".toc", ".out", ".fls", ".fdb_latexmk", ".loc", ".soc", ".bbl", ".bcf", ".blg", ".run.xml" }

        -- Loop through the patterns and exclude files that match
        for _, pattern in ipairs(exclude_patterns) do
          if vim.endswith(fs_entry.name, pattern) then
            return false -- Do not show the file
          end
        end

        return true -- Show other files
      end,
    },
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 30,
    },
    options = {
      -- Whether to use for editing directories
      -- Disabled by default in LazyVim because neo-tree is used for that
      use_as_default_explorer = true,
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },
}
