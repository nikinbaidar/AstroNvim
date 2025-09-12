-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }
--

vim.cmd('autocmd BufWritePost astrocore.lua so | AstroReload')
vim.api.nvim_set_keymap('i', '<C-z>', '<C-[>[s1z=`]a', {noremap = true})

vim.api.nvim_create_augroup("neotree_autoopen", { clear = true })
vim.api.nvim_create_autocmd("BufRead", {
  desc = "Open neo-tree on enter",
  group = "neotree_autoopen",
  once = true,
  callback = function()
    if not vim.g.neotree_opened then
      vim.cmd "Neotree show"
      vim.g.neotree_opened = true
    end
  end,
})

vim.cmd [[

function! CopyMatches(reg, start, end) range
    " Copies all matched patterns of the most recent search.
    " a,bCopyMatches copies matched patterns from lines a to b.
    let hits = []
    let reg = empty(a:reg) ? '+' : a:reg
    let range = (a:start == a:end) ? '%' : a:start.','.a:end 
    execute range.'s//\=len(add(hits, submatch(0))) ? submatch(0) : ""/gne'
    execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction

command! -nargs=* -range -register CopyMatches call CopyMatches(<q-reg>, <line1>, <line2>)
set spell

hi! link SpellCap Normal 
set listchars=trail:␣


]]

