FROM mysql:5.5
MAINTAINER Shawn Drape <shawn@dra.pe>

ADD run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

CMD ["/tmp/run.sh"]