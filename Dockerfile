# Use Google's official Dart image.
# https://hub.docker.com/r/google/dart-runtime/
# FROM google/dart-runtime
FROM cirrusci/flutter:latest

COPY /build/web/ /
RUN ls

ENV PORT 8080
ENV HOST 0.0.0.0

