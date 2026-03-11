# syntax=docker/dockerfile:1
# check=error=true
FROM --platform=$BUILDPLATFORM php:8.4.18-cli-alpine AS base

ARG VERSION

RUN <<EOT sh -ex
  curl -f -o /usr/bin/pint -LO "https://github.com/laravel/pint/releases/download/v${VERSION}/pint.phar"
  chmod +x /usr/bin/pint
EOT

ENTRYPOINT ["/usr/bin/pint"]
CMD []
