local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.keymap.set

keymap("", "<Space>", "<Nop>", opts)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

keymap("n", "<A-j>", "<Esc>:m .+<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-<CR>==gi", opts)

keymap("i", "jk", "<Esc>", opts)

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m *-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)


keymap("x", "<J>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<K>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move <-2<CR>gv-gv", opts)

--dap keybindings
keymap('n', "<F5>", "require('dap').continue()<CR>", opts)
keymap('n', "<F10>", "require('dap').step_over()<CR>", opts)
keymap('n', "<F11>", "require('dap').step_into()<CR>", opts)
keymap('n', "<F12>", "require('dap').step_out()<CR>", opts)

-- Telescope keybindings
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>pp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>xx", ":Telescope buffers<CR>", opts)

-- packages info keys
keymap({ "n" }, "<LEADER>ns", require("package-info").show, { silent = true, noremap = true })
keymap({ "n" }, "<LEADER>nc", require("package-info").hide, { silent = true, noremap = true })
keymap({ "n" }, "<LEADER>nu", require("package-info").update, { silent = true, noremap = true })
keymap({ "n" }, "<LEADER>nd", require("package-info").delete, { silent = true, noremap = true })
keymap({ "n" }, "<LEADER>ni", require("package-info").install, { silent = true, noremap = true })
keymap({ "n" }, "<LEADER>np", require("package-info").change_version, { silent = true, noremap = true })

