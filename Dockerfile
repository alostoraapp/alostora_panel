# --- Stage 1: Final Nginx Image ---
# This Dockerfile ASSUMES that the 'build/web' folder
# already exists because you built it locally and committed it to Git.

FROM nginx:latest

# Remove the default Nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom Nginx config
# This assumes your Dockerfile is in the root
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy the PRE-BUILT Flutter app (from the Git repo)
# into the Nginx root directory
COPY build/web /app/frontend/build