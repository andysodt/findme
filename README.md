# mobb.space findme

mobb.space is a mesh based ecosytem with software and hardware components.
findme is an app to coordinate anonymous users around a map pin.

Server is running: [monitor](http://mobb.space:8080) This is an example that monitors node resources via WAMP using crossbar and javascript.  This is basically the mechanism we will use to write the web based app and peer to peer communication.

Admin interface: [admin](http://mobb.space:8080/admin)  Just the non-public admin pages.

## Installation (this may need more details)

### Assuming a fresh install of Ubuntu Xenial Xerus logged in as root
```
adduser mobb
gpasswd -a demo sudo
```
### Log out and log in as mobb, then isntall postgres and postgis
```
sudo apt install postgresql postgresql-contrib postgresql-server-dev-9.5 postgis
```
### Now configure postgres:
[Postgres authentication set up](https://help.ubuntu.com/lts/serverguide/postgresql.html)
Give user postgres a good password

### Set up the db user and create database
```
sudo -u postgres createuser mobb
sudo -u postgres createdb --encoding=UTF8 --owner=mobb findme
psql --username=postgres -c "ALTER USER mobb WITH superuser;"
psql --username=mobb --dbname=findme -c "CREATE EXTENSION postgis;"
psql --username=mobb --dbname=findme -c "CREATE EXTENSION postgis_topology;"
```
### install PyPy and virtualenv
```
sudo apt-add-repository ppa:pypy/ubuntu/ppa
sudo apt update
sudo apt install build-essential libssl-dev python-pip pypy pypy-dev
sudo pip install virtualenv
virtualenv --python=pypy ~/pypy-venv
cd ~/pypy-venv/
. bin/activate
```
### install and check crossbar.io
```
pip install crossbar
crossbar version
```

### install findme
```
cd ~
git clone https://github.com/andysodt/findme.git
crossbar init
pip install django django-jet google-api-python-client feedparser psycopg2cffi
python manage.py migrate
```
### load world borders data
```
python manage.py shell
>>> from world import load
>>> load.run()
>>> exit()
```

### create superuser
```
python manage.py createsuperuser
```

### Start up
```
crossbar start --cbdir /home/mobb/findme/.crossbar
```

### Start up monitor (may need to edit client.py to change to your machine's IP address)
```
python client.py
```
### Automatic Startup and Restart

Create a systemd service file /etc/systemd/system/crossbar.service

Put this in it:
```
[Unit]
Description=mobb.space findme
After=network.target

[Service]
Type=simple
User=mobb
Group=mobb
StandardInput=null
StandardOutput=journal
StandardError=journal
Environment="MYVAR1=foobar"
ExecStart=/home/mobb/findme/start.sh
Restart=on-abort

[Install]
WantedBy=multi-user.target
```

Then do:
```
sudo systemctl daemon-reload
```

To make Crossbar.io start automatically at boot time:
```
sudo systemctl enable crossbar.service
```

To start, stop, restart and get status for Crossbar.io:
```
sudo systemctl start crossbar
sudo systemctl stop crossbar
sudo systemctl restart crossbar
sudo systemctl status crossbar
```

To get log output:
```
journalctl -f -u crossbar
```

### Optional: Run on port 80

Currently, .crossbar/config.json has findme running on port 8888.  This seems to be working fine since we have the website under apache on 80.  By default apache runs on port 80, so you will need to move that (/etc/apache2/ports.conf) or not run apache if you want to switch to 80.

Install libcap2:
```
sudo apt-get install libcap2-bin
```
Now allow the Crossbar.io and PyPy executables to bind privileged ports:
```
sudo setcap cap_net_bind_service=+ep `which crossbar`
sudo setcap cap_net_bind_service=+ep `which pypy`
```

### Collect Static (Not sure if this is needed)
```
python manage.py collectstatic
```

## Helpful Links

[GeoDjango tutorial](https://docs.djangoproject.com/en/1.9/ref/contrib/gis/tutorial/)
[leaflet D3 tutorial](https://bost.ocks.org/mike/leaflet/)



