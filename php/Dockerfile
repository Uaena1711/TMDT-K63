FROM php:7.3-fpm as base-php

WORKDIR /magento
RUN apt-get update -q

RUN apt-get install -qq -y \
  curl \
  git \
  zip \
  unzip \
  wget

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync

RUN install-php-extensions \
  bcmath \
  bz2 \
  calendar \
  exif \
  gd \
  intl \
  ldap \
  mcrypt \
  mysqli \
  opcache \
  pdo_mysql \
  zip

RUN install-php-extensions fileinfo pcntl

# RUN docker-php-ext-install fileinfo pcntl

FROM base-php as install-composer

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && ln -s $(composer config --global home) /root/composer

ENV PATH=$PATH:/root/composer/vendor/bin COMPOSER_ALLOW_SUPERUSER=1

FROM install-composer as other-dependency

#install your lib here

RUN apt-get update -qq

RUN apt-get install -y -q default-jre

RUN apt-get install -y -q libgmp-dev && install-php-extensions gmp

RUN install-php-extensions yaml soap xsl

RUN echo "set-option -g default-shell $SHELL" > ~/.tmux.conf

FROM other-dependency as entrypoint

# RUN echo -e "#!/bin/bash\nservice supervisor start\ngearmand -d\nphp-fpm" > start.sh
# RUN chmod a+x /usr/local/etc/start.sh

CMD [ "/usr/local/etc/start.sh" ]

