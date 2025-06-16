FROM node:18

WORKDIR /app

# Install postgresql-client dan netcat-openbsd
RUN apt-get update && \
    apt-get install -y postgresql-client netcat-openbsd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Salin file package.json dan install dependensi
COPY package.json ./
RUN npm install

# Salin seluruh source code ke container
COPY . .

# Buka port aplikasi
EXPOSE 3000

# Jalankan aplikasi (opsional karena override via docker-compose)
CMD ["node", "app.js"]
