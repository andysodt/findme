# findme (name in progress)

An mesh based ecosytem with software and hardware components.
Server is running: [monitor](http://mobb.space:8080) This is an example that monitors node resources via WAMP using crossbar and javascript.  This is basically the mechanism we will use to write the web based app and peer to peer communication.

Admin interface: [admin](http://mobb.space:8080/admin)  Just the non-public admin pages.

## Installation (this may need more details)

### Assuming a fresh install of Ubuntu Xenial Xerus
```
sudo apt install postgresql postgresql-contrib postgresql-server-dev-9.5 postgis
sudo -u postgres createuser mobb
sudo -u postgres createdb --encoding=UTF8 --owner=mobb findme
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
pip install django psycopg2cffi
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
```
crossbar start --cbdir /home/mobb/findme/.crossbar
```
Create a systemd service file /etc/systemd/system/crossbar.service

Put this in it:

  [Unit]
  Description=Crossbar.io
  After=network.target

  [Service]
  Type=simple
  User=ubuntu
  Group=ubuntu
  StandardInput=null
  StandardOutput=journal
  StandardError=journal
  Environment="MYVAR1=foobar"
  ExecStart=/opt/crossbar/bin/crossbar start --cbdir=/home/ubuntu/mynode1/.crossbar
  Restart=on-abort

  [Install]
  WantedBy=multi-user.target

Adjust the path to the Crossbar.io executable /opt/crossbar/bin/crossbar and your Crossbar.io node directory /home/ubuntu/mynode1/.crossbar in above.

Then do:

  sudo systemctl daemon-reload

To make Crossbar.io start automatically at boot time:

  sudo systemctl enable crossbar.service

To start, stop, restart and get status for Crossbar.io:

  sudo systemctl start crossbar
  sudo systemctl stop crossbar
  sudo systemctl restart crossbar
  sudo systemctl status crossbar

To get log output:

  journalctl -f -u crossbar

```

## Helpful Links

[GeoDjango tutorial](https://docs.djangoproject.com/en/1.9/ref/contrib/gis/tutorial/)


