FROM ruimashita/numpy
MAINTAINER alongalky <alon@eureka.guru>

RUN apt-get update \
 && apt-get install openssh-server -y \
 && apt-get clean \
 && mkdir -p /root/.ssh \
 && mkdir -p /var/run/sshd \
 && chmod 700 /root/.ssh/ \
 && echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

ENV PUBLIC_KEY bla
EXPOSE 22
CMD echo $PUBLIC_KEY > /root/.ssh/authorized_keys; /usr/sbin/sshd -D
