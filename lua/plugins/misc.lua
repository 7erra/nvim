local sqf
local localVimSqf = [[P:\vim-sqf]]
if vim.fn.isdirectory(localVimSqf) then
  sqf = { dir = localVimSqf }
else
  sqf = { "KoffeinFlummi/vim-sqf" }
end

return {
  "gpanders/editorconfig.nvim",
  {
    dir = [[P:\vim-sqf]],
    cond = vim.fn.isdirectory([[P:\vim-sqf]]),
  },
  sqf,
}
