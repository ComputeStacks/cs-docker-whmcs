# docker run --rm -it -e LS_ADMIN_PW=changeme -p 3000:80 -p 7080:7080 cmptstks/whmcs:php7.4-litespeed /sbin/my_init -- bash -l
FROM cmptstks/php:7.4-litespeed

LABEL maintainer="https://github.com/ComputeStacks"
LABEL org.opencontainers.image.authors="https://github.com/ComputeStacks"
LABEL org.opencontainers.image.source="https://github.com/ComputeStacks/cs-docker-whmcs"
LABEL org.opencontainers.image.url="https://github.com/ComputeStacks/cs-docker-whmcs"
LABEL org.opencontainers.image.title="WHMCS with OpenLiteSpeed"

COPY 05-whmcs.sh /etc/my_init.d/
COPY root/vhosts /usr/src/lsws/conf/vhosts/
COPY whmcs_v831_full.zip /usr/src/whmcs.zip

RUN set -ex; \
    unzip -d /usr/src/ /usr/src/whmcs.zip \
      && mv /usr/src/whmcs /usr/src/whmcs-public \
      && mkdir /usr/src/whmcs \  
      && mv /usr/src/whmcs-public /usr/src/whmcs/ \
      && echo "#*/5 * * * * www-data /usr/local/lsws/lsphp74/bin/php -q /var/www/html/whmcs/whmcs-public/crons/cron.php" >> /usr/src/default/crontab \
      && echo "#*/5 * * * * www-data /usr/local/lsws/lsphp74/bin/php -q /var/www/html/whmcs/whmcs-public/crons/cron.php do --TicketEscalations" >> /usr/src/default/crontab \
      && mkdir /usr/src/whmcs/whmcs-updates \
      && mkdir /usr/src/whmcs/whmcs-private \
      && mkdir /usr/src/whmcs/log \
      && chmod +x /etc/my_init.d/05-whmcs.sh \
    ; \
    sed -i 's/  map                     Default/  map                     WHMCS/g' /usr/src/lsws/conf/httpd_config.conf; \
    echo '\n\
virtualhost WHMCS { \n\
  vhRoot                  /var/www/html/whmcs/whmcs-public \n\
  configFile              conf/vhosts/WHMCS/vhconf.conf \n\
  allowSymbolLink         1 \n\
  enableScript            1 \n\
  restrained              1 \n\
  smartKeepAlive          1 \n\
  user                    1001 \n\
  group                   1001 \n\
}' >> /usr/src/lsws/conf/httpd_config.conf && chown lsadm: -R /usr/src/lsws/conf/vhosts/