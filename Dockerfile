FROM shinsenter/php:8.4-fpm-apache-alpine

USER root
RUN apk add --no-cache nodejs npm fish
RUN npm i -g pnpm 