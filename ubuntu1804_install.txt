apt-get update
apt-get upgrade
apt-get install cmake gitlab-runner tmux software-properties-common nano make gcc g++ tcl golang php php7.2-gd php7.2-xml php7.2-dom php7.2-zip php7.2-fpm php7.2-mysql php7.2-pgsql php7.2-cli php7.2-json php7.2-common php7.2-mbstring php7.2-opcache php7.2-readline php7.2-curl certbot python-certbot-nginx redis composer python3-pip -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt-get update
sudo apt-get install python3.7 -y
apt-get purge apache2 -y
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main" > /etc/apt/sources.list.d/PostgreSQL.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update
apt-get install postgresql-11 -y


read -s -p "Postgres password: " PG_PASS
su - postgres -c "psql -U postgres -d postgres -c \"alter user postgres with password '$PG_PASS';\""

apt-get autoremove

service redis restart
service nginx restart
service php7.2-fpm restart
service postgresql restart
