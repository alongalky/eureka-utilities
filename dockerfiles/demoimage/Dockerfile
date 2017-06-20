FROM ruimashita/numpy

RUN apt-get update \
 && apt-get install openssh-server -y \
 && mkdir -p /var/run/sshd

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN apt-get install -y vim screen git byobu emacs bash-completion build-essential gfortran curl wget make cmake autoconf libtool python-pip

RUN apt-get clean

RUN rm /etc/update-motd.d/*
COPY ./banner.txt /etc/
RUN mv /etc/banner.txt /etc/motd

RUN mkdir -p /examples
COPY pi.py /examples
COPY pi.py /root

RUN bash -l -c 'echo -e "eureka\neureka" | passwd root'
COPY sshd_config /etc/ssh/sshd_config

RUN mkdir -p /root/.eureka/
RUN npm install -g eureka-cli

RUN echo machina >/etc/hostname
RUN echo "127.0.0.1 machina" >>/etc/hosts

EXPOSE 22
CMD /usr/sbin/sshd -D
