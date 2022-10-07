FROM php:8.1.11-fpm-alpine3.16

# Install packages and remove default server definition
RUN apk --no-cache add gnupg autoconf make g++ nginx supervisor zlib-dev libpng-dev icu-dev icu-libs librdkafka-dev git libzip-dev shadow nodejs npm file imagemagick imagemagick-dev

# Install PHP extensions
RUN docker-php-ext-install bcmath gd exif pcntl intl zip

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

#Download the desired package(s)
RUN curl -O https://download.microsoft.com/download/b/9/f/b9f3cce4-3925-46d4-9f46-da08869c6486/msodbcsql18_18.1.1.1-1_amd64.apk
RUN curl -O https://download.microsoft.com/download/b/9/f/b9f3cce4-3925-46d4-9f46-da08869c6486/mssql-tools18_18.1.1.1-1_amd64.apk

#(Optional) Verify signature, if 'gpg' is missing install it using 'apk add gnupg':
RUN curl -O https://download.microsoft.com/download/b/9/f/b9f3cce4-3925-46d4-9f46-da08869c6486/msodbcsql18_18.1.1.1-1_amd64.sig
RUN curl -O https://download.microsoft.com/download/b/9/f/b9f3cce4-3925-46d4-9f46-da08869c6486/mssql-tools18_18.1.1.1-1_amd64.sig

RUN curl https://packages.microsoft.com/keys/microsoft.asc  | gpg --import -
RUN gpg --verify msodbcsql18_18.1.1.1-1_amd64.sig msodbcsql18_18.1.1.1-1_amd64.apk
RUN gpg --verify mssql-tools18_18.1.1.1-1_amd64.sig mssql-tools18_18.1.1.1-1_amd64.apk

#Install the package(s)
RUN apk add --allow-untrusted msodbcsql18_18.1.1.1-1_amd64.apk
RUN apk add --allow-untrusted mssql-tools18_18.1.1.1-1_amd64.apk

# Set mssql-tools ENV variable to the PATH
ENV PATH "$PATH:/opt/mssql-tools/bin"
RUN echo $PATH

# Remove the ODBC packages
RUN rm msodbcsql18_18.1.1.1-1_amd64.apk \
    mssql-tools18_18.1.1.1-1_amd64.apk \
    msodbcsql18_18.1.1.1-1_amd64.sig \
    mssql-tools18_18.1.1.1-1_amd64.sig

# Install unixodbc-dev required for pecl
RUN apk add --allow-untrusted unixodbc-dev

# Install SQL Server Drivers
RUN pecl channel-update pecl.php.net
RUN pecl install sqlsrv
RUN pecl install pdo_sqlsrv
RUN pecl install rdkafka    
RUN pecl install imagick

RUN docker-php-ext-enable --ini-name 30-sqlsrv.ini sqlsrv
RUN docker-php-ext-enable --ini-name 35-pdo_sqlsrv.ini pdo_sqlsrv
RUN docker-php-ext-enable rdkafka
RUN docker-php-ext-enable imagick

# Install Xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable --ini-name 30-xdebug.ini xdebug

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
COPY config/php.ini /usr/local/etc/php/conf.d/custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup document root
RUN mkdir -p /var/www/html

# Add application
WORKDIR /var/www/html

# Add a volume so that the external source code can be hooked
VOLUME [ "/var/www/html" ]

# Expose the port nginx is reachable on
EXPOSE 8080

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
