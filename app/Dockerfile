# Build stage
FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage
# Intentionally using a base image with known vulnerabilities
FROM node:20.0.0-alpine3.16

WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
RUN npm ci --production

# Run as root (security issue)
USER root

EXPOSE 3000
CMD ["node", "dist/index.js"]

# Fix: Use latest node:20-alpine, add non-root user
# FROM node:20-alpine
# RUN addgroup -S appgroup && adduser -S appuser -G appgroup
# USER appuser
