FROM ubuntu:15.04

RUN apt-get -y update
RUN apt-get -y install yum-utils alien
RUN rpm -Uvh https://mirrors.ripple.com/ripple-repo-el7.rpm
RUN yumdownloader --enablerepo=ripple-stable --releasever=el7 rippled
RUN rpm --import https://mirrors.ripple.com/rpm/RPM-GPG-KEY-ripple-release && rpm -K rippled*.rpm
RUN alien -i --scripts rippled*.rpm && rm rippled*.rpm


# peer_port
EXPOSE 51235
# websocket_public_port
EXPOSE 5006
# websocket_port (trusted access)
EXPOSE 6006


# Share the ripple data directory
VOLUME /var/lib/rippled

# Add custom config
ADD rippled.cfg /etc/rippled.cfg
ADD validators.txt /etc/validators.txt

CMD ["/opt/ripple/bin/rippled", "--net", "--fg", "--conf", "/etc/rippled.cfg"]
