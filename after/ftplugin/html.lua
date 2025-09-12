--
-- ░█░█░▀█▀░█▄█░█░░░░░░█░░░█░█░█▀█
-- ░█▀█░░█░░█░█░█░░░░░░█░░░█░█░█▀█
-- ░▀░▀░░▀░░▀░▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀

vim.bo.shiftwidth  = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.wo.colorcolumn = "95"

vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})
vim.api.nvim_set_keymap('n', '0', 'g0', {noremap = true})
vim.api.nvim_set_keymap('n', '$', 'g$', {noremap = true})
vim.api.nvim_set_keymap('n', '^', 'g^', {noremap = true})

vim.api.nvim_create_user_command( 'LiveServerStart',
    function()
        vim.api.nvim_command('update!')
        vim.api.nvim_command('silent ! live-server --quiet --no-css-inject --open=% &')
        vim.api.nvim_command('silent ! pgrep -n node >> /tmp/x')
    end,
    {bang = true, desc = "Start LiveServer"}
)


vim.api.nvim_create_user_command('LiveServerStop',
  function()
      vim.api.nvim_command('silent ! kill -9 $(cat /tmp/x)')
      vim.api.nvim_command('silent ! rm -f /tmp/x)')
  end,
  {bang = true, desc = "Stop LiveServer"}
)

