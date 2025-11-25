#!/usr/bin/env sh

set -e

# VERSION=$(git describe --always --dirty --tags 2>/dev/null || echo "undefined")
# GO_MOD_VERSION=$(sed -En 's/^go ([[:digit:]]\.[[:digit:]]+)\.[[:digit:]]+/\1/p' go.mod)

VERSION=v7.13.0
GO_MOD_VERSION=1.25.3
PLATFORMS=linux/arm64,linux/amd64

docker buildx build . \
  --platform ${PLATFORMS} \
  --tag funktionpi/oauth-proxy:${VERSION} \
  --build-arg RUNTIME_IMAGE=gcr.io/distroless/static:nonroot \
  --build-arg BUILD_IMAGE=docker.io/library/golang:${GO_MOD_VERSION}-bookworm \
  --build-arg VERSION=${VERSION} \
  --push

docker buildx build . \
  --platform ${PLATFORMS} \
  --tag git.tpi.outbreak/mirrors/oauth-proxy:${VERSION} \
  --build-arg RUNTIME_IMAGE=gcr.io/distroless/static:nonroot \
  --build-arg BUILD_IMAGE=docker.io/library/golang:${GO_MOD_VERSION}-bookworm \
  --build-arg VERSION=${VERSION} \
  --push

# docker tag \
#   funktionpi/oauth-proxy:${VERSION} \
#   git.tpi.outbreak/mirrors/oauth-proxy:${VERSION}

# docker push git.tpi.outbreak/mirrors/oauth-proxy:${VERSION}
