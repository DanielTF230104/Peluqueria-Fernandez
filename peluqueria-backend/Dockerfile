# Usamos una imagen de PHP con Apache
FROM php:8.2-apache

# Instalamos extensiones necesarias para MySQL y Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl

# Limpiamos cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalamos extensiones de PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Habilitamos el módulo de reescritura de Apache para las rutas de Laravel
RUN a2enmod rewrite

# Cambiamos el DocumentRoot de Apache a la carpeta /public de Laravel
ENV APACHE_DOCUMENT_ROOT /var/www/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Directorio de trabajo
WORKDIR /var/www

# Copiamos el proyecto
COPY . .

# Damos permisos a las carpetas de Laravel
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache