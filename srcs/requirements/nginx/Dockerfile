# Use Debian Bullseye as the base image
FROM debian:bullseye

# Update package lists and install required packages
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    openssl && \
    apt-get clean

# Create SSL certificate directory
RUN mkdir -p /etc/nginx/ssl

# Generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/ssl.key \
    -out /etc/ssl/certs/ssl.crt \
    -subj "/C=AT/ST=Austria/L=Vienna/O=42/CN=localhost"

# Copy Nginx configuration file into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Expose HTTPS port
EXPOSE 443

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
