# Usa a imagem oficial do PHP com Apache
FROM php:8.2-apache

# Instala extensões necessárias
RUN docker-php-ext-install pdo pdo_mysql

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define o diretório de trabalho
WORKDIR /var/www

# Copia o código do backend para dentro do container
COPY . /var/www

# Instala dependências do Laravel
RUN composer install

# Garante permissões corretas
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Expõe a porta 8000
EXPOSE 8000

# Comando para rodar o Laravel
CMD php artisan serve --host=0.0.0.0 --port=8000
