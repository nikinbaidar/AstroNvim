vim.cmd [[
setlocal wrap
map <leader>r vip<leader>S
vmap <leader>r <leader>S
]]


vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.sql',
    command = 'map <leader>r vip<leader>S | vmap <leader>r <leader>S'
})
