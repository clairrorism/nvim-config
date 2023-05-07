local o = vim.opt

vim.g.mapleader = " "

o.compatible = false
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.autoindent = true
o.smartindent = true
o.number = true
o.relativenumber = true
o.hidden = true
o.swapfile = false
o.cursorline = true
o.cursorcolumn = true
o.backup = false
o.wrap = false
o.incsearch = true
o.hlsearch = true
o.ignorecase = true
o.smartcase = true
o.cmdheight = 0
o.showmatch = true
o.background = "dark"
o.clipboard = "unnamedplus"
o.title = false
o.mouse = "a"
o.termguicolors = true
o.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"
o.wildmenu = true
o.list = true
o.listchars:append "eol:↴"
o.listchars:append "space:⋅"
