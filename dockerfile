# Use a lightweight NGINX server
FROM nginx:alpine

# Copy your custom HTML file into the server
COPY index.html /usr/share/nginx/html/index.html
