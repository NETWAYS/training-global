FROM docker.io/ubuntu:lunar
LABEL maintainer="support@netways.de"

WORKDIR /training

# Basic showoff and patched wkhtmltopdf dependencies
RUN set -ex; \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --no-install-recommends -y \
      build-essential \
      curl \
      markdown \
      ruby \
      ruby-dev \
      rubygems \
      xz-utils \
      zlib1g \
      zlib1g-dev \
      libssl3 \
      libxrender-dev \
      libx11-dev \
      libxext-dev \
      libfontconfig1-dev \
      libfreetype6-dev \
      fontconfig \
      libjpeg-turbo8 \
      xfonts-75dpi \
      xfonts-base \
  && apt-get clean \
  && rm -r /var/lib/apt/lists/*

# wkhtmltopdf needs a patched QT version
ADD vendor/wkhtmltox_0.12.6.1-2.jammy_amd64.deb /tmp/wkhtmltox.deb
RUN set -ex; \
    dpkg -i /tmp/wkhtmltox.deb \
    && rm -f /tmp/wkhtmltox.deb

# Install showoff Gem
ARG showoff_version=0.20.4
RUN gem install showoff --version="$showoff_version"

EXPOSE 9090

CMD ["showoff", "serve"]
