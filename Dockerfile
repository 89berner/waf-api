FROM      debian:stretch
MAINTAINER Juan Berner

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y nano vim curl less ca-certificates wget python-pip jq
RUN pip install --upgrade pip

RUN apt-get update && apt-get install --fix-missing -y apache2 git libapache2-modsecurity redis-tools

# SET APACHE

COPY apache/crs-setup.conf /etc/apache2/modsec_static_files/crs-setup.conf
COPY apache/update_modsec.sh /bin/update_modsec.sh
RUN chmod a+x /bin/update_modsec.sh
RUN /bin/update_modsec.sh

COPY apache/replay.py /var/www/html/replay.py
RUN  chmod +x /var/www/html/replay.py
COPY apache/apache2.conf /etc/apache2/apache2.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

COPY apache/modsec_parser.py /bin/modsec_parser.py
RUN chmod a+x /bin/modsec_parser.py
RUN /bin/modsec_parser.py >> /tmp/parser.log

# SET API

ADD api/requirements.txt /api/requirements.txt
RUN pip install -r api/requirements.txt

ADD manage.py /api/manage.py
RUN chmod +x  /api/manage.py

ADD api/api.py             api/api.py
ADD api/lib/Modsecurity.py api/lib/Modsecurity.py
ADD api/lib/RuleEngine.py  api/lib/RuleEngine.py
ADD api/lib/RateLimiter.py api/lib/RateLimiter.py
ADD api/lib/Event.py       api/lib/Event.py
ADD api/lib/__init__.py    api/lib/__init__.py

CMD ["/entrypoint.sh"]