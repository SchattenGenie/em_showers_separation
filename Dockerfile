FROM ubuntu:18.04
MAINTAINER Vladislav Belavin <belavin@phystech.edu>

# basic setup
SHELL ["/bin/bash", "-c"]

# update
RUN apt-get -y update && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:gophers/archive && \
    apt-get -y update && \
    apt-get install -y --no-install-recommends apt-utils curl \
    bzip2 gcc git wget g++ build-essential libc6-dev make pkg-config \
    golang-1.10-go libzmq3-dev

# Golang
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/lib/go-1.10/bin:$PATH

# miniconda + scientific python stack
RUN curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /root/miniconda

# activate
ENV PATH /root/miniconda/bin:$PATH

RUN conda update -n base conda
RUN pip install --upgrade pip

RUN conda install -y pip numpy scipy jupyter matplotlib rpy2 tqdm pandas
RUN conda install -y pytorch-cpu torchvision-cpu -c pytorch

# zeromq
# RUN go get github.com/pebbe/zmq4
# RUN pip install pyzmq pywavelets schema pyro-ppl schema
# RUN wget https://dl.influxdata.com/influxdb/releases/influxdb_1.6.2_amd64.deb && dpkg -i influxdb_1.6.2_amd64.deb && pip install influxdb
# RUN Rscript -e "install.packages('dtw', repos = 'http://cran.us.r-project.org')"
# RUN pip isntall timeout_decorator
RUN conda install scikit-learn
RUN pip install psutil
RUN pip install pyyaml
