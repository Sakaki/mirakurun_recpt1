# Stage-1: libarib25 / recpt1 のビルド
FROM debian:bookworm AS builder
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        build-essential \
        pkg-config \
        cmake \
        libpcsclite-dev \
        ca-certificates \
        autoconf \
        automake
RUN git clone https://github.com/stz2012/libarib25.git
RUN mkdir -p libarib25/build
WORKDIR /libarib25/build
RUN cmake .. && make && make install
RUN git clone https://github.com/stz2012/recpt1.git /recpt1
WORKDIR /recpt1/recpt1
RUN ./autogen.sh && ./configure --enable-b25 && make

# Stage‑2: mirakurun のビルド
FROM chinachu/mirakurun:latest
RUN apt-get update && apt-get install -y --no-install-recommends \
        pcscd \
        libpcsclite1 \
        build-essential \
        pkg-config \
        git \
        cmake \
        libpcsclite-dev \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/stz2012/libarib25.git && \
    cd libarib25 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# builder から recpt1 と checksignal のコピー
COPY --from=builder /recpt1/recpt1/recpt1 /usr/local/bin/
COPY --from=builder /recpt1/recpt1/checksignal /usr/local/bin/
