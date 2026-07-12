FROM ubuntu:22.04

# Install tools & fix SSL
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl unzip nginx \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download V2Ray v5 (NO v2ctl)
RUN curl -k -L -o /tmp/v2ray.zip https://github.com/v2fly/v2ray-core/releases/download/v5.20.0/v2ray-linux-64.zip && \
    unzip /tmp/v2ray.zip -d /usr/local/bin/ && \
    chmod +x /usr/local/bin/v2ray && \
    rm -rf /tmp/*

# Create folders
RUN mkdir -p /etc/v2ray /etc/nginx/conf.d

# Copy files
COPY config.json /etc/v2ray/config.json
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh

# Set permission
RUN chmod +x /entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
