# Usa a imagem oficial do PHP com Apache
FROM php:8.2-apache

# Instala dependências do sistema e extensões do PHP
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    libzip-dev \
    && docker-php-ext-configure zip \
    && docker-php-ext-install pdo pdo_mysql zip

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define o diretório de trabalho
WORKDIR /var/www

# Copia o código do backend para dentro do container
COPY . /var/www

# Garante permissões corretas antes de instalar dependências
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Instala dependências do Laravel
RUN composer install

# Expõe a porta 8000
EXPOSE 8000

# Comando para rodar o Laravel
CMD php artisan serve --host=0.0.0.0 --port=8000