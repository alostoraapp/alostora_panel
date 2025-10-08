FROM nginx:latest

# Remove the default Nginx config
RUN rm /etc/nginx/conf.d/default.conf
ADD /nginx/default.conf /etc/nginx/conf.d/default.conf

# Create the build directory and set the proper permissions
RUN mkdir -p /app/frontend/build && \
    chmod 755 /app/frontend/build

# Remove any existing content in /app/frontend/build (this will not remove the volume itself)
RUN rm -rf /app/frontend/build/*

# Add the new frontend build files to the container
ADD ./build/web/ /app/frontend/build/

# Declare the volume
VOLUME /app/frontend/build