FROM php:7.4-apache

ENV ACCEPT_EULA=Y
# Microsoft SQL Server Prerequisites
RUN apt-get update \
	&& apt-get install -y gnupg2 \
	&& curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
	&& curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
	&& apt-get install -y --no-install-recommends \
		locales \
		apt-transport-https \
	&& echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
	&& locale-gen \
	&& apt-get update \
	&& apt-get -y --no-install-recommends install \
        unixodbc-dev \
        msodbcsql17

RUN docker-php-ext-install pdo pdo_mysql \
    && pecl install sqlsrv pdo_sqlsrv xdebug \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv xdebug

# 安裝一些測試用套件
RUN apt-get update 
	#&& apt-get install -y vim \
    #&& apt-get install -y net-tools \
    #&& apt-get install -y iputils-ping \

# Enable the SSL module
RUN a2enmod ssl

COPY src /var/www/html/
COPY config/default-ssl.conf /etc/apache2/sites-available/
RUN ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf
COPY certs/ssl.crt /etc/ssl/certs/
COPY certs/ssl.key /etc/ssl/private/

RUN /etc/init.d/apache2 restart

EXPOSE 80
EXPOSE 443