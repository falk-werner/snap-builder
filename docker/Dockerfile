ARG REGISTRY_PREFIX=''
ARG CODENAME='focal'

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
        systemd

RUN dpkg-divert --local --rename --add /sbin/udevadm \
    && ln -s /bin/true /sbin/udevadm


RUN echo ShowStatus=no >> /etc/systemd/system.conf

RUN systemctl set-default basic.target

RUN systemctl enable snapd

ADD user-command.service /etc/systemd/system/
RUN systemctl enable user-command.service
RUN mkdir -p /data

ADD entrypoint.sh /bin/
ADD install-snapcraft.sh /usr/local/bin/

STOPSIGNAL SIGRTMIN+3

ENTRYPOINT ["/bin/entrypoint.sh"]
