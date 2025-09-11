--
-- ░█░░░█░█░█▀█░░░░█░░░█░█░█▀█
-- ░█░░░█░█░█▀█░░░░█░░░█░█░█▀█
-- ░▀▀▀░▀▀▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀

function RunLua()
    vim.api.nvim_command('update!')
    vim.api.nvim_command('below split')
    vim.api.nvim_command('term lua %')
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.lua',
    command = 'nnoremap <leader>r :lua RunLua()<CR>'
})
