sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove
sudo apt-get clean
	
vim +PluginUpdate +qall

mkdir -p ~/.vim/bundle
cd ~/.vim/bundle
for i in `ls`; do
    cd "$i"
    git pull
    cd ..
done
