echo "export DOT_FILE_DIR=$(pwd)" >.exports_dotfiles_dir
source .exports_dotfiles_dir

ln -s $DOT_FILE_DIR/.exports_dotfiles_dir $HOME
ln -s $DOT_FILE_DIR/.zshrc $HOME
ln -s $DOT_FILE_DIR/.vimrc $HOME
ln -s $DOT_FILE_DIR/.gvimrc $HOME
ln -s $DOT_FILE_DIR/.ideavimrc $HOME
ln -s $DOT_FILE_DIR/.tmux.conf $HOME
ln -s $DOT_FILE_DIR/.wgetrc $HOME
ln -s $DOT_FILE_DIR/.curlrc $HOME
ln -s $DOT_FILE_DIR/.gitconfig $HOME
ln -s $DOT_FILE_DIR/.gitignore_global $HOME
ln -s $DOT_FILE_DIR/.gdbinit $HOME

ln -s $DOT_FILE_DIR/.configurations $HOME
ln -s $DOT_FILE_DIR/.source $HOME
ln -s $DOT_FILE_DIR/.exports $HOME
ln -s $DOT_FILE_DIR/.settings $HOME
ln -s $DOT_FILE_DIR/.aliases $HOME
ln -s $DOT_FILE_DIR/.functions $HOME
ln -s $DOT_FILE_DIR/.chess $HOME
ln -s $DOT_FILE_DIR/.overrides $HOME
