let s:base = fnamemodify(expand('<sfile>'), ':h')

call dein#load_toml(s:base.'/lsp.toml', {'lazy': 1})
call dein#load_toml(s:base.'/treesitter.toml', {'lazy': 1})
call dein#load_toml(s:base.'/finder.toml', {'lazy': 1})
call dein#load_toml(s:base.'/eager.toml', {'lazy': 0})
call dein#load_toml(s:base.'/status.toml', {'lazy': 0})
call dein#load_toml(s:base.'/theme.toml', {'lazy': 0})
