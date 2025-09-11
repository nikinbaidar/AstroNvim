--
-- ░█▀█░█▀▀░▀█▀░█▀▄░█░█░░░░█░░░█░█░█▀█
-- ░█░█░█▀▀░░█░░█▀▄░█▄█░░░░█░░░█░█░█▀█
-- ░▀░▀░▀▀▀░░▀░░▀░▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀

vim.api.nvim_buf_set_option(0, 'bufhidden', 'delete')
vim.api.nvim_win_set_option(0, 'colorcolumn', '')
vim.g.netrw_dirhistmax = 0
vim.g.netrw_bufsettings = 'number nowrap noma nomod nobl ro'
vim.g.netrw_list_hide = [['\(^\|\s\s\)\zs\.\S\+,.*\.class$']]
