sudo dnf install -y \
	zsh \
	neovim \
	google-chrome 

# TODO: add gnome-tweaks 

cd

ln -s $(pwd)/projects/env/.config/nvim .config/nvim
