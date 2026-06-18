# Build Stage
FROM node:20-alpine AS builder

# Install pnpm
RUN npm install -g pnpm

WORKDIR /repo

# Copy the entire workspace so the build step has access to blueprints/ and meta.json
COPY . .

# Build the app from the app subdirectory
WORKDIR /repo/app
RUN pnpm install
RUN pnpm build

# Serve Stage
FROM caddy:2-alpine
COPY --from=builder /repo/app/dist /usr/share/caddy
EXPOSE 80
