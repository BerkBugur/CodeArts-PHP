# Symfony için PHP 8.2-FPM tabanlı resmi imaj kullanılıyor
FROM php:8.2-fpm

# Gerekli bağımlılıkların yüklenmesi
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libonig-dev \
    curl \
    && docker-php-ext-install zip pdo pdo_mysql

# Composer yüklenmesi
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Symfony CLI yüklenmesi
RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

# Çalışma dizinini ayarla
WORKDIR /var/www/html

# Uygulama dosyalarını klonlama
RUN git clone https://BerkBugur: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@github.com/BerkBugur/CodeArts-PHP.git .

# Uygulamanın bağımlılıklarını yükle
RUN composer install --no-interaction --optimize-autoloader

# Symfony server'ın başlatılması
CMD ["symfony", "server:start", "--allow-all-ip", "--no-tls"]

EXPOSE 8000
