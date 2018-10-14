#!/bin/bash

MODSEC_PATH="/etc/apache2/modsecurity.d/";
MODSEC_CRS_PATH="/etc/apache2/modsecurity.d/owasp-modsecurity-crs";
MODSEC_STATIC_PATH="/etc/apache2/modsec_static_files";

if [ ! -d "$MODSEC_PATH" ]; then
        mkdir ${MODSEC_PATH};
        cd ${MODSEC_PATH};
        /usr/bin/git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git;
fi

cd ${MODSEC_CRS_PATH}/;

/usr/bin/git pull;
cp ${MODSEC_STATIC_PATH}/crs-setup.conf ${MODSEC_CRS_PATH}/crs-setup.conf;

# Restart service
service apache2 restart