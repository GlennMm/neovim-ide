
vim.g.ayucolor="dark"
vim.g.gruvbox_termcolors=16

local colorscheme = "ayu"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
