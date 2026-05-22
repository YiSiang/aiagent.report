FROM nginx:alpine

# Replace default nginx static files with this project content.
COPY . /usr/share/nginx/html

EXPOSE 80
