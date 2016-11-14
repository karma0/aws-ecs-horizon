FROM stellar/base:latest

MAINTAINER Bobby Larson <karma0@gmail.com>

ENV STELLAR_CORE_VERSION 0.5.0-298-6f07377f
ENV HORIZON_VERSION 0.6.1


#####
# Docker Setup
###

## PORTS
# PostgreSQL
#EXPOSE 5432
# Horizon main HTTP port
EXPOSE 8000
# stellar-core main HTTP port
EXPOSE 11625
# stellar-core peer node port
EXPOSE 11626

# Share the horizon data directory
VOLUME /opt/stellar


#####
# Scripts
###

ADD dependencies /
RUN ["chmod", "+x", "dependencies"]
RUN /dependencies

ADD install /
RUN ["chmod", "+x", "install"]
RUN /install


#####
# Setup Application
###

RUN ["mkdir", "-p", "/opt/stellar"]
# Make this ephemeral (as opposed to persistant)
#RUN ["touch", "/opt/stellar/.docker-ephemeral"]

RUN [ "adduser", \
  "--disabled-password", \
  "--gecos", "\"\"", \
  "--uid", "10011001", \
  "stellar"]

RUN ["ln", "-s", "/opt/stellar", "/stellar"]
RUN ["ln", "-s", "/opt/stellar/core/etc/stellar-core.cfg", "/stellar-core.cfg"]
RUN ["ln", "-s", "/opt/stellar/horizon/etc/horizon.env", "/horizon.env"]
ADD common /opt/stellar-default/common
ADD pubnet /opt/stellar-default/pubnet
ADD testnet /opt/stellar-default/testnet

ADD start /
RUN ["chmod", "+x", "start"]


#####
# Launch
###

# No-IP dynamic dns configuration
#  Could be bash script:
#  curl 'https://username:password@dynupdate.no-ip.com/nic/update?hostname=example.domain.com'
ADD noip.sh /root/noip.sh


ENTRYPOINT /root/noip.sh && /init -- /start --pubnet
