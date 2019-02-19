ARG BASE_IMAGE=jonasprogrammer/dev-tools:conan-common-clang
FROM ${BASE_IMAGE}

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends openssh-server \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /run/sshd \
 && sed -i 's/^X11.*$/#\0/g' /etc/ssh/sshd_config \
 && echo "PasswordAuthentication no" >>/etc/ssh/sshd_config \
 && echo "PermitRootLogin no" >>/etc/ssh/sshd_config \
 && echo "X11Forwarding no" >>/etc/ssh/sshd_config \
 && echo "AllowTcpForwarding no" >>/etc/ssh/sshd_config

COPY entrypoint.sh /entrypoint.sh

EXPOSE 22

RUN mkdir -p .ssh && chmod 700 .ssh && chown build-dev:build-dev .ssh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
