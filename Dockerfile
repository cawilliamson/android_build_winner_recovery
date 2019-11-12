FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C

RUN apt -y update
RUN apt -y dist-upgrade
RUN apt -y install \
  bc \
  bison \
  build-essential \
  g++-multilib \
  git \
  libssl-dev \
  m4 \
  python \
  python-pip \
  python3 \
  rsync \
  wget \
  zip

RUN wget -O /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo
RUN chmod +x /usr/local/bin/repo
