FROM --platform=$BUILDPLATFORM php:8.3.6-cli-alpine AS base

ARG VERSION

COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /pint

RUN composer require laravel/pint:${VERSION} --dev && rm /usr/bin/composer

ENTRYPOINT ["/pint/vendor/bin/pint"]
CMD []
