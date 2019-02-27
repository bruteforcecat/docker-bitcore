FROM ubuntu:xenial
MAINTAINER KaFai Choi <kafaicoder@gmail.com>

ARG USER_ID
ARG GROUP_ID

ENV HOME /bitcore

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

RUN groupadd -g ${GROUP_ID} bitcoin \
	&& useradd -u ${USER_ID} -g bitcoin -s /bin/bash -m -d /bitcoin bitcoin

RUN apt-get update && apt-get install -y \
  git \
  libzmq3-dev \
  build-essential \
  python2.7 \
  curl
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install -y nodejs

RUN npm install bitcore@beta -g --unsafe
RUN npm install insight-api@beta -g

COPY ./config/livenet.json ./bitcore/bitcore-node.json

VOLUME ["/bitcoin"]
WORKDIR /bitcore

ENTRYPOINT [ "bitcored", "-c", "./bitcore-node.json"]

