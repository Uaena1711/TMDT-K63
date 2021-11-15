#!/bin/bash

bin/magento setup:install --base-url=http://magento2.local --db-host=db --db-name=magentodb --db-user=root --db-password=123456 --admin-firstname=admin --admin-lastname=admin --admin-email=admin@gmail.com --admin-user=admin --admin-password=Admin123456 --language=en_US --currency=USD
php-fpm
