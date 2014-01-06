FROM localhost:5000/core/centos

EXPOSE 22
CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]

ADD config/supervisord.conf /etc/supervisord.conf
ADD config/program-sshd.conf /etc/supervisor.d/

ADD post-install.sh /
RUN /post-install.sh

