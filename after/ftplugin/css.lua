--
-- ░█▀▀░█▀▀░█▀▀░░░░█░░░█░█░█▀█
-- ░█░░░▀▀█░▀▀█░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀▀▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀

vim.bo.shiftwidth  = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.css',
    command = 'silent ! ~/.local/bin/reloadLocalFile'
})
