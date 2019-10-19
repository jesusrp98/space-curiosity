# Use Google's official Dart image.
# https://hub.docker.com/r/google/dart-runtime/
# FROM google/dart-runtime
FROM cirrusci/flutter:latest

# COPY /build/web/ /
RUN git clone https://github.com/jesusrp98/space-curiosity && cd space-curiosity && git checkout web-drv
RUN ls

ENV PORT 8080
ENV HOST 0.0.0.0

