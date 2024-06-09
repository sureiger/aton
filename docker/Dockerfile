# Используем официальный образ nginx
FROM nginx:alpine

# Удаляем стандартный конфигурационный файл nginx
RUN rm /etc/nginx/conf.d/default.conf

# Копируем наш конфигурационный файл nginx
COPY nginx.conf /etc/nginx/conf.d/

# Копируем содержимое статической HTML страницы
COPY index.html /usr/share/nginx/html/

# Копируем файл самоподписанного сертификата и его ключ
COPY self-signed.crt /etc/ssl/certs/
COPY self-signed.key /etc/ssl/private/

# Открываем 80 и 443 порты
EXPOSE 80 443

# Запускаем nginx
CMD ["nginx", "-g", "daemon off;"]
