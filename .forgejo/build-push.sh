#!/usr/bin/env sh

set -e

# VERSION=$(git describe --always --dirty --tags 2>/dev/null || echo "undefined")
# GO_MOD_VERSION=$(sed -En 's/^go ([[:digit:]]\.[[:digit:]]+)\.[[:digit:]]+/\1/p' go.mod)

VERSION=v7.8.2
GO_MOD_VERSION=1.23.7

docker buildx build . \
  --platform linux/arm64,linux/amd64 \
  --tag funktionpi/oauth-proxy:${VERSION} \
  --build-arg RUNTIME_IMAGE=gcr.io/distroless/static:nonroot \
  --build-arg BUILD_IMAGE=docker.io/library/golang:${GO_MOD_VERSION}-bookworm \
  --build-arg VERSION=${VERSION} \
  --push 

docker buildx build . \
  --platform linux/arm64,linux/amd64 \
  --tag git.tpi.outbreak/mirrors/oauth-proxy:${VERSION} \
  --build-arg RUNTIME_IMAGE=gcr.io/distroless/static:nonroot \
  --build-arg BUILD_IMAGE=docker.io/library/golang:${GO_MOD_VERSION}-bookworm \
  --build-arg VERSION=${VERSION} \
  --push 
