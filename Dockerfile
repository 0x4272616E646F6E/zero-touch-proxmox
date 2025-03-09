# Define the base image
FROM alpine:edge

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Install build dependencies
RUN apk add --no-cache \
  bash \
  build-base \
  ca-certificates \
  cargo \
  curl \
  dnsmasq \
  git \
  libffi \
  openssh-client \
  openssl \
  opentofu \
  py3-pip \
  python3 \
  syslinux \
  tar \
  tftp-hpa \
  pip3 install --no-cache-dir --upgrade pip && \
  pip3 install --no-cache-dir \
  ansible \
  ansible-core && \
  ansible-galaxy collection install community.general

# Create working directory
WORKDIR /app

# Set entrypoint
ENTRYPOINT ["/bin/bash"]