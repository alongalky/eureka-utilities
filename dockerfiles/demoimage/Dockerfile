FROM ruimashita/numpy

RUN apt-get update \
 && apt-get install openssh-server -y \
 && mkdir -p /root/.ssh \
 && mkdir -p /var/run/sshd \
 && chmod 700 /root/.ssh/ \
 && echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config \
 && echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config \
 && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
 && echo "UsePAM no" >> /etc/ssh/sshd_config

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN apt-get install -y vim screen git byobu emacs bash-completion build-essential curl wget make cmake autoconf libtool python-pip

RUN apt-get clean

RUN rm /etc/update-motd.d/*
COPY ./banner.txt /etc/
RUN mv /etc/banner.txt /etc/motd

RUN mkdir -p /examples
COPY pi.py /examples

EXPOSE 22
CMD /usr/sbin/sshd -D
