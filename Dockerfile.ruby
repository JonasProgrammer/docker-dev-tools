ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG UID=4200
ARG GID=${UID}

ENV LD_LIBRARY_PATH /usr/local/lib

WORKDIR /usr/local

RUN ( grep -Fxq '. /etc/profile.local' /etc/profile || ( echo ". /etc/profile.local" >>/etc/profile ) ); \
    IFS=$(printf '\n'); for e in $(); do echo "export $e" >> /etc/profile.local; done; unset $IFS; \
    echo 'export PATH=$GEM_HOME/bin:$PATH' >> /etc/profile.local \
 && groupadd --gid ${GID} build-dev \
 && adduser --gid ${GID} --uid ${UID} --gecos '' --no-create-home --home /usr/local/src --disabled-password --disabled-login build-dev \
 && mkdir -p /usr/local/src && chown -R build-dev:build-dev /usr/local/src

USER build-dev
WORKDIR /usr/local/src

CMD ["/bin/bash"]
