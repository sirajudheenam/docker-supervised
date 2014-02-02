FROM zardoz.podzone.org:11002/core/centos

EXPOSE 22
CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]

ADD src/ /tmp/src/
RUN /tmp/src/setup.sh
