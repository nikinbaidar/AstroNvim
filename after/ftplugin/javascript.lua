--
-- ░▀▀█░█▀█░█░█░█▀█░█▀▀░█▀▀░█▀▄░▀█▀░█▀█░▀█▀░░░░█░░░█░█░█▀█
-- ░░░█░█▀█░▀▄▀░█▀█░▀▀█░█░░░█▀▄░░█░░█▀▀░░█░░░░░█░░░█░█░█▀█
-- ░▀▀░░▀░▀░░▀░░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░░░░▀░░▀░░▀▀▀░▀▀▀░▀░▀

function RunJavaScript()
    vim.api.nvim_command('update!')
    vim.api.nvim_command('below split')
    vim.api.nvim_command('term node %')
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.js',
    command = 'nnoremap <leader>r :lua RunJavaScript()<CR>'
})

-- vim.wo.foldmethod = "indent"
vim.bo.shiftwidth  = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.wo.colorcolumn = "95"
