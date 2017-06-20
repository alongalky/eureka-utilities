FROM ruimashita/numpy

RUN apt-get update \
 && apt-get install openssh-server -y \
 && mkdir -p /root/.ssh \
 && chmod 700 /root/.ssh/ \
 && mkdir -p /var/run/sshd

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN apt-get install -y vim screen git byobu emacs bash-completion gfortran build-essential curl wget make cmake autoconf libtool python-pip

RUN apt-get clean

RUN rm /etc/update-motd.d/*
COPY ./banner.txt /etc/motd

RUN mkdir -p /examples
COPY pi.py /examples
COPY pi.py /root

COPY sshd_config /etc/ssh/sshd_config

RUN mkdir -p /root/.eureka/
RUN npm install -g eureka-cli

EXPOSE 22
CMD echo $PUBLIC_KEY > /root/.ssh/authorized_keys; /usr/sbin/sshd -D
