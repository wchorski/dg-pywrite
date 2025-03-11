# Stage 1: Build the Eleventy app
FROM node:20 AS builder

WORKDIR /app

# Install dependencies and build the site
COPY package.json package-lock.json ./
RUN npm install

COPY . ./
RUN npm run build



# Stage 2: Serve with Nginx
FROM nginx:latest AS server

# Copy built site from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# # Copy a custom Nginx configuration (optional)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
