ARG REGISTRY_PREFIX=''
ARG CODENAME='jammy'

FROM ${REGISTRY_PREFIX}ubuntu:${CODENAME} as builder

ENV container docker
ENV PATH "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt update \
    && DEBIAN_FRONTENC=noninteractive \
    apt install -y --no-install-recommends \
        fuse \
        snapd \
        snap-confine \
        squashfuse \
        sudo \
        init

RUN dpkg-divert --local --rename --add /sbin/udevadm \
    && ln -s /bin/true /sbin/udevadm

RUN systemctl enable snapd

VOLUME ["/sys/fs/cgroup"]

STOPSIGNAL SIGRTMIN+3

CMD ["/sbin/init"]
