FROM node:4
MAINTAINER KaFai Choi <kafaicoder@gmail.com>

ENV HOME /bitcore

RUN apt-get update && apt-get install -y \
  libzmq3-dev \
  build-essential \
  python2.7 \
  curl
RUN update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1

run mkdir /bitcore
RUN npm install -g --unsafe-perm bitcore@4.1.0

VOLUME ["/bitcoin"]
WORKDIR /bitcore

COPY ./config/livenet.json ./bitcore-node.json

ENTRYPOINT [ "bitcored", "-c", "./bitcore-node.json"]