# PHP + Xdebug

%%VERSION_BADGES%%

[![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/%%IMAGE%%/%%LATEST_TAG%%?label=w%2Fo%20graphic%20libs)](https://hub.docker.com/r/%%IMAGE%%)
[![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/%%IMAGE%%/%%LATEST_GRAPHIC_TAG%%?label=w%2F%20graphic%20libs)](https://hub.docker.com/r/%%IMAGE%%)
[![Docker Image Size (latest semver)](https://img.shields.io/docker/pulls/%%IMAGE%%)](https://hub.docker.com/r/%%IMAGE%%)
[![build](https://github.com/hyqo/docker-php/actions/workflows/build.yml/badge.svg?event=push)](https://github.com/hyqo/docker-php/actions/workflows/build.yml)

arch: linux/amd64, linux/arm64

```
docker pull %%IMAGE%%:%%LATEST_VERSION%%-fpm
docker pull %%IMAGE%%:%%LATEST_VERSION%%-cli
docker pull %%IMAGE%%:%%LATEST_VERSION%%-zts
```

|                                 | prod    | dev     |
|---------------------------------|---------|---------|
| Composer `%%COMPOSER_VERSION%%` | &check; | &check; |
| Xdebug `%%XDEBUG_VERSION%%`     |         | &check; |
| PHPStan `%%PHPSTAN_VERSION%%`   |         | &check; |
| Redis `%%REDIS_VERSION%%`       | &check; | &check; |
| PDO, PDO MySQL                  | &check; | &check; |
| zip, pcntl, event, ev, ffi      | &check; | &check; |
| OPcache                         | &check; | &check; |

Containers with graphic libs include:

* ImageMagick
* GD
* cwebp, dwebp
* cavif
* jpegoptim
* pngquant

## Supported tags

%%TAGS_TABLE%%

%%GRAPHIC_TAGS_TABLE%%
