" Jump to the last known cursor position
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" Key mappings
map <F9> :set paste<CR>i
map <F10> :set nopaste<CR>
" :W sudo saves the file (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null
" Main settings
filetype detect
filetype plugin indent on
syntax on                       " syntax highlighting according to 'filetype'
set enc=utf-8                   " set utf-8 encoding inside Vim
set fenc=utf-8                  " set utf-8 encoding for the file of this buffer
set termencoding=utf-8          " set utf-8 encoding for the terminal
set tabstop=4                   " tab = 4 spaces
set shiftwidth=4                " tab = 4 spaces
set softtabstop=4               " tab = 4 spaces
set expandtab                   " replace tabs with spaces
set smarttab                    " <Tab> in front of a line inserts 'shiftwidth' blanks
set smartindent                 " do smart autoindenting when starting a new line
set autoindent                  " copy indent from current line when starting a new line
set autoread                    " Set to auto read when a file is changed from the outside
" set mouse=a                     " enable mouse
set wildmenu                    " Turn on the Wild menu, but ignore the following patterns:
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.swp,*.jpg,*.gif,*.png
set nopaste                     " set nopaste mode on INSERT
set showcmd                     " show incomplete cmds down the bottom
set showmode                    " show current mode down the bottom
set autochdir                   " make working directory same as open file
set history=1000                " lots of command line history
set hlsearch                    " hilight searches by default
set linebreak                   " wrap lines at convenient points
set nobackup                    " do not keep backups after close
set writebackup                 " do keep a backup while working
set backupdir=~/.vim/backup     " set backup directory
set noswapfile                  " do not create swap file
set noeb                        " no error bell
set nowb                        " no warning bell
set vb                          " set visual bell
set t_vb=                       " but don't do visual bell LOL
set colorcolumn=200             " make column n-th coloured
set list                        " show tabs as CTRL-I is displayed, display $ after end of line.
set lcs=tab:\ \ ,trail:·        " set listchrs for tb and space
set gcr=a:blinkon0              " no cursor blinking in all modes
set hidden                      " hide buffer
set switchbuf+=usetab,newtab    " set behavior when switching between buffers
set foldmethod=indent           " create fold of lines with the same indent
set foldnestmax=3               " depth of fold
set nofoldenable                " all folds open
set scrolloff=8                 " keep n lines visible when scrolling
set synmaxcol=1024              " Syntax coloring lines that are too long just slows down the world
set incsearch                   " search as you type
set ignorecase                  " ignore case when searching
set smartcase                   " but if you use UPPERCASE it will look for upercase chars
" Status line
set statusline=%F               " full path
set statusline+=%m              " file modified flag
set statusline+=%r              " readonly flag
set statusline+=%h              " help buffer flag
set statusline+=%w              " preview window flag
set statusline+=\ %-3(%{FileSize()}%) " file size
set statusline+=\ FORMAT=%{&ff} " file format
set statusline+=\ TYPE=%Y       " file type
set statusline+=\ ASCII=\%03.3b " current char ascii code
set statusline+=\ HEX=\%02.2B   " current char hex code
set statusline+=\ POS=%l,%v     " cursor position [line,char]
set statusline+=\ %p%%          " percentage through file
set statusline+=\ LEN=%L        " number of lines in buffer
hi statusline ctermfg=8         " 
hi statusline ctermbg=15        " 
hi statusline guifg=LightGrey   " 
hi statusline guibg=Green       " 
set laststatus=2                " always display statusline
" Calculate file size
function! FileSize()
  let bytes = getfsize(expand('%:p'))
  if (bytes >= 1024)
    let kbytes = bytes / 1024
  endif
  if (exists('kbytes') && kbytes >= 1024)
    let mbytes = kbytes / 1024
  endif
  if bytes <= 0
    return '0'
  endif
  if (exists('mbytes'))
    return mbytes . 'MB '
  elseif (exists('kbytes'))
    return kbytes . 'KB '
  else
    return bytes . 'B '
  endif
endfunction
"==============================================================================
" COLOUR SCHEME
"==============================================================================
" Vim color file - dark_eyes
set background=dark
if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name = "dark_eyes"
if !has("gui_running") && &t_Co != 88 && &t_Co != 256
    finish
endif
" functions {{{
" returns an approximate grey index for the given grey level
fun <SID>grey_number(x)
    if &t_Co == 88
        if a:x < 23
            return 0
        elseif a:x < 69
            return 1
        elseif a:x < 103
            return 2
        elseif a:x < 127
            return 3
        elseif a:x < 150
            return 4
        elseif a:x < 173
            return 5
        elseif a:x < 196
            return 6
        elseif a:x < 219
            return 7
        elseif a:x < 243
            return 8
        else
            return 9
        endif
    else
        if a:x < 14
            return 0
        else
            let l:n = (a:x - 8) / 10
            let l:m = (a:x - 8) % 10
            if l:m < 5
                return l:n
            else
                return l:n + 1
            endif
        endif
    endif
endfun
" returns the actual grey level represented by the grey index
fun <SID>grey_level(n)
    if &t_Co == 88
        if a:n == 0
            return 0
        elseif a:n == 1
            return 46
        elseif a:n == 2
            return 92
        elseif a:n == 3
            return 115
        elseif a:n == 4
            return 139
        elseif a:n == 5
            return 162
        elseif a:n == 6
            return 185
        elseif a:n == 7
            return 208
        elseif a:n == 8
            return 231
        else
            return 255
        endif
    else
        if a:n == 0
            return 0
        else
            return 8 + (a:n * 10)
        endif
    endif
endfun
" returns the palette index for the given grey index
fun <SID>grey_color(n)
    if &t_Co == 88
        if a:n == 0
            return 16
        elseif a:n == 9
            return 79
        else
            return 79 + a:n
        endif
    else
        if a:n == 0
            return 16
        elseif a:n == 25
            return 231
        else
            return 231 + a:n
        endif
    endif
endfun
" returns an approximate color index for the given color level
fun <SID>rgb_number(x)
    if &t_Co == 88
        if a:x < 69
            return 0
        elseif a:x < 172
            return 1
        elseif a:x < 230
            return 2
        else
            return 3
        endif
    else
        if a:x < 75
            return 0
        else
            let l:n = (a:x - 55) / 40
            let l:m = (a:x - 55) % 40
            if l:m < 20
                return l:n
            else
                return l:n + 1
            endif
        endif
    endif
endfun
" returns the actual color level for the given color index
fun <SID>rgb_level(n)
    if &t_Co == 88
        if a:n == 0
            return 0
        elseif a:n == 1
            return 139
        elseif a:n == 2
            return 205
        else
            return 255
        endif
    else
        if a:n == 0
            return 0
        else
            return 55 + (a:n * 40)
        endif
    endif
endfun
" returns the palette index for the given R/G/B color indices
fun <SID>rgb_color(x, y, z)
    if &t_Co == 88
        return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
        return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
endfun
" returns the palette index to approximate the given R/G/B color levels
fun <SID>color(r, g, b)
    " get the closest grey
    let l:gx = <SID>grey_number(a:r)
    let l:gy = <SID>grey_number(a:g)
    let l:gz = <SID>grey_number(a:b)
    " get the closest color
    let l:x = <SID>rgb_number(a:r)
    let l:y = <SID>rgb_number(a:g)
    let l:z = <SID>rgb_number(a:b)
    if l:gx == l:gy && l:gy == l:gz
        " there are two possibilities
        let l:dgr = <SID>grey_level(l:gx) - a:r
        let l:dgg = <SID>grey_level(l:gy) - a:g
        let l:dgb = <SID>grey_level(l:gz) - a:b
        let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
        let l:dr = <SID>rgb_level(l:gx) - a:r
        let l:dg = <SID>rgb_level(l:gy) - a:g
        let l:db = <SID>rgb_level(l:gz) - a:b
        let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
        if l:dgrey < l:drgb
            " use the grey
            return <SID>grey_color(l:gx)
        else
            " use the color
            return <SID>rgb_color(l:x, l:y, l:z)
        endif
    else
        " only one possibility
        return <SID>rgb_color(l:x, l:y, l:z)
    endif
endfun
" returns the palette index to approximate the 'rrggbb' hex string
fun <SID>rgb(rgb)
    let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
    let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
    let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0
    return <SID>color(l:r, l:g, l:b)
endfun
" sets the highlighting for the given group
fun <SID>X(group, fg, bg, attr)
    if a:fg != ""
        exec "hi ".a:group." guifg=#".a:fg." ctermfg=".<SID>rgb(a:fg)
    endif
    if a:bg != ""
        exec "hi ".a:group." guibg=#".a:bg." guisp=#".a:bg." ctermbg=".<SID>rgb(a:bg)
    endif
    if a:attr != ""
        if a:attr == 'italic'
            exec "hi ".a:group." gui=".a:attr." cterm=none"
        else
            exec "hi ".a:group." gui=".a:attr." cterm=".a:attr
        endif
    endif
endfun
" }}}
" ********************************************************************************
" The following are the preferred 16 colors for your terminal
"           Colors      Bright Colors
" Black     #4E4E4E     #7C7C7C
" Red       #FF6C60     #FFB6B0
" Green     #A8FF60     #CEFFAB
" Yellow    #FFFFB6     #FFFFCB
" Blue      #96CBFE     #FFFFCB
" Magenta   #FF73FD     #FF9CFE
" Cyan      #C6C5FE     #DFDFFE
" White     #EEEEEE     #FFFFFF
" ********************************************************************************
" General colors
" CurentWindow
hi Normal guifg=#a6a3a3 guibg=NONE guisp=#080404 gui=NONE ctermfg=248 ctermbg=232 cterm=NONE
hi Cursor guifg=#64de85 guibg=#bdb857 guisp=#bdb857 gui=bold ctermfg=78 ctermbg=143 cterm=bold
if version >= 700 " Vim 7.x specific colors
  call <SID>X("CursorLine","f4f0f0","201c1c","none")
  call <SID>X("CursorColumn","f4f0f0","201c1c","none")
  call <SID>X("MatchParen","ffffff","904030","none")
  call <SID>X("Search","000000","f0f000","italic")
endif
call <SID>X("IncSearch","EEEEEE","FF6C60","none")
call <SID>X("LineNr","848070","181414","none")
hi Visual gui=NONE guifg=DarkGray guibg=White cterm=NONE ctermfg=DarkGray ctermbg=White
" Invisible Characters
hi NonText guifg=#9e6e6e guibg=#181414 guisp=#181414 gui=NONE ctermfg=95 ctermbg=234 cterm=NONE
call <SID>X("SpecialKey","b4b0b0","282424","bold")
" Folds
hi Folded guifg=#484040 guibg=NONE guisp=#080404 gui=italic ctermfg=238 ctermbg=232 cterm=NONE
call <SID>X("VertSplit","200800","301810","none")
call <SID>X("StatusLine","f8e0d0","301810","bold")
call <SID>X("StatusLineNC","503830","200800","none")
hi Ignore guifg=#79a1b5 guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE
" Message displayed in lower left, such as --INSERT--
hi ModeMsg guifg=#a6a3a3 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
" Syntax highlighting of actual code
call <SID>X("Special","a06050","181414","italic")
call <SID>X("Operator","705850","080404","italic")
" directory names and other special names in listings
call <SID>X("Directory","e2e4e5","","none")
" Popup Menu
call <SID>X("PMenu","503830","200800","none")
call <SID>X("PMenuSel","f8e0d0","301810","none")
call <SID>X("PMenuSbar","503830","181414","none")
call <SID>X("PMenuThumb","503830","848070","none")
hi Comment guifg=#9e856b guibg=NONE guisp=#080404 gui=italic ctermfg=137 ctermbg=232 cterm=NONE
hi Todo guifg=#686460 guibg=NONE guisp=#080404 gui=italic ctermfg=242 ctermbg=232 cterm=NONE
call <SID>X("Constant","60d060","080404","none")
call <SID>X("Define","607080","080404","italic")
call <SID>X("Macro","a090a0","080404","italic")
hi Delimiter guifg=#a06050 guibg=#181414 guisp=#181414 gui=italic ctermfg=131 ctermbg=234 cterm=NONE
hi Error guifg=#e2e4e5 guibg=#854d50 guisp=#854d50 gui=NONE ctermfg=254 ctermbg=95 cterm=NONE
hi ErrorMsg guifg=#a6a3a3 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
call <SID>X("WarningMsg","e2e4e5","","none")
call <SID>X("Function","60b050","080404","italic")
call <SID>X("Identifier","c0b060","080404","italic")
call <SID>X("Include","a090a0","080404","italic")
call <SID>X("Keyword","705850","080404","italic")
call <SID>X("Number","60d060","080404","none")
call <SID>X("PreCondit","a090a0","080404","italic")
hi PreProc guifg=#a090a0 guibg=#5e2b2b guisp=#5e2b2b gui=italic ctermfg=247 ctermbg=52 cterm=NONE
call <SID>X("Statement","506090","080404","NONE")
call <SID>X("String","a06050","080404","italic")
call <SID>X("Title","ffffff","202020","none")
call <SID>X("Type","705850","080404","italic")
" Dependent highlighting rules. Mostly irrelevant crap from 1972.
call <SID>X("Character","60d060","080404","none")
call <SID>X("Boolean","506090","080404","none")
call <SID>X("Float","60d060","080404","none")
call <SID>X("Repeat","906050","080404","none")
call <SID>X("Label","705850","080404","italic")
call <SID>X("Exception","903020","080404","none")
call <SID>X("Conditional","609050","080404","none")
call <SID>X("StorageClass","705850","080404","italic")
call <SID>X("Structure","705850","080404","italic")
call <SID>X("Typedef","705850","080404","italic")
call <SID>X("Tag","a06050","181414","italic")
call <SID>X("SpecialChar","a06050","181414","italic")
call <SID>X("SpecialComment","a06050","181414","italic")
call <SID>X("Debug","a06050","181414","italic")
" extras
hi DiffAdd guifg=#4b8060 guibg=NONE guisp=NONE gui=NONE ctermfg=65 ctermbg=NONE cterm=NONE
hi DiffDelete guifg=#853939 guibg=NONE guisp=NONE gui=NONE ctermfg=95 ctermbg=NONE cterm=NONE
hi DiffChange guifg=#a1a83e guibg=NONE guisp=NONE gui=NONE ctermfg=143 ctermbg=NONE cterm=NONE
hi DiffText guifg=#7db0ad guibg=NONE guisp=#080404 gui=NONE ctermfg=109 ctermbg=232 cterm=NONE
hi CTagsMember guifg=#e2e4e5 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi CTagsGlobalConstant guifg=#e2e4e5 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi CTagsImport guifg=#6c9fb8 guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi CTagsGlobalVariable guifg=#e2e4e5 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi CTagsClass guifg=#5e7f8f guibg=NONE guisp=NONE gui=NONE ctermfg=66 ctermbg=NONE cterm=NONE
call <SID>X("SpellRare","e2e4e5","","none")
call <SID>X("SpellCap","e2e4e5","","none")
call <SID>X("SpellLocal","e2e4e5","","none")
call <SID>X("SpellBad","e2e4e5","","none")
call <SID>X("MoreMsg","e2e4e5","","none")
call <SID>X("WildMenu","e2e4e5","","none")
call <SID>X("SignColumn","e2e4e5","","none")
hi FoldColumn guifg=#75909e guibg=NONE guisp=NONE gui=NONE ctermfg=109 ctermbg=NONE cterm=NONE
call <SID>X("EnumerationValue","e2e4e5","","none")
hi EnumerationName guifg=#e2e4e5 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
call <SID>X("TabLineSel","e2e4e5","","none")
call <SID>X("TabLineFill","e2e4e5","","none")
call <SID>X("TabLine","e2e4e5","","none")
call <SID>X("Underlined","b4b0b0","080404","none")
call <SID>X("Union","e2e4e5","","none")
hi Question guifg=#a6a3a3 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
call <SID>X("VisualNOS","e2e4e5","","none")
call <SID>X("DefinedName","e2e4e5","","none")
hi pythonbuiltin guifg=#a6a3a3 guibg=NONE guisp=NONE gui=NONE ctermfg=248 ctermbg=NONE cterm=NONE
call <SID>X("phpStringDouble","e2e4e5","","none")
hi htmltagname guifg=#c28787 guibg=NONE guisp=NONE gui=NONE ctermfg=138 ctermbg=NONE cterm=NONE
hi javascriptstrings guifg=#e2e4e5 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
hi htmlstring guifg=#856d6d guibg=NONE guisp=NONE gui=NONE ctermfg=95 ctermbg=NONE cterm=NONE
hi phpstringsingle guifg=#e2e4e5 guibg=NONE guisp=NONE gui=NONE ctermfg=254 ctermbg=NONE cterm=NONE
" delete functions {{{
delf <SID>X
delf <SID>rgb
delf <SID>color
delf <SID>rgb_color
delf <SID>rgb_level
delf <SID>rgb_number
delf <SID>grey_color
delf <SID>grey_level
delf <SID>grey_number
" }}}

