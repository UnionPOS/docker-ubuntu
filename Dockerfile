FROM unionpos/aws-vault:5.2.0 AS aws-vault
FROM unionpos/chamber:2.7.5 AS chamber

FROM ubuntu:16.04

ENV DEBIAN_FRONTEND="noninteractive"

## Prevent initramfs updates from trying to run grub and lilo.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
ENV INITRD=no

# disable APT cache
COPY config/apt_nocache /etc/apt/apt.conf.d/02nocache

# Disable man pages, locales and docs
COPY config/dpkg_nodoc /etc/dpkg/dpkg.cfg.d/01_nodoc
COPY config/dpkg_nolocales /etc/dpkg/dpkg.cfg.d/01_nolocales

RUN set -ex \
  && buildDeps=' \
  build-essential \
  ca-certificates \
  curl \
  wget \
  pv \
  software-properties-common \
  tzdata \
  ' \
  && apt-get update \
  && apt-get install -y --no-install-recommends $buildDeps \
  && rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/cache/apt/archives  \
  && rm -rf /usr/share/doc/ \
  && rm -rf /usr/share/man/ \
  && rm -rf /usr/share/locale/

COPY --from=aws-vault /aws-vault /bin/aws-vault

COPY --from=chamber /chamber /bin/chamber

COPY scripts/bashui.sh /usr/local/lib/

CMD [ "/bin/bash" ]
