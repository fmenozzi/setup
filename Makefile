all: update basics tools langs git bash vim setup-custom-git-commands misc

update:
	@sudo add-apt-repository ppa:openjdk-r/ppa -y
	@sudo add-apt-repository ppa:noobslab/icons -y
	@chmod +x update.sh
	@./update.sh
	@cp update.sh ~/update.sh

basics: update
	@sudo apt-get install wget curl vim tmux htop guake tree ubuntu-restricted-extras vlc bash-completion -y

langs: basics
	@sudo apt-get install g++ clang golang npm ghc -y
	@sudo apt-get install openjdk-8-jdk -y
	@sudo apt-get install python-pip python-dev python3-pip python3-dev -y
	@curl https://sh.rustup.rs -sSf | sh
	@source ~/.cargo/env

tools: langs
	@sudo apt-get install cmake cmake-curses-gui ninja-build valgrind build-essential clang-tidy clang-format -y
	@sudo pip install joe harvey thefuck howdoi
	@sudo pip3 install todocli

git: langs
	@sudo npm install -g diff-so-fancy
	@cp git-completion.bash ~/git-completion.bash
	@cp git-prompt.sh ~/git-prompt.sh
	@cp .gitignore_global ~/.gitignore_global
	@git config --global user.name "Federico Menozzi"
	@git config --global user.email "federicogmenozzi@gmail.com"
	@git config --global core.editor vim
	@git config --global core.excludesfile ~/.gitignore_global
	@git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	@git config --global push.default simple
	@git config --global alias.co "checkout"
	@git config --global alias.cm "commit"
	@git config --global alias.br "branch"
	@git config --global alias.unstash "stash pop"
	@git config --global alias.stashes "stash list"
	@git config --global alias.discard "checkout --"
	@git config --global alias.last "log -1 HEAD"
	@git config --global alias.unstage "reset HEAD --"
	@git config --global alias.supdate "submodule update --remote --merge"
	@git config --global alias.spush "push --recursive-submodules=on-demand"

bash:
	@cp .bashrc ~

vim: tools langs
	@rm -rf ~/.vim
	@mkdir -p ~/.vim/bundle
	@git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
	@cp .vimrc ~
	@cp .ideavimrc ~
	@cp .inputrc ~
	@vim +PluginInstall +qall
	@cd ~/.vim/bundle/YouCompleteMe && ./install.py --gocode-completer --racer-completer

theme:
	@sudo apt-get install ultra-flat-icons unity-tweak-tool -y
	@mkdir -p ~/.themes

graphics:
	@sudo apt-get install libxrandr-dev libxinerama-dev libxcursor-dev mesa-utils -y

google-cli:
	@git clone https://github.com/jarun/google-cli/
	@cd google-cli && sudo $(MAKE) install
	@cd ..
	@rm -rf google-cli

z:
	@git clone git://github.com/rupa/z
	@mv z/z.sh ~
	@rm -rf z

misc: theme graphics google-cli z

copy-dotfiles:
	@cp .vimrc ~/.vimrc
	@cp .bashrc ~/.bashrc
	@cp .tmux.conf ~/.tmux.conf
	@cp .ghci ~/.ghci
	@chmod go-w ~/.ghci

setup-custom-git-commands: bash
	@mkdir -p ~/.custom-git-commands/
	@rm -rf ~/.custom-git-commands/*
	@cp gitutils.py ~/.custom-git-commands
	@cp git-map-branches ~/.custom-git-commands
	@cp git-new-feature-branch ~/.custom-git-commands
	@cp git-upmerge ~/.custom-git-commands
