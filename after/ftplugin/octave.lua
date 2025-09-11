
function RunOctave()
    vim.api.nvim_command('update!')
    vim.api.nvim_command('below split')
    vim.api.nvim_command('term octave %')
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.m',
    command = 'nnoremap <leader>r :lua RunOctave()<CR>'
})
