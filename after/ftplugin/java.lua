--
-- ░▀▀█░█▀█░█░█░█▀█░░░░█░░░█░█░█▀█
-- ░░░█░█▀█░▀▄▀░█▀█░░░░█░░░█░█░█▀█
-- ░▀▀░░▀░▀░░▀░░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀

vim.api.nvim_create_user_command(
  'Dispatch',
  function()
    vim.api.nvim_command("! javac -d ./ %")
  end,
  {bang = true, desc = "Create a java package"}
)


vim.keymap.set('n', '<leader>x',  
function()
    vim.api.nvim_command(":g/^import/s/\\.class// | s,/,.,g")
    vim.api.nvim_command(":g/^package/s,/,.,g")
    vim.api.nvim_command("normal! <C-o>")
end,
{desc = "Fix path of a local java packages."}
)


function RunJava()
    vim.api.nvim_command('update!')
    vim.api.nvim_command('below split')
    vim.api.nvim_command('term java %')
end

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.java',
    command = 'nnoremap <leader>r :lua RunJava()<CR>'
})
