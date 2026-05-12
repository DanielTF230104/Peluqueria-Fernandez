#!/bin/bash
hostnamectl set-hostname API-LARAVEL
exec > /tmp/userdata.log 2>&1

apt update -y
apt install -y apache2 php8.2 php8.2-mysql php8.2-xml php8.2-curl php8.2-mbstring zip unzip libapache2-mod-php

# Instalamos Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Configuración de Apache para Laravel
cat > /etc/apache2/sites-available/laravel.conf <<EOF
<VirtualHost *:80>
    # Apuntamos a la carpeta public de tu proyecto
    DocumentRoot /var/www/html/public
    <Directory /var/www/html/public>
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

a2enmod rewrite
a2dissite 000-default
a2ensite laravel.conf

mkdir -p /var/www/html/public
chown -R ubuntu:ubuntu /var/www/html
chmod -R 755 /var/www/html

systemctl restart apache2