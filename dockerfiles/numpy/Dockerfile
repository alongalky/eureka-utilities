FROM ruimashita/numpy

RUN apt-get update \
 && apt-get upgrade -y

RUN apt-get install openssh-server -y \
 && mkdir -p /root/.ssh \
 && chmod 700 /root/.ssh/ \
 && mkdir -p /var/run/sshd

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN apt-get install -y vim screen git byobu emacs bash-completion gfortran build-essential curl wget make cmake autoconf libtool python-pip
RUN apt-get install -y aptitude unzip xterm rsync subversion rpm libstdc++6 octave r-base linux-headers-amd64

# MatCont
RUN cd /root \
  && wget 'https://downloads.sourceforge.net/project/matcont/matcontm/matcontm5p1/MatContM_2017.04.10.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fmatcont%2F&ts=1498835921&use_mirror=netix' -O MatContM_2017.04.10.zip \
  && unzip MatContM_2017.04.10.zip \
  && rm MatContM_2017.04.10.zip

# Neuron
RUN cd /tmp \
  && wget https://www.neuron.yale.edu/ftp/neuron/versions/v7.4/nrn-7.4.x86_64.deb \
  && dpkg -i nrn-7.4.x86_64.deb \
  && echo 'export PYTHONHOME="/usr"' >>/etc/profile \
  && echo 'export LD_LIBRARY_PATH="/usr/lib:"' >>/etc/profile

# Quantum Espresso
RUN apt-get install -y quantum-espresso quantum-espresso-data

# MPI goodies
RUN apt-get install libopenmpi-dev libsimgrid-dev

RUN apt-get clean

RUN rm /etc/update-motd.d/*
COPY ./banner.txt /etc/motd

RUN mkdir -p /examples
COPY pi.py /examples
COPY pi.py /root
COPY hash.py /examples
COPY hash.py /root

COPY sshd_config /etc/ssh/sshd_config

RUN mkdir -p /root/.eureka/
RUN npm install -g eureka-cli

EXPOSE 22
CMD echo $PUBLIC_KEY > /root/.ssh/authorized_keys; /usr/sbin/sshd -D
