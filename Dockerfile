FROM ubuntu:22.04

# Install dependencies
RUN apt update && apt install -y \
    curl unzip libicu70 \
    && useradd -m runner

# Set working directory
WORKDIR /home/runner

# Copy and set permissions before switching users
COPY entrypoint.sh /home/runner/entrypoint.sh
RUN chmod +x /home/runner/entrypoint.sh \
    && chown runner:runner /home/runner/entrypoint.sh

# Download GitHub runner as runner user
USER runner

ENTRYPOINT ["./entrypoint.sh"]
