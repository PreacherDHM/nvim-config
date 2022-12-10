lua require('keybind')
"lua require('plugins')

call plug#begin()

Plug 'f-person/git-blame.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'luisiacc/gruvbox-baby'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'preservim/nerdtree'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'akinsho/toggleterm.nvim'
Plug 'neovim/nvim-lspconfig' 
Plug 'williamboman/nvim-lsp-installer'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'L3MON4D3/LuaSnip'
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/nvim-cmp'

Plug 'voldikss/vim-floaterm'

Plug 'ellisonleao/gruvbox.nvim'
Plug 'shaunsingh/nord.nvim'

Plug 'mfussenegger/nvim-jdtls'

"Telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'BurntSushi/ripgrep'
Plug 'nvim-telescope/telescope-file-browser.nvim'

"vim-pact
Plug 'wsdjeg/vim-pact'

"Icons
Plug 'kyazdani42/nvim-web-devicons'

"status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

" - /home/preacher/.local/share/nvim/plugged/LuaSnip/
" - /home/preacher/.local/share/nvim/plugged/Nvim-R/
" - /home/preacher/.local/share/nvim/plugged/cmp-buffer/
" - /home/preacher/.local/share/nvim/plugged/cmp-cmdline/
" - /home/preacher/.local/share/nvim/plugged/cmp-nvim-lsp/
" - /home/preacher/.local/share/nvim/plugged/cmp-path/
" - /home/preacher/.local/share/nvim/plugged/cmp_luasnip/
" - /home/preacher/.local/share/nvim/plugged/coc.nvim/
" - /home/preacher/.local/share/nvim/plugged/gruvbox.nvim/
" - /home/preacher/.local/share/nvim/plugged/nord.nvim/
" - /home/preacher/.local/share/nvim/plugged/nvim-cmp/
" - /home/preacher/.local/share/nvim/plugged/nvim-jdtls/
" - /home/preacher/.local/share/nvim/plugged/nvim-lsp-installer/
" - /home/preacher/.local/share/nvim/plugged/vim-floaterm/
" - /home/preacher/.local/share/nvim/plugged/yaml.nvim/

lua require('telescope_config')
lua require('newconfig')
lua require('nvim_lsp')
lua require('snips')
lua require('keybind')
lua require('check_list')
lua require('notes')

"let g:airline_theme='base16_gruvbox_dark_hard'
let g:nord_contrast = v:true
let g:nord_borders = v:true
let g:nord_disable_background = v:false
let g:nord_italic = v:false

set background=dark
" Load the colorscheme
"colorscheme gruvbox
colorscheme gruvbox 

"set exrc
set guicursor=
set tabstop=4 softtabstop=4
set shiftwidth=4
"set expandtab
set smartindent
set nohlsearch
set hidden
set nowrap
set incsearch
set scrolloff=10
set colorcolumn=80
set signcolumn=yes
set number
set splitright
syntax on

let mapleader = " "
let ruby_spellcheck_strings = 1
let highlight_sedtabs = 1

tnoremap <Esc> <C-\><C-n>:bd!<CR>

nnoremap <leader>fsg <cmd>:lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fgg <cmd>lua require('telescope.builtin').live_grep({grep_open_files=true})<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fgc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>fgb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>fgj <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>hc <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>fnt <cmd>lua require('telescope').extensions.file_browser.file_browser({cwd='~/Documents/Notes'})<cr>

"build gradlew
autocmd FileType python nnoremap <leader>bb :vsplit<CR> :terminal python3 main.py<CR> <cmd>:startinsert<CR>

autocmd FileType java nnoremap <leader>bb :vsplit<CR> :terminal ./gradlew build<CR> <cmd>:startinsert<CR>

autocmd FileType java nnoremap <leader>bd :vsplit<CR> :terminal ./gradlew deploy<CR> <cmd>:startinsert<CR>


"build cmake
autocmd FileType cpp nnoremap <leader>bb :vsplit<CR> :ter make<CR> <cmd>:startinsert<CR>


let g:floaterm_keymap_new = '<Leader>ft'
let g:floaterm_keymap_toggle = '<Leader>t'
 "Button Bindings
nnoremap <leader>ntf :NERDTreeFocus<CR>
nnoremap <leader>ntt :NERDTreeToggle<CR>

 "toggleterm Bindings
 "Not working right now

"Gitblame
"let g:gitblame_enabled = 0
"let g:gitblame_message_template = '<date> . <author>'
"let g:gitblame_display_vertual_text = 0

nnoremap <leader>gb :GitBlameToggle<CR>

set statusline+=%{get(b:,'gitsigns_status','')}
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set relativenumber

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

