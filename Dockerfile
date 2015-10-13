FROM debian:jessie
MAINTAINER Nathan Warner <nathan@frcv.net>

ENV SALT_VERSION 2015.8.0+ds-2
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C

RUN echo "deb http://repo.saltstack.com/apt/debian jessie contrib" > /etc/apt/sources.list.d/salt.list
ADD SALTSTACK-GPG-KEY.pub /tmp/SALTSTACK-GPG-KEY.pub
RUN apt-key add /tmp/SALTSTACK-GPG-KEY.pub && \
    rm /tmp/SALTSTACK-GPG-KEY.pub

RUN apt-get --quiet --yes update && \
      apt-get --quiet --yes install \
      salt-minion=${SALT_VERSION} \
      vim \
      ssh \
      net-tools \
      procps \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

VOLUME /etc/salt

CMD ["/usr/bin/salt-minion"]
