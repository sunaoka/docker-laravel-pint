FROM --platform=$BUILDPLATFORM php:8.3.3-cli-alpine AS base

COPY --from=composer /usr/bin/composer /usr/bin/composer

WORKDIR /pint

RUN composer require laravel/pint --dev && rm /usr/bin/composer

ENTRYPOINT ["/pint/vendor/bin/pint"]
CMD []
