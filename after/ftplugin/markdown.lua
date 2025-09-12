--
-- ░█▄█░█▀█░█▀▄░█░█░█▀▄░█▀█░█░█░█▀█░░░░█░░░█░█░█▀█
-- ░█░█░█▀█░█▀▄░█▀▄░█░█░█░█░█▄█░█░█░░░░█░░░█░█░█▀█
-- ░▀░▀░▀░▀░▀░▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀

vim.bo.shiftwidth = 0
vim.bo.tabstop = 2
vim.bo.softtabstop = 2

vim.api.nvim_create_user_command(
  'Table',
  function (args)

    local values = vim.fn.split(args.args, ' ')
    for i, value in ipairs(values) do
      values[i] = tonumber(vim.fn.trim(value))
    end

    local num_rows = values[1]
    local num_cols = values[2]

     if not num_rows or not num_cols then
      vim.api.nvim_err_writeln("Error: args rows & cols missing in Table")
      return
    end

    local table_lines = {
        "|" .. string.rep(" |", num_cols),
        "|" .. string.rep(" - |", num_cols)
    }

    for row = 1, num_rows do
        local cell_line = "|"
        for col = 1, num_cols do
            cell_line = cell_line .. "" ..  " |"
        end
        table.insert(table_lines, cell_line)
    end

    local current_line = vim.fn.line('.')
    vim.fn.append(current_line, table_lines)  
    vim.cmd("normal! j0l")
  end,
  { nargs = "*", bang = true, desc = "Insert a Markdown table of specified rows and columns" }
)

vim.api.nvim_create_user_command(
  'FixTable',
  ":echo 'To FixTable use `V` to select range then press <leadr>t`'",
  {bang = true, desc="Instructions for fixing tables in quarto."}
)

vim.keymap.set('v', '<leader>t', '!pandoc -t markdown-simple_tables<CR>',
  { silent = true, desc = 'Align selected md table using pandoc' })

vim.cmd [[ 
setlocal spell
setlocal spellcapcheck=\_[\])'"   ]\+
setlocal complete+=kspell

command! ViewImage execute('normal! yi):silent ! pqiv " &<CR>')
command! MakeJump execute('update! | normal! vi[yvi(gf/# "<CR>zt0')

" syntax region ConcealedCode matchgroup=ConcealGroup start=/`/ end=/`/ concealends contains=ConcealCheck
"
" syntax region ConcealBlockCode start=/```/ end=/```/ concealends
"
" syntax region MyBlock start=/^\s*>/ end=/^\s*$/

]]

