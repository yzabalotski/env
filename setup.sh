sudo dnf install -y \
	zsh \
	neovim \
	google-chrome \
    kubernetes-client \
    libtool \
    openssl-devel

# TODO: add gnome-tweaks 

cd

ln -s $(pwd)/projects/env/.config/nvim .config/nvim

git config --global core.editor nvim

mkdir work
