# ============================================
# Shared Dockerfile for Claude Code
# ============================================
# This Dockerfile is used by all Claude instances (kimi, glm, etc.)

# Node 20 + Debian
FROM node:20-bookworm

# Support build argument to specify Claude Code version
ARG CLAUDE_VERSION=latest
ENV CLAUDE_VERSION=${CLAUDE_VERSION}

# Install Claude Code (supports version via build argument)
RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_VERSION} --omit=dev

# Install necessary tools and clean up cache
RUN apt-get update && \
    apt-get install -y curl git jq python3 python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Create user with UID/GID 1001/1001
RUN groupadd -g 1001 claude 2>/dev/null || true && \
    useradd -u 1001 -g 1001 -ms /bin/bash claude 2>/dev/null || true

# Create necessary directories and set correct permissions
RUN mkdir -p /home/claude/.claude && \
    mkdir -p /home/claude/.config && \
    mkdir -p /home/claude/.local/share && \
    chown -R claude:claude /home/claude

# Copy setup scripts from subdirectories
# These will be copied during build context
COPY claude-kimi/setup-kimi.sh /usr/local/bin/setup-kimi.sh
COPY claude-glm/setup-glm.sh /usr/local/bin/setup-glm.sh
RUN chmod +x /usr/local/bin/setup-*.sh

WORKDIR /workspace

# Default entrypoint (can be overridden in docker-compose.yml)
ENTRYPOINT ["/bin/bash"]
