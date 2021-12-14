#!/bin/bash

chmod -R 777 /magento/var/ /magento/generated/ /magento/vendor/;
composer update;
composer install;

bin/magento setup:install --base-url=http://chickengangz.xyz --db-host=db --db-name=magentodb --db-user=root --db-password=123456 --admin-firstname=admin --admin-lastname=admin --admin-email=admin@gmail.com --admin-user=admin --admin-password=Admin123456 --language=en_US --currency=USD
php-fpm;

bin/magento setup:di:compile;
bin/magento setup:static-content:deploy -f;

chmod -R 777 /magento/var/cache;
