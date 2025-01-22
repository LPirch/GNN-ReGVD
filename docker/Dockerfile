FROM python:3.7-slim

RUN apt update && \
    apt install -y git cargo && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

COPY . /regvd

WORKDIR /regvd

SHELL ["/bin/bash", "-c"]

RUN python -m venv .venv && \
    source .venv/bin/activate && \
    pip install --no-cache-dir -r requirements.txt
