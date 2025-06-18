FROM node:18

WORKDIR /app

# Install dependencies including postgresql-client and netcat
RUN apt-get update && \
    apt-get install -y postgresql-client netcat-openbsd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install nodemon globally
RUN npm install -g nodemon

# Copy package files and install dependencies
COPY package*.json ./
COPY prisma ./prisma
RUN npm install

# Copy all source code
COPY . .

# Expose application port
EXPOSE 3000

# Default command (will be overridden by docker-compose for development)
CMD ["node", "app.js"]