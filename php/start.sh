#!/bin/bash

find var generated vendor pub/static pub/media app/etc -type f -exec chmod g+w {} + \
    && find var generated vendor pub/static pub/media app/etc -type d -exec chmod g+ws {} + \
    && chown -R :www-data $(ls -Idev/docker)
composer update;
composer install;

bin/magento setup:install --base-url=http://magento2.local --db-host=db --db-name=magentodb --db-user=root --db-password=123456 --admin-firstname=admin --admin-lastname=admin --admin-email=admin@gmail.com --admin-user=admin --admin-password=Admin123456 --language=en_US --currency=USD
php-fpm;

chmod -R 777 /magento/var/cache;
bin/magento setup:di:compile;
bin/magento setup:static-content:deploy -f;

