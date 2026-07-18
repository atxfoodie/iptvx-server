FROM debian:bookworm-slim

# Install core runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tar \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Set working environment
WORKDIR /app

# Download and extract the provided multi-arch bundle
RUN curl -L -o iptvx-server.tar.gz https://iptvx.app/server/iptvx-server-1.0-linux-multiarch.tar.gz \
    && tar -xzf iptvx-server.tar.gz --strip-components=1 \
    && rm iptvx-server.tar.gz

# Copy the architecture routing script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose default IPTVX port
EXPOSE 9090

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
