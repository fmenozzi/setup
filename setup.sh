# Script for setting up new personalized Linux dev environment

# 0) Update
chmod +x update.sh
./update.sh
cp update.sh ~/update.sh

# 1) Basics
sudo apt-get update
sudo apt-get install wget curl vim build-essential htop guake tree valgrind ubuntu-restricted-extras cmake cmake-curses-gui

# 2) Compilers and runtimes
sudo apt-get install g++ clang clang++
sudo add-apt-repository ppa:openjdk-r/ppa -y
sudo apt-get update
sudo apt-get install openjdk-8-jdk
curl -sf -L https://static.rust-lang.org/rustup.sh | sh

# 3) Git
cp git-completion.bash ~/git-completion.bash
cp git-prompt.sh ~/git-prompt.sh
cp .gitignore_global ~/.gitignore_global
git config --global user.name "Federico Menozzi"
git config --global user.email "federicogmenozzi@gmail.com"
git config --global core.editor vim
git config --global core.excludesfile ~/.gitignore_global
git config --global alias.co "checkout"
git config --global alias.cm "commit"
git config --global alias.br "branch"
git config --global alias.unstash "stash pop"
git config --global alias.discard "checkout --"
git config --global alias.last "log -1 HEAD"
git config --global alias.unstage "reset HEAD --"

# 4) Python and related tools
sudo apt-get install python-pip python-dev -y
sudo pip install joe harvey thefuck howdoi

# 5) Flat icon theme
sudo add-apt-repository ppa:tualatrix/ppa -y
sudo add-apt-repository ppa:noobslab/icons -y
sudo apt-get update
sudo apt-get install ubuntu-tweak ultra-flat-icons unity-tweak-tool
mkdir -p ~/.themes

# 6) Bash and vim
cp .bashrc ~/.bashrc
cp .vimrc ~/.vimrc
cp -r .vim ~/.vim

# 7) Miscellaneous
git clone https://github.com/jarun/google-cli/
cd google-cli
sudo make install
cd ..
rm -rf google-cli

git clone git://github.com/rupa/z
mv z/z.sh ~
rm -rf z
