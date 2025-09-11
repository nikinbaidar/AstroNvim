--
-- ░█░█░█▀▀░█░░░█▀█░░░░█░░░█░█░█▀█
-- ░█▀█░█▀▀░█░░░█▀▀░░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░▀▀▀░▀░░░▀░░▀▀▀░▀▀▀░▀░▀

vim.opt.number         = true
vim.opt.relativenumber = true

-- Normal mode mappings
vim.api.nvim_set_keymap('n', '<CR>', '<C-]>', { noremap = true })
vim.api.nvim_set_keymap('n', '<BS>', '<C-T>', { noremap = true, })
