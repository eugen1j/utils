cd ~

apt-get install tmux zsh powerline fonts-powerline -y

wget https://github.com/Peltoche/lsd/releases/download/0.14.0/lsd_0.14.0_amd64.deb
dpkg -i lsd_0.14.0_amd64.deb
rm lsd_0.14.0_amd64.deb

chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --unattended 
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

tmux new-session -t testing -d
tmux show -g | sed 's/^/set -g /' > ~/.tmux.conf
sed -i 's/set -g default-shell "\/bin\/bash"/set -g default-shell "\/bin\/zsh"/g' .tmux.conf
sed -i 's/set -g mouse off/set -g mouse on/g' .tmux.conf
tmux source-file .tmux.conf


wget https://github.com/sharkdp/bat/releases/download/v0.10.0/bat_0.10.0_amd64.deb
dpkg -i bat_0.10.0_amd64.deb
rm bat_0.10.0_amd64.deb

git clone --depth 1 https://github.com/junegunn/fzf.git .fzf
.fzf/install --all

wget https://raw.githubusercontent.com/eugen1j/utils/master/.zshrc -O .zshrc

zsh
