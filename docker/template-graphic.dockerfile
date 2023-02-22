ARG IMAGE_TAG
FROM ${IMAGE_TAG}

ARG CAVIF_VERSION
RUN     install-php-extensions \
          imagick \
          gd \
    &&  apk add --no-cache jpegoptim pngquant libwebp-tools \
    &&  mkdir /tmp/cavif && \
        cd /tmp/cavif && \
        curl -fSL \
          --retry 10 \
          --retry-delay 60 \
          https://github.com/kornelski/cavif-rs/releases/download/v${CAVIF_VERSION}/cavif-${CAVIF_VERSION}.zip -O && \
        unzip cavif-${CAVIF_VERSION}.zip && \
        cp linux-generic/cavif /usr/bin/cavif && \
        rm -rf /tmp/cavif
