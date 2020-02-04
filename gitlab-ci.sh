
chsh -s /bin/zsh gitlab-runner
usermod -a -G sudo gitlab-runner
usermod -a -G www-data gitlab-runner
usermod -a -G gitlab-runner www-data
cp -rp .zshrc /var/lib/gitlab-runner
cp -rp .oh-my-zsh /var/lib/gitlab-runner
chown -R  gitlab-runner:gitlab-runner /var/lib/gitlab-runner/.oh-my-zsh/ /var/lib/gitlab-runner/.zshrc

su - gitlab-runner
mkdir .ssh
cd .ssh
ssh-keygen -b 8192
cat ~/.ssh/id_rsa.pub
