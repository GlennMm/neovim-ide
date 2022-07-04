vim.g.copilot_filetypes = { xml = false }

vim.cmd[[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]] 
vim.g.copilot_no_tab_map = true
-- vim.keymap.set('i', "<C-a>", ":copilot#Accept('\\<CR>')<CR>", { silent = true })


vim.cmd[[highlight CopilotSuggestions guifg=#555555 ctermfg=8]]
