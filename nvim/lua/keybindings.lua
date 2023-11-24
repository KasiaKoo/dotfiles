-- Fancy Which-Key Bindings
local whichkey = require('which-key')

vim.g.mapleader = ","

-- Terminal keybindings
whichkey.register ({
        t = {
                name = "Terminal",
                t = {"<cmd> ToggleTerm <cr>", "Toggle Terminal"},
                v = {"<cmd> vsplit term://zsh <cr>", "Vertical Split Terminal"},
                h = {"<cmd> split term://zsh <cr>", "Horizontal Split Terminal"}
        }
}, {prefix="<leader>"})

-- File keybindings
whichkey.register ({
        f = {
                name = "File",
                f = {"<cmd> Telescope file_browser hidden=true<cr>", "File Browser"},
                d = {"<cmd> Telescope find_files hidden=true<cr>", "Search Files in Directory"},
                g = {"<cmd> Telescope git_files hidden=true<cr>", "Git Files"},
                r = {"<cmd> Telescope oldfiles <cr>", "Recent Files"},
                s = {"<cmd> Telescope current_buffer_fuzzy_find <cr>", "Search in File"},
                t = {"<cmd> NvimTreeToggle <cr>", "Toggle File Tree"},
                w = {"<cmd> w <cr>", "Write File"},
        }
}, {prefix="<leader>"})

-- Git keybindings
whichkey.register ({
        g = {
                name = "Git",
                g = {"<cmd> Neogit <cr>", "NeoGit Status"},
                f = {"<cmd> Telescope git_files <cr>", "Search Files in Git Repo"}
        }
}, {prefix="<leader>"})

-- Window keybindings
whichkey.register ({
        w = {
                name = "Window",
                v = {"<cmd> vsplit <cr>", "Vertical Split"},
                h = {"<cmd> split <cr>", "Horizontal Split"},
                T = {"<cmd> windo wincmd T <cr>", "Maximise Window"},
                q = {"<cmd> quit <cr>", "Close Window"},
                h = {"<cmd> windo wincmd h <cr>", "Focus Left"},
                j = {"<cmd> windo wincmd j <cr>", "Focus Below"},
                k = {"<cmd> windo wincmd k <cr>", "Focus Above"},
                l = {"<cmd> windo wincmd l <cr>", "Focus Right"},
                H = {"<cmd> windo wincmd H <cr>", "Move Left"},
                J = {"<cmd> windo wincmd J <cr>", "Move Below"},
                K = {"<cmd> windo wincmd K <cr>", "Move Above"},
                L = {"<cmd> windo wincmd L <cr>", "Move Right"},

        }
}, {prefix="<leader>"})

-- Programming bindings
whichkey.register ({
        p = {
                name = "Programming",
                r = {"<plug>(coc-rename)", "Rename Object"},
                d = {"<plug>(coc-definition)", "Go to Definition"},
                i = {"<plug>(coc-references)", "List References"},
                a = {"<plug>(coc-codeaction-cursor)", "Apply Action"},
                b = {"<cmd> VimtexCompile <cr>", "LaTeX Compile"}
        }
}, {prefix="<leader>"})

-- Neovim bindings
whichkey.register ({
        n = {
                name = "Neovim",
                t = {"<cmd> Telescope colorscheme <cr>", "Change Theme"},
                q = {"<cmd> quitall <cr>", "Quit Neovim"},
                p = {"<cmd> PackerSync <cr>", "Update Plugins"},
                h = {"<cmd> Telescope help_tags <cr>", "Help" }
        }
}, {prefix="<leader>"})


-- Jupyter bindings
whichkey.register ({
        j = {
                name = "Jupyter",
                s = {"<cmd> call jukit#convert#notebook_convert('jupyter_notebook')<cr>", "Start Jupyter"},
                c = {"<cmd> call jukit#convert#notebook_convert()<cr>", "Convert to ipynb"}, 
                o = {"<cmd> let jukit_terminal='kitty' | call jukit#splits#output_and_history()<cr>", "Create output split (kitty)"},
                O = {"<cmd> let jukit_terminal='nvimterm' | call jukit#splits#output_and_history()<cr>", "Create output split (nvimterm)"},
                q = {"<cmd> call jukit#splits#close_output_and_history(1)<cr>", "Quit output split"},
                q = {"<cmd> call jukit#splits#close_output_and_history(1)<cr>", "Quit output split"},
                r = {"<cmd> call jukit#send#section(0)<cr>", "Execute current cell"},
                a = {"<cmd> call jukit#send#all()<cr>", "Execute all cells"},
                l = {"<cmd> call jukit#splits#show_last_cell_output(1)<cr>", "Show last cell output"}
        }
}, {prefix="<leader>"})

-- Generic Vimscript Bindings
vim.api.nvim_exec(
[[
" BASE KEYBINDINGS
" -----------------------------
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

inoremap <C-j> <ESC><C-w><C-j>i
inoremap <C-k> <ESC><C-w><C-k>i
inoremap <C-l> <ESC><C-w><C-l>i
inoremap <C-h> <ESC><C-w><C-h>i

tnoremap <C-j> <C-\><C-n><C-w><C-j>
tnoremap <C-k> <C-\><C-n><C-w><C-k>
tnoremap <C-l> <C-\><C-n><C-w><C-l>
tnoremap <C-h> <C-\><C-n><C-w><C-h>

tnoremap <Esc> <C-\><C-n>
vnoremap > >gv
vnoremap < <gv

cmap Q q

" PLUGIN-SPECIFIC KEYBINDINGS
" -----------------------------

" coc keybindings
" allow tab to autocomplete
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" file tree keybindings
nnoremap <C-n> :NvimTreeToggle<CR>


" wilder keybindings
let s:wilder_started = 0
autocmd CmdlineLeave * let s:wilder_started = 0
function! s:start_wilder() abort
  let s:wilder_started = 1
  return wilder#next()
endfunction
function! s:in_context(check_started) abort
  if a:check_started && !s:wilder_started
    return 0
  endif
  return wilder#in_context()
endfunction
cnoremap <expr> <Tab> <SID>in_context(0) ? <SID>start_wilder() : '<Tab>'
cnoremap <expr> <Left> <SID>in_context(1) ? wilder#previous() : '<Left>'
cnoremap <expr> <Right> <SID>in_context(1) ? wilder#next() : '<Right>'


" telescope neoclip keybindings
nnoremap <C-p> :Telescope neoclip<CR>
inoremap <C-p> <esc>:Telescope neoclip<CR>

" jukit bindings
nnoremap <S-CR> :call jukit#send#section(1)<cr>
nnoremap <C-CR> :call jukit#send#section(0)<cr>
vnoremap <C-CR> :<C-U>call jukit#send#selection()<cr>

nnoremap <M-o> :call jukit#cells#create_below(0)<cr>
nnoremap <M-O> :call jukit#cells#create_above(0)<cr>
nnoremap <M-m> :call jukit#cells#create_below(1)<cr>
nnoremap <M-M> :call jukit#cells#create_above(1)<cr>
nnoremap <M-d> :call jukit#cells#delete()<cr>
nnoremap <M-K> :call jukit#cells#move_up()<cr>
nnoremap <M-J> :call jukit#cells#move_down()<cr>
nnoremap <M-j> :call jukit#cells#jump_to_next_cell()<cr>
nnoremap <M-k> :call jukit#cells#jump_to_previous_cell()<cr>
nnoremap <M-x> :call jukit#cells#delete_outputs(0)<cr>
nnoremap <M-X> :call jukit#cells#delete_outputs(1)<cr>

]],
true) 

