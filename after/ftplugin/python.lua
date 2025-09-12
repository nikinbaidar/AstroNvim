--
-- ░█▀█░█░█░▀█▀░█░█░█▀█░█▀█░░░░█░░░█░█░█▀█
-- ░█▀▀░░█░░░█░░█▀█░█░█░█░█░░░░█░░░█░█░█▀█
-- ░▀░░░░▀░░░▀░░▀░▀░▀▀▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀

vim.opt.foldmethod = "syntax"

function RunPython()
    vim.api.nvim_command('update!')
    vim.api.nvim_command('below split')
    vim.api.nvim_command('term python %')
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.py',
    command = 'nnoremap <leader>r :lua RunPython()<CR>'
})
