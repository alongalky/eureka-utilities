FROM ubuntu:xenial

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

# MatCont
RUN cd /opt \
  && wget 'https://downloads.sourceforge.net/project/matcont/matcontm/matcontm5p1/MatContM_2017.04.10.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fmatcont%2F&ts=1498835921&use_mirror=netix' -O MatContM_2017.04.10.zip \
  && unzip MatContM_2017.04.10.zip \
  && rm MatContM_2017.04.10.zip

# Neuron
RUN cd /tmp \
  && wget https://www.neuron.yale.edu/ftp/neuron/versions/v7.4/nrn-7.4.x86_64.deb \
  && dpkg -i nrn-7.4.x86_64.deb \
  && echo 'export PYTHONHOME="/usr"' >>/etc/profile \
  && echo 'export LD_LIBRARY_PATH="/usr/lib:"' >>/etc/profile \
  && rm nrn-7.4.x86_64.deb

# Python Numpy
RUN apt-get install -y python-numpy

# Quantum Espresso
RUN apt-get install -y quantum-espresso quantum-espresso-data

# MPI goodies
RUN apt-get install -y libopenmpi-dev libsimgrid-dev libboost-all-dev
RUN echo "shopt -s expand_aliases" >>/etc/profile
RUN echo "alias mpirun='mpirun --allow-run-as-root '" >>/etc/profile
RUN echo "alias mpiexec='mpiexec --allow-run-as-root '" >>/etc/profile

# Abinit
RUN apt-get install -y abinit abinit-doc

# LAMMPS
RUN apt-get install -y lammps lammps-doc

# NWChem
RUN apt-get install -y nwchem nwchem-data

# TensorFlow CPU only
RUN pip install tensorflow

# OpenFOAM
RUN add-apt-repository http://dl.openfoam.org/ubuntu \
  && wget -O - http://dl.openfoam.org/gpg.key | apt-key add - \
  && apt-get update \
  && apt-get install -y openfoam5
RUN echo '. /opt/openfoam5/etc/bashrc' >>/etc/profile

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
COPY container_entry.sh /etc/
CMD /etc/container_entry.sh "$PUBLIC_KEY"
