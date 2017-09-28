FROM nvidia/cuda:8.0-runtime-ubuntu16.04

RUN apt-get update \
 && apt-get upgrade -y

RUN apt-get install curl openssh-server -y \
 && mkdir -p /root/.ssh \
 && chmod 700 /root/.ssh/ \
 && mkdir -p /var/run/sshd

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN apt-get install -y vim screen git byobu emacs bash-completion gfortran build-essential curl wget make cmake autoconf libtool python-pip gdb software-properties-common
RUN apt-get install -y aptitude p7zip unzip xterm rsync subversion rpm libstdc++6 octave liboctave-dev r-base linux-headers-virtual sudo nano fftw-dev libgsl-dev tree

RUN wget https://storage.googleapis.com/eureka-cudnn/libcudnn6_6.0.21-1%2Bcuda8.0_amd64.deb -P /tmp/
RUN dpkg -i /tmp/libcudnn6*
RUN rm /tmp/libcudnn6*

RUN apt-get install python-pip python-dev python-virtualenv
RUN virtualenv --system-site-packages /root/tensorflow-gpu
RUN virtualenv --system-site-packages /root/tensorflow-cpu
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN source /root/tensorflow-gpu/bin/activate && pip install tensorflow-gpu
RUN source /root/tensorflow-cpu/bin/activate && pip install tensorflow

RUN apt-get clean

RUN rm /etc/update-motd.d/*
COPY ./banner.txt /etc/motd

RUN echo 'PS1="\\[\\e[1;34m\\][\\w]\\$\\[\\e[m\\] "' >> ~/.bashrc

RUN mkdir -p /examples
COPY pi.py /examples
COPY pi.py /root
COPY hash.py /examples
COPY hash.py /root

COPY sshd_config /etc/ssh/sshd_config

RUN mkdir -p /root/.eureka/
RUN npm install -g eureka-cli

EXPOSE 22
COPY container_entry.sh /etc/
CMD /etc/container_entry.sh "$PUBLIC_KEY"

