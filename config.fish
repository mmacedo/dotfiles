# Oh My Fish!
set fish_path ~/.oh-my-fish
set fish_theme my
set fish_plugins rbenv rake bundler node
. $fish_path/oh-my-fish.fish

# pyenv
set PATH ~/.pyenv/bin $PATH
set PATH ~/.pyenv/shims $PATH

# pyenv shell
. ~/.config/fish/pyenv.fish

# rbenv shell
. ~/.config/fish/rbenv.fish

# source
. ~/.config/fish/source.fish

# nvm
source --bash ~/.nvm/nvm.sh

# Custom aliases and functions
. ~/.config/fish/functions.fish
