" General Settings

" if vscode
if exists('g:vscode')
  source $HOME/.config/nvim/vscode/settings.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

else
    " nvim settings
    source $HOME/.config/nvim/vim-plug/plugins.vim
    source $HOME/.config/nvim/general/settings.vim
    source $HOME/.config/nvim/general/functions.vim
    source $HOME/.config/nvim/general/temp.vim
    source $HOME/.config/nvim/keys/mappings.vim

    " Themes
    source $HOME/.config/nvim/plug-config/onedark.vim
    source $HOME/.config/nvim/plug-config/gruvboxmaterial.vim
    source $HOME/.config/nvim/plug-config/vim-airline.vim
    source $HOME/.config/nvim/plug-config/vim-highlightedyank.vim

    " Plugin Configuration
    source $HOME/.config/nvim/plug-config/coc.vim
    source $HOME/.config/nvim/plug-config/codi.vim
    source $HOME/.config/nvim/plug-config/easymotion.vim
    source $HOME/.config/nvim/plug-config/fzf.vim
    source $HOME/.config/nvim/plug-config/floaterm.vim
    source $HOME/.config/nvim/plug-config/gitgutter.vim
    source $HOME/.config/nvim/plug-config/goyo.vim
    source $HOME/.config/nvim/plug-config/closetags.vim
    source $HOME/.config/nvim/plug-config/quickscope.vim
    source $HOME/.config/nvim/plug-config/ranger.vim
    source $HOME/.config/nvim/plug-config/signify.vim
    source $HOME/.config/nvim/plug-config/undotree.vim
    source $HOME/.config/nvim/plug-config/syntastic.vim
    source $HOME/.config/nvim/plug-config/vim-commentary.vim
    source $HOME/.config/nvim/plug-config/vim-cmake.vim
    source $HOME/.config/nvim/plug-config/vim-lsp.vim
    source $HOME/.config/nvim/plug-config/vim-lsp-cxx-highlight.vim
    source $HOME/.config/nvim/plug-config/which-key.vim

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

