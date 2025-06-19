FROM node:18

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y postgresql-client netcat-openbsd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install global packages
RUN npm install -g nodemon

# Copy package files first for better caching
COPY package*.json ./
COPY prisma ./prisma

# Install dependencies and generate Prisma client
RUN npm install && npx prisma generate

# Copy all other files (exclude what's in .dockerignore)
COPY . .

# Build if using TypeScript (uncomment if needed)
# RUN npm run build

EXPOSE 3000

# Health check for production
HEALTHCHECK --interval=30s --timeout=10s \
  CMD node healthcheck.js || exit 1

# Default production command
CMD ["node", "app.js"]