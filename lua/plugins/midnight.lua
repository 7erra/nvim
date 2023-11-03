-- LazySpec (plugin specification)
return {
  { "dasupradyumna/midnight.nvim", lazy = true, priority = 1000 },
  -- `lazy` and `priority` are only needed if this is your primary colorscheme to load it first
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "midnight",
    },
  },
}
