Установка uwsgi

1. Установка бинарника

```
apt-get install python3-dev
python3.7 -m pip install uwsgi
```

Бинарник будет установлен в `/usr/local/bin/uwsgi`

2. Создание демона uwgsi

2.1. Конфиг emperor.ini
```
cd /etc
mkdir uwsgi
cd uwsgi
mkdir vassals

echo "[uwsgi]
emperor = /etc/uwsgi/vassals
gid = www-data
uid = www-data
logto = /var/log/uwsgi-emperor.log

" > emperor.ini
```

2.2. Папка для сокетов

```
cd /run/
mkdir uwsgi
chown www-data:www-data uwsgi/
```

2.3. Конфиг systemd

```
echo "[Unit]
Description=uWSGI Emperor
After=syslog.target

[Service]
ExecStart=/usr/local/bin/uwsgi --ini /etc/uwsgi/emperor.ini
Restart=always
KillSignal=SIGQUIT
Type=notify
StandardError=syslog
NotifyAccess=all

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/emperor.uwsgi.service
```

Перезапустить демон и узнать статус

```
systemctl restart emperor.uwsgi.service
systemctl status emperor.uwsgi.service
```

3. Создание конфига приложения.

Допустим в папке `/opt/django-app` находится Django Application. Приложение должно корректно запускаться с помощью сервера разработки. Создадим конфиг файлы для его работы через uwsgi.

```
echo "[uwsgi]

chdir           = /opt/django-app
module          = project.wsgi
master          = true
processes       = 5
socket          = /run/uwsgi/django-app.sock
vacuum          = true
" > /etc/uwsgi/vassals/django-app.ini
```

Перезапустим uwsgi и проверим логи.

```
systemctl restart emperor.uwsgi.service
tail -n 100  /var/log/uwsgi-emperor.log
```

Результат будет примерно таким:

```
mapped 437424 bytes (427 KB) for 5 cores
spawned uWSGI master process (pid: 19987)
Fri Jan 10 10:50:11 2020 - [emperor] vassal django-app.ini has been spawned
spawned uWSGI worker 1 (pid: 19997, cores: 1)
spawned uWSGI worker 2 (pid: 19998, cores: 1)
spawned uWSGI worker 3 (pid: 19999, cores: 1)
spawned uWSGI worker 4 (pid: 20000, cores: 1)
spawned uWSGI worker 5 (pid: 20001, cores: 1)
Fri Jan 10 10:50:11 2020 - [emperor] vassal django-app.ini is ready to accept requests
```

Python приложение отвечает по сокету /run/uwsgi/django-app.sock.


Теперь создадим конфиг nginx

```
echo "

server {
    root /opt/django-app/common/static;

    listen      80;
    server_name django-app.com;
    charset     utf-8;

    client_max_body_size 75M;

    location /static {
        alias /opt/django-app/common/static/;
    }

    location /media {
        alias /opt/django-app/common/media/;
    }

    location = / {
        uwsgi_pass  unix:///run/uwsgi/django-app.sock;
        include     /etc/nginx/uwsgi_params;
    }

    location / {
        try_files $uri $uri/ @django;
    }

    location @django {
        uwsgi_pass  unix:///run/uwsgi/django-app.sock;
        include     /etc/nginx/uwsgi_params;
    }
}

" > /etc/nginx/sites-enabled/django-app
```

Теперь нужно перезапустить nginx и uwsgi. После этого приложение должно отвечать по `http://django-app.com`
