# syntax=docker/dockerfile:1.4
FROM --platform=$BUILDPLATFORM php:8.3.7-cli-alpine AS base

ARG VERSION

RUN <<EOT
  curl -f -o /usr/bin/pint -LO "https://github.com/laravel/pint/releases/download/v${VERSION}/pint.phar"
  chmod +x /usr/bin/pint
EOT

ENTRYPOINT ["/usr/bin/pint"]
CMD []
