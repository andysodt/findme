# findme (name in progress)

An mesh based ecosytem with software and hardware components.
Server is running: [monitor](http://mobb.space:8080) This is an example that monitors node resources via WAMP using crossbar and javascript.  This is basically the mechanism we will use to write the web based app and peer to peer communication.

Admin interface: [admin](http://mobb.space:8080/admin)  Just the non-public admin pages.

## Installation (this may need more details)

### Assuming a fresh install of Ubuntu Xenial Xerus

sudo apt install postgresql postgresql-contrib postgis
sudo -u postgres createuser mobb
sudo -u postgres createdb --encoding=UTF8 --owner=mobb findme
psql --username=mobb --dbname=findme -c "CREATE EXTENSION postgis;"
psql --username=mobb --dbname=findme -c "CREATE EXTENSION postgis_topology;"

### install PyPy and virtualenv
sudo apt-add-repository ppa:pypy/ubuntu/ppa
sudo apt update
sudo apt install build-essential libssl-dev python-pip pypy pypy-dev
sudo pip install virtualenv
virtualenv --python=pypy ~/pypy-venv
cd ~/pypy-venv/
. bin/activate

### install and check crossbar.io
pip install crossbar
crossbar version


## Helpful Links

https://docs.djangoproject.com/en/1.9/ref/contrib/gis/tutorial/

