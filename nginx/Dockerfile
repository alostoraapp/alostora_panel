# --- Stage 1: Build the Flutter App ---
# Use a Flutter image that matches your 'stable' channel
FROM cirrusci/flutter:stable AS build

WORKDIR /app

# Copy pubspec files first to leverage Docker's layer cache
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the application source code
COPY . .

# Build the web application. This creates the /app/build/web directory
RUN flutter build web --release

# --- Stage 2: Build the final Nginx Image ---
# Use a lightweight nginx image for the final container
FROM nginx:latest

# Remove the default Nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom Nginx config
# This path must match your repo structure
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy the built Flutter app from the 'build' stage (Stage 1)
# to the Nginx root directory defined in your 'default.conf'
COPY --from=build /app/build/web /app/frontend/build