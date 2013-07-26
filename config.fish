# Oh My Fish!
set fish_path $HOME/.oh-my-fish
set fish_theme numist
set fish_plugins rbenv rake bundler node
. $fish_path/oh-my-fish.fish

. $HOME/.config/fish/source.fish
source --bash $HOME/.nvm/nvm.sh

. $HOME/.config/fish/functions.fish
