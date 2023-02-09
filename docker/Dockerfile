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

RUN rm -f \
		/etc/systemd/system/*.wants/* \
		/lib/systemd/system/local-fs.target.wants/* \
		/lib/systemd/system/multi-user.target.wants/* \
		/lib/systemd/system/sockets.target.wants/*initctl*

RUN find \
		/lib/systemd/system/sysinit.target.wants \
		\( -type f -or -type l \) -and -not -name '*systemd-tmpfiles-setup*' \
		-delete

RUN rm -f /lib/systemd/system/systemd-update-utmp-runlevel.service
RUN rm -vf /usr/share/systemd/tmp.mount

RUN echo ShowStatus=no >> /etc/systemd/system.conf

RUN systemctl set-default basic.target

RUN systemctl disable ondemand.service

RUN systemctl enable snapd

ADD user-command.service /etc/systemd/system/
RUN systemctl enable user-command.service
RUN mkdir -p /data

ADD entrypoint.sh /bin/
ADD install-snapcraft.sh /usr/local/bin/

STOPSIGNAL SIGRTMIN+3

ENTRYPOINT ["/bin/entrypoint.sh"]
