FROM nvidia/cuda:12.5.1-cudnn-devel-ubuntu22.04

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV PYTHON_VERSION 3.7.9
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV LC_ALL C.UTF-8

SHELL ["/bin/bash", "-c"]

ENV CONTAINER_DEPS="git cargo"
ENV PYTHON_DEPS="wget gradle software-properties-common build-essential libgraphviz-dev tar zlib1g-dev libffi-dev libreadline-dev liblzma-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev p7zip-full git"

RUN apt update && \
apt install -y $CONTAINER_DEPS $PYTHON_DEPS && \
apt clean && \
rm -rf /var/lib/apt/lists/*

RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz && \
    tar -xf Python-${PYTHON_VERSION}.tar.xz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations && \
    make -j 8 && \
    make install && \
    ln -s /usr/local/bin/python3 /usr/bin/python && \
    ln -s /usr/local/bin/pip3 /usr/bin/pip && \
    cd .. && \
    rm -rf Python-${PYTHON_VERSION} && \
    rm Python-${PYTHON_VERSION}.tar.xz


COPY . /regvd

WORKDIR /regvd

RUN pip install --no-cache-dir virtualenv
# RUN virtualenv .venv && \
#     source .venv/bin/activate && \
#     pip install --no-cache-dir -r requirements.txt