-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
if vim.fn.has("linux") == 1 then
  print("linux")
  vim.g.python3_host_prog = "/usr/bin/python3"
elseif vim.fn.has("win32") == 1 then
  vim.o.shell = "pwsh"
  vim.o.shellpipe = ">%s 2 >&1"
  vim.o.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
  vim.g.session_directory = vim.fn.stdpath("data") .. "/sessions"
end
vim.opt.colorcolumn = "81"
vim.opt.clipboard = ""
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99
vim.opt.wrap = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.conceallevel = 0
vim.opt.exrc = true
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.maplocalleader = ","
vim.g.root_spec = { "lsp", "cwd" }
