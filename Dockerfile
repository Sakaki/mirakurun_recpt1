# --- builder ステージ ---
FROM debian:bookworm AS builder
ARG LIBARIB25_REF=v0.2.5-20220902
ARG RECPT1_HASH=3debfa62b7a8cc12211d57e977887b50b3c2d68a

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      git build-essential pkg-config cmake libpcsclite-dev ca-certificates autoconf automake && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src
RUN git clone --depth 1 --branch ${LIBARIB25_REF} https://github.com/stz2012/libarib25.git
RUN mkdir -p libarib25/build && cd libarib25/build && \
    cmake .. && make && make install

WORKDIR /src/recpt1
RUN git init && git remote add origin https://github.com/stz2012/recpt1.git && \
    git fetch --depth 1 origin ${RECPT1_HASH} && git checkout FETCH_HEAD
WORKDIR /src/recpt1/recpt1
RUN ./autogen.sh && ./configure --enable-b25 && make

# --- 最終イメージ ---
FROM chinachu/mirakurun:latest
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      pcscd libpcsclite1 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# builder からバイナリとライブラリを持ってくる
COPY --from=builder /usr/local/lib/libarib25* /usr/local/lib/
COPY --from=builder /usr/local/include/arib25 /usr/local/include/arib25
COPY --from=builder /src/recpt1/recpt1/recpt1 /usr/local/bin/
COPY --from=builder /src/recpt1/recpt1/checksignal /usr/local/bin/
RUN ldconfig
