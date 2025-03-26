FROM nginx:alpine

COPY index.html /usr/share/nginx/html/
COPY user.png /usr/share/nginx/html/
COPY bot.png /usr/share/nginx/html/
COPY arrow.png /usr/share/nginx/html/
COPY chat_background.png /usr/share/nginx/html/
COPY android-chrome-512x512.png /usr/share/nginx/html/

# Modify Nginx configuration to listen on port 8080
RUN sed -i 's/listen       80;/listen       8080;/' /etc/nginx/conf.d/default.conf
