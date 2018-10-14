#!/bin/bash

rm /etc/apache2/modsecurity.d/owasp-modsecurity-crs/crs-setup.conf.example
rm /etc/apache2/modsecurity.d/owasp-modsecurity-crs/rules/*example
service apache2 stop
a2dismod -f deflate
a2enmod cgi

rm /etc/apache2/mods-enabled/security2.conf
rm /var/www/html/index.html

apachectl start

python api/api.py