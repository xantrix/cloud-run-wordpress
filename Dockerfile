# https://github.com/docker-library/wordpress/blob/9ee913eea382b5d79f852a2301d4390904d2e4d2/php7.3/apache/Dockerfile
FROM wordpress:5.2.1-php7.3-apache

EXPOSE 8080
# apache conf
COPY apache/ports.conf /etc/apache2/ports.conf
COPY apache/000-default.conf  /etc/apache2/sites-available/000-default.conf
# wordpress conf
COPY wordpress/wp-config.php /var/www/html/wp-config.php

# download and install cloud_sql_proxy
RUN apt-get update && apt-get install net-tools wget && \
    wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O /usr/local/bin/cloud_sql_proxy && \ 
    chmod +x /usr/local/bin/cloud_sql_proxy

# custom entrypoint
COPY wordpress/cloud-run-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["cloud-run-entrypoint.sh"]
CMD ["apache2-foreground"]