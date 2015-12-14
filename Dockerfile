FROM ubuntu:14.04
MAINTAINER Nathan Warner <nathan@frcv.net>

ENV SALT_VERSION 2015.8.3+ds-1
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C

ADD SALTSTACK-GPG-KEY.pub /tmp/SALTSTACK-GPG-KEY.pub
RUN echo "deb http://repo.saltstack.com/apt/ubuntu/ubuntu14/latest trusty main" > /etc/apt/sources.list.d/salt.list && \
    apt-key add /tmp/SALTSTACK-GPG-KEY.pub && \
    rm /tmp/SALTSTACK-GPG-KEY.pub

RUN apt-get --quiet --yes update && \
      apt-get --quiet --yes install \
      salt-minion=${SALT_VERSION} \
      vim \
      ssh \
      net-tools \
      procps \
      python-psutil \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

VOLUME /etc/salt

CMD ["/usr/bin/salt-minion"]
