# Stage 1: Fetching node base image
FROM node:18 AS base

# Specify working directory
WORKDIR /app

# Copy dependency file
COPY package.json .

# Install dependencies
RUN npm install


# Stage 2: Using lightweight node image
FROM node:18-alpine

# Maintainer of this dockerfile
MAINTAINER ujwal.pachghare

# Setup build argrument (Ex: docker build --build-arg DB=<mongodb_url> --build-arg PORT=<port> .)
ARG PORT="8000"
ARG DB="mongodb://mongo:27017"

# Setup environment variables
ENV TIER=backend \
    PORT=$PORT \
    DB=$DB

# Specify working directory
WORKDIR /use/local/app/

# Copy dependencies from stage 1
COPY --from=base /app/node_modules/ ./node_modules

# Copy application code
COPY . .

# Expose ports
EXPOSE 8000

# Run application
CMD ["npm","start"]

