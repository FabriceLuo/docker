# Install
```
apt install libanyevent-perl libclass-refresh-perl libcompiler-lexer-perl libdata-dump-perl libio-aio-perl libjson-perl libmoose-perl libpadwalker-perl libscalar-list-utils-perl libcoro-perl
```

```
cpanm Perl::LanguageServer
```

# test
```
perl -MPerl::LanguageServer -e Perl::LanguageServer::run -- --port 13603 --nostdio 0 --version 2.1.0
```

# config in vim
config in ycm according to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#perlls
```
let g:ycm_language_server =
  \ [
  \   {
  \     'name': 'perlls',
  \     'cmdline': ['perl', '-MPerl::LanguageServer', '-e', 'Perl::LanguageServer::run'],
  \     'filetypes': [ 'perl' ],
  \   }
  \ ]
```
