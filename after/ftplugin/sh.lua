--
-- ░█▀▀░█░█░░░░█░░░█░█░█▀█
-- ░▀▀█░█▀█░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀

function RunBash()
    vim.api.nvim_command('update!')
    vim.api.nvim_command('below split')
    vim.api.nvim_command('term bash %')
    vim.api.nvim_command('normal! G')
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.sh',
    command = 'nnoremap <leader>r :lua RunBash()<CR>'
})

vim.api.nvim_create_autocmd('Filetype', {
    pattern = 'sh',
    command = 'nnoremap <leader>r :lua RunBash()<CR>'
})
