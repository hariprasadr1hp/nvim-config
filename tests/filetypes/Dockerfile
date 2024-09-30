# Dockerfile example to test editor settings

# Use an official base image from Docker Hub
FROM node:16-alpine

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Set a working directory
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json first to leverage Docker's cache for dependencies
COPY package*.json ./

# Install dependencies (in production, only install production dependencies)
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Expose the application's port
EXPOSE $PORT

# Set an entrypoint (default command) for the container
ENTRYPOINT ["npm", "run"]

# Default command to run when the container starts
CMD ["start"]

# Health check to verify that the service is up and running
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl --fail http://localhost:$PORT/health || exit 1

# Add a label for metadata (useful for organizing or describing containers)
LABEL maintainer="John Doe <john.doe@example.com>"
LABEL version="1.0"
LABEL description="Production-ready Node.js application"

# Multistage build example for reducing image size

# Build stage
FROM node:16-alpine AS builder

# Set a working directory for the build
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the application code and build it
COPY . .
RUN npm run build

# Production stage
FROM node:16-alpine

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Set a working directory
WORKDIR /usr/src/app

# Copy only the build output and production dependencies from the build stage
COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/package.json ./package.json

# Expose the application's port
EXPOSE $PORT

# Set an entrypoint
ENTRYPOINT ["npm", "run"]

# Default command to run the application
CMD ["start"]

# Clean up apt-get caches (for Debian-based images, not used in Alpine)
# RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Example of adding a user and switching to a non-root user for security purposes
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Volumes (for persisting data)
VOLUME ["/usr/src/app/data"]

# Example of copying configuration files
COPY ./config/default.json /usr/src/app/config/default.json

# Example of ARG usage (for build-time variables)
ARG BUILD_VERSION
ENV BUILD_VERSION=${BUILD_VERSION}

# Example of defining multiple labels
LABEL com.example.app.version="${BUILD_VERSION}" \
      com.example.app.license="MIT" \
      com.example.app.vendor="Example Inc."


