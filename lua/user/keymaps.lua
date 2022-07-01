local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- Leader Key
vim.g.mapleader = " "

-- Window navegation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows with arrows
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Explorer
keymap("n", "<leader>e", ":Lex 10<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Scripts
keymap("n", "<leader>c", ":!compiler % <CR>", {})
keymap("n", "<leader>r", ":!runner % <CR>", {})
keymap("n", "<leader>o", ":!opout % <CR>", {})

-- Telescope
keymap("n", "<leader>s", "<cmd>lua require'telescope.builtin'.find_files()<CR>", opts)
keymap("n", "<leader>g", "<cmd>lua require'telescope.builtin'.git_files()<CR>", opts)
keymap("n", "<leader>lg", "<cmd>lua require'telescope.builtin'.live_grep()<CR>", opts)
keymap("n", "<leader>p", "<cmd>Telescope projects<CR>", opts)

-- Format
keymap("n", "<leader>f", ":lua vim.lsp.buf.formatting_sync()<CR>", opts)
