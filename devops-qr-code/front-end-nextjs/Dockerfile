# Build Stage
FROM node:18-alpine AS build

WORKDIR /app

# Install dependencies
RUN apk add --no-cache bash curl python3 g++ make
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./
RUN if [ -f yarn.lock ]; then yarn install --frozen-lockfile; \
    elif [ -f package-lock.json ]; then npm ci; \
    elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm i --frozen-lockfile; \
    else echo "No lockfile found. Skipping dependency installation." && exit 1; \
    fi

# Copy the application files and build
COPY . .
RUN npm run build

# Production Stage
FROM node:18-alpine AS production

WORKDIR /app

# Copy the build artifacts
COPY --from=build /app/.next /app/.next
COPY --from=build /app/package.json /app/package.json

# Install production dependencies
RUN npm install --production

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
