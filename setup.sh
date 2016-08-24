# Script for setting up new personalized Linux dev environment

# 0) Update
sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo add-apt-repository ppa:noobslab/icons -y
chmod +x update.sh
./update.sh
cp update.sh ~/update.sh

# 1) Basics
sudo apt-get install wget curl vim htop guake tree ubuntu-restricted-extras vlc

# 2) Build systems and tools
sudo apt-get install cmake cmake-curses-gui ninja-build valgrind build-essential

# 2) Compilers and runtimes
sudo apt-get install g++ clang golang npm
sudo apt-get install openjdk-8-jdk
sudo apt-get install python-pip python-dev python3-pip python3-dev -y
curl -sf -L https://static.rust-lang.org/rustup.sh | sh

# 3) Git
sudo npm install -g diff-so-fancy
cp git-completion.bash ~/git-completion.bash
cp git-prompt.sh ~/git-prompt.sh
cp .gitignore_global ~/.gitignore_global
git config --global user.name "Federico Menozzi"
git config --global user.email "federicogmenozzi@gmail.com"
git config --global core.editor vim
git config --global core.excludesfile ~/.gitignore_global
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global push.default simple
git config --global alias.co "checkout"
git config --global alias.cm "commit"
git config --global alias.br "branch"
git config --global alias.unstash "stash pop"
git config --global alias.discard "checkout --"
git config --global alias.last "log -1 HEAD"
git config --global alias.unstage "reset HEAD --"
git config --global alias.supdate "submodule update --remote --merge"
git config --global alias.spush "push --recursive-submodules=on-demand"

# 4) Python tools
sudo pip install joe harvey thefuck howdoi
sudo pip3 install todocli

# 5) Flat icon theme
sudo apt-get install ubuntu-tweak ultra-flat-icons unity-tweak-tool
mkdir -p ~/.themes

# 6) Bash and vim
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
cp .vimrc ~
cp .bashrc ~

# 7) Graphics
sudo apt-get install libxrandr-dev libxinerama-dev libxcursor-dev mesa-utils

# 8) Miscellaneous
git clone https://github.com/jarun/google-cli/
cd google-cli
sudo make install
cd ..
rm -rf google-cli

git clone git://github.com/rupa/z
mv z/z.sh ~
rm -rf z
