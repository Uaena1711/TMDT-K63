[![Open Source Helpers](https://www.codetriage.com/magento/magento2/badges/users.svg)](https://www.codetriage.com/magento/magento2)
[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/magento/magento2?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Crowdin](https://d322cqt584bo4o.cloudfront.net/magento-2/localized.svg)](https://crowdin.com/project/magento-2)

## Welcome
Welcome to Magento 2 installation! We're glad you chose to install Magento 2, a cutting-edge, feature-rich eCommerce solution that gets results.

## Magento System Requirements
[Magento System Requirements](https://devdocs.magento.com/guides/v2.3/install-gde/system-requirements.html).

## Install Magento

1. Install MySQL (MySQL 8 is not supported so install ver 5.7 is recommend)
2. Install php7.3 (7.4 not supported):
        
```bash
add-apt-repository ppa:ondrej/php
apt-get update
apt-get install php7.3
apt-get install php7.3-bcmath php7.3-common php7.3-curl php7.3-fpm php7.3-gd php7.3-intl php7.3-mbstring php7.3-mysql php7.3-soap php7.3-xml php7.3-xsl php7.3-zip
```
3. Other extensions
```bash
apt-get install git curl software-properties-common
``` 
4. Change php setting for your computer can run it even slow 
    ```bash
    nano /etc/php/7.3/fpm/php.ini
    ```
    ```ini
    memory_limit = 256M
    upload_max_filesize = 128M
    zlib.output_compression = On
    max_execution_time = 600
    max_input_time = 900
    ```
5. Create a database 
    - Login to mysql mysql -u root -p
    - Create db name magentodb
    - ```sql
        create database magentodb;
        quit;
      ```
    
6. Install magento 2. 
    - Clone this source 
    - Install composer: `curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer`
    - Install dependencies: `composer install`
    - Setup base env var for project: `bin/magento setup:install --base-url=http://127.0.0.1 --db-host=127.0.0.1 --db-name=magentodb --db-user=root --db-password=<Your password> --admin-firstname=<your Magento account> --admin-lastname=<your Magento account> --admin-email=<your Magento account> --admin-user=<your Magento account> --admin-password=<your Magento account> --language=en_US --currency=USD`
    - Change ownership: `sudo chown -R www-data:www-data .`

7. Config nginx file
    - `sudo vim /etc/nginx/sites-available/magento2`
    -  Enter this:   ```json
                        upstream fastcgi_backend {
                            server unix:/run/php/php7.3-fpm.sock;
                        }

                        server {
                            server_name yourdomain.com;
                            listen 80;
                            set $MAGE_ROOT /var/www/magento2;
                            set $MAGE_MODE developer; # or production

                            access_log /var/log/nginx/magento2-access.log;
                            error_log /var/log/nginx/magento2-error.log;

                            include /var/www/magento2/nginx.conf.sample;
                        }
                    ```
    - Remove the default nginx configuration file, if is not being used: `sudo rm -f /etc/nginx/sites-enabled/default`
    - Link config to site-enable: `sudo ln -s /etc/nginx/sites-available/magento2 /etc/nginx/sites-enabled/magento2`
    - Restart nginx: `sudo service nginx restart`
