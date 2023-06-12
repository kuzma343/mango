FROM ubuntu:20.04

# Оновити пакетний менеджер і встановити необхідні пакети
RUN apt-get update && \
    apt-get install -y gnupg wget && \
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - && \
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list && \
    apt-get update && \
    apt-get install -y mongodb-org

# Створити каталог для зберігання даних MongoDB
RUN mkdir -p /data/db

# Відкрити порт 27017 для доступу до MongoDB
EXPOSE 27017

# Запустити MongoDB
CMD ["mongod"]

