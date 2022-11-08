FROM debian:11.5-slim@sha256:b46fc4e6813f6cbd9f3f6322c72ab974cc0e75a72ca02730a8861e98999875c7

ENV DEBIAN_FRONTEND noninteractive

COPY create-iso.sh .
COPY variables.sh .
COPY SHA256SUMS .
COPY tools/ /tools/

RUN sha256sum -c SHA256SUMS

RUN . ./variables.sh && \
    rm -f /etc/apt/sources.list && \
    echo "deb http://snapshot.debian.org/archive/debian/$(date --date "$DATE" '+%Y%m%dT%H%M%SZ') $DIST main" >> /etc/apt/sources.list && \
    echo "deb http://snapshot.debian.org/archive/debian/$(date --date "$DATE" '+%Y%m%dT%H%M%SZ') "$DIST"-updates main" >> /etc/apt/sources.list && \
    echo "deb http://snapshot.debian.org/archive/debian-security/$(date --date "$DATE" '+%Y%m%dT%H%M%SZ') "$DIST"-security/updates main" >> /etc/apt/sources.list

RUN apt-get update -o Acquire::Check-Valid-Until=false && \
    apt-get install -o Acquire::Check-Valid-Until=false --no-install-recommends --yes \
    grub-pc-bin grub-efi-ia32-bin grub-efi-amd64-bin \
    liblzo2-2 xorriso debootstrap \
    squashfs-tools debuerreotype mtools\ 
    locales g++ && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && \
    locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN dpkg-reconfigure locales

CMD ["/create-iso.sh"]
