FROM php:latest

# Create app directory
COPY . /usr/src/mediawiki-to-gfm
WORKDIR /usr/src/mediawiki-to-gfm

# Install packages
RUN apt-get update --fix-missing \
  && apt-get install -y git pandoc \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Composer update
RUN php /usr/local/bin/composer update --no-dev

ENTRYPOINT ["./entrypoint.sh"]