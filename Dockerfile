FROM ubuntu:16.04
MAINTAINER Nathan Warner <nathan@frcv.net>

ENV SALT_VERSION 2016.11.1+ds-1
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C

ADD SALTSTACK-GPG-KEY.pub /tmp/SALTSTACK-GPG-KEY.pub
RUN echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/sources.list.d/salt.list && \
    apt-key add /tmp/SALTSTACK-GPG-KEY.pub && \
    rm /tmp/SALTSTACK-GPG-KEY.pub

RUN apt-get --quiet --yes update && \
    apt-get --quiet --yes install \
      salt-minion=${SALT_VERSION} \
      wget \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install \
      boto

VOLUME /etc/salt

CMD ["/usr/bin/salt-minion"]
