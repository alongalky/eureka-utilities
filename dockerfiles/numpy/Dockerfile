FROM ruimashita/numpy

RUN apt-get update \
 && apt-get install openssh-server -y \
 && apt-get clean \
 && mkdir -p /root/.ssh \
 && mkdir -p /var/run/sshd \
 && chmod 700 /root/.ssh/ \
 && echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

RUN rm /etc/update-motd.d/*
COPY ./banner.txt /etc/
RUN mv /etc/banner.txt /etc/motd

ENV PUBLIC_KEY bla
EXPOSE 22
CMD echo $PUBLIC_KEY > /root/.ssh/authorized_keys; /usr/sbin/sshd -D
