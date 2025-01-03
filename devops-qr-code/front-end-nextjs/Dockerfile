# # Use Node.js 18 Alpine as the base image
# FROM node:18-alpine AS base

# # Set the working directory
# WORKDIR /app

# # Copy the package manager lock files (if available)
# COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./

# # Install dependencies based on the lock file
# RUN \
#     if [ -f yarn.lock ]; then yarn install --frozen-lockfile; \
#     elif [ -f package-lock.json ]; then npm ci; \
#     elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm i --frozen-lockfile; \
#     else echo "No lockfile found. Skipping dependency installation." && exit 1; \
#     fi

# # Copy the rest of the application  files
# COPY . .

# # Build the application
# RUN npm run build

# # Expose the port the app runs on
# EXPOSE 3000

# # Start the application
# CMD ["npm", "start"]


# Use Node.js 18 Alpine as the build stage
FROM node:18-alpine AS build

# Set the working directory
WORKDIR /app

# Install necessary build tools
RUN apk add --no-cache bash curl python3 g++ make

# Copy dependency files and install dependencies
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./
RUN if [ -f yarn.lock ]; then yarn install --frozen-lockfile; \
    elif [ -f package-lock.json ]; then npm ci; \
    elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm i --frozen-lockfile; \
    else echo "No lockfile found. Skipping dependency installation." && exit 1; \
    fi

# Copy the rest of the application files
COPY . .

# Build the application
RUN npm run build

# Production image
FROM node:18-alpine AS production

# Set the working directory
WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app/package.json /app

# Install production dependencies only
RUN apk add --no-cache bash && npm install --production

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
