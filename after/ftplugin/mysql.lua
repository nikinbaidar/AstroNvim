vim.cmd [[
setlocal wrap
map <leader>r vip<leader>S<CR>
vmap <leader>r <leader>S<CR>
]]


vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.mysql',
    command = 'map <leader>r vip<leader>S | vmap <leader>r <leader>S'
})
