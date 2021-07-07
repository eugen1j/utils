apt-get update
apt-get install -y docker.io docker-compose
curl -s https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
apt-get install -y gitlab-runner
mkdir /var/lib/gitlab-runner
chown -R gitlab-runner:gitlab-runner /var/lib/gitlab-runner
usermod -aG docker gitlab-runner
service docker restart
