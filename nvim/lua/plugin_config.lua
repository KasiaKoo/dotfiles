-- Plugin configurations
require('nvim-web-devicons').setup{default=true;}

require('lualine').setup{
        tabline={
                lualine_a = {{
                        'tabs',
                        mode = 1
                }},
        }
}

require('nvim-autopairs').setup{}

vim.g['tex_flavor'] = 'latex'
vim.g['vimtex_viewer_method'] = 'skim'

--[[ for sync in skim, follow instructions here:
https://dr563105.github.io/blog/skim-vimtex-setup/
in skim, preset custom, and arguments (with double hyphen):
--headless -c "VimtexInverseSearch %line '%file'" ]]
vim.g['vimtex_view_skim_sync'] = 1
vim.g['vimtex_view_skim_activate'] = 1

require("toggleterm").setup{open_mapping = [[<C-t>]]}

require("ibl").setup{}

require'nvim-treesitter.configs'.setup{
        ensure_installed={"python", "latex", "lua"},
        sync_install = true,
        highlight = {enable=true, additional_vim_regex_highlighting=true}}

vim.g['coc_config_home'] = '~/.config/nvim/'
vim.g['coc_filetype_map'] = '{"tex": "latex"}'
vim.api.nvim_exec(
[[
set completeopt-=noselect
]],
true)

require('nvim-tree').setup{
        open_on_tab = true,
        update_cwd = true,
        update_focused_file = {
                enable      = true, 
                update_cwd  = true,
                ignore_list = {}
          }
}

require('neogit').setup{}

vim.api.nvim_exec(
[[
call wilder#setup({
      \ 'modes': [':'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ })
call wilder#set_option('use_python_remote_plugin', 0)
call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'fuzzy_filter': wilder#lua_fzy_filter(),
      \     }),
      \     wilder#vim_search_pipeline(),
      \   ),
      \ ])
]],
true)

require('which-key').setup{
        window = {border = 'single'},
        layout = {align = 'center',
                  height = {min = 2, max = 25}}}

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    preview = false,
    path_display = {"smart"},
    color_devicons = true,
    layout_config = {
            width = 0.4,
            height = 0.4
    },
    mappings = {
      i = {
        ["<esc>"] = "close",
        ["<C-[>"] = "close",
        ["<C-c>"] = "close",
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<C-t>"] = "select_tab",
        ["<C-h>"] = "select_horizontal",
        ["<C-v>"] = "select_vertical",
        ["<tab>"] = "select_default"
      }
    },
  },
  extensions = {
  }
}

require('telescope').load_extension('fzy_native')

require("telescope").load_extension("file_browser")

require("neoclip").setup({
      preview = false,
      default_register = {'"', '+', '*'},
      keys = {
        telescope = {
          i = {
            ["<esc>"] = "close",
            ["<C-[>"] = "close",
            ["<C-c>"] = "close",
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            paste = '<cr>',
            paste_behind = '<c-p>',
            delete = '<c-d>',
            select = '<c-y>'
          },
        },
      }})

require("telescope").load_extension("neoclip")


vim.g['jukit_mappings'] = 0
vim.api.nvim_exec(
[[
let g:jukit_atuo_output_hist = 0
let g:jukit_layout = {
    \'split': 'horizontal',
    \'p1': 0.7, 
    \'val': [
        \'file_content',
        \{
            \'split': 'vertical',
            \'p1': 0.7,
            \'val': ['output', 'output_history']
        \}
    \]
\}
]],
true)
vim.g['jukit_auto_output_hist'] = 0
vim.g['jukit_output_new_os_window'] = 0
vim.g['jukit_inline_plotting'] = 1
vim.g['jukit_terminal'] = 'kitty'


