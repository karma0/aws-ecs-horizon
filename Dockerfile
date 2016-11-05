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
EXPOSE 5005
# websocket_port (trusted access)
EXPOSE 6006


# Share the ripple data directory
VOLUME /var/lib/rippled

# Bring in the validators
ADD validators.txt /etc/validators.txt

# Add custom config
ADD rippled.cfg /etc/rippled.cfg

# No-IP dynamic dns configuration
#  Could be bash script:
#  curl 'https://username:password@dynupdate.no-ip.com/nic/update?hostname=example.domain.com'
ADD noip.sh /root/noip.sh

CMD /root/noip.sh && /opt/ripple/bin/rippled --quiet --fg --conf /etc/rippled.cfg

