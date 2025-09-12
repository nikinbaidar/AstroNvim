--
-- ░▀█▀░█▀▀░█░█░░░░█░░░█░█░█▀█
-- ░░█░░█▀▀░▄▀▄░░░░█░░░█░█░█▀█
-- ░░▀░░▀▀▀░▀░▀░▀░░▀▀▀░▀▀▀░▀░▀

local function is_tty()
    return vim.fn.exists('$TERM_PROGRAM') == 0
end

vim.api.nvim_set_keymap('i', '<C-z>', '<C-[>[s1z=`]a', {noremap = true})

vim.b.spell = true

vim.keymap.set('n', '<leader>v',  
function()
    local filepath = vim.fn.expand('%:r') .. ".pdf"
    vim.api.nvim_command("silent ! sioyek " .. filepath)
end
)


vim.api.nvim_create_user_command(
'SeePdf',
function()
    local filepath = vim.fn.expand('%:r') .. ".pdf"
    vim.api.nvim_command("silent ! tmux split-pane -h 'pdf2txt " .. filepath .. "'")
end, 
{bang = true, desc = "Add bibliography to tex docs"}
)


vim.api.nvim_create_user_command(
'AddBibliography',
function()
    vim.api.nvim_command("! clear ; biber %:r")
    vim.api.nvim_command("silent call RunLatex()")
end, 
{bang = true, desc = "Add bibliography to tex docs"}
)

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*.tex',
    command = 'nnoremap <leader>r :call RunLatex()<CR>'
})

-- Get current cursor position
-- local r,c = unpack(vim.api.nvim_win_get_cursor(0))
--
--

vim.cmd [[

function! ViewPDF()
let g:headmost = getline(1)
let g:documentclass = execute("g/documentclass/z#.1")
if (g:documentclass !~ "Pattern not found: documentclass")
    let g:pdffile = expand("%:r").".pdf"
elseif (g:headmost[0] =~ "%")
    let g:headmost_length = strlen(g:headmost) - 5
    let g:source_path = g:headmost[2:g:headmost_length]
    let g:pdffile = expand(g:source_path).".pdf"
    if empty(expand(glob("./" . g:pdffile)))
        let g:pdffile = "../".g:pdffile
        endif
        endif
        execute ("silent ! maggie &") g:pdffile
        endfunction

        function! BiblatexCompile()
        :! clear ; biber %:r
        silent call RunLatex()
        endfunction

        function! CompileSource()

        let g:headmost = getline(1)
        if g:headmost[0] =~ "%"
            let g:source_path = getline(1)[2:]
            if ! empty(expand(glob("./" . g:source_path)))
                " Source in current directory
                below split
                resize 15
                execute ("term lualatex --shell-escape") g:source_path
            elseif ! empty(expand(glob("../" .g:source_path)))
                " Source in previous directory
                below split
                resize 15
                cd .. | execute ("term lualatex --shell-escape") g:source_path | cd -
                endif
                endif
                endfunction

                function! RunLatex()
                    silent! execute '%s/\v(^|\s)(|[{[(]|)"/\1\2``/g'
                    silent! execute '%s/\v(^|\s)(|[{[(]})''/\1\2`/g'
                    update!
                    if expand('%:e') =~ "dn"
                        call AddDevanagari()
                    else
                        normal! mh
                        let g:documentclass = execute("g/documentclass/z#.1")
                        normal! `hzz
                        if g:documentclass =~ "Pattern not found: documentclass"
                            " Current file is not a source file.
                            call CompileSource()
                        else
                            " Current file is a source file.
                            below split
                            resize 15
                            term lualatex --shell-escape %
                            endif
                            endif
                        endfunction

                    function! AddDevanagari()
                        let g:texfile = expand("%:r").".tex"
                        execute("silent term devnag % | lualatex ") g:texfile
                    endfunction

]]
