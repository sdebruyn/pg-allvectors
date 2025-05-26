ARG PG_VERSION=16
ARG DEBIAN_VERSION=bookworm
FROM postgres:${PG_VERSION}-${DEBIAN_VERSION}
ARG PG_VERSION=16
ARG PGVECTOR_VERSION=0.8.0
ARG VECTORS_VERSION=0.4.0
ARG VCHORD_VERSION=0.4.1

RUN apt-get update && \
    apt-mark hold locales && \
    apt-get install -y --no-install-recommends curl git ca-certificates build-essential postgresql-server-dev-$PG_VERSION && \
    git clone --branch v${PGVECTOR_VERSION} https://github.com/pgvector/pgvector.git /tmp/pgvector && \
    cd /tmp/pgvector && \
    make clean && \
    make OPTFLAGS="" && \
    make install && \
    apt-get remove -y git build-essential postgresql-server-dev-$PG_VERSION && \
    apt-get autoremove -y && \
    apt-mark unhold locales && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/pgvector

RUN set -e && \
    ARCH=$(dpkg --print-architecture) && \
    curl -fsSL -o /tmp/vectors.deb \
    "https://github.com/tensorchord/pgvecto.rs/releases/download/v${VECTORS_VERSION}/vectors-pg${PG_VERSION}_${VECTORS_VERSION}_${ARCH}.deb" && \
    dpkg -i /tmp/vectors.deb && \
    rm -f /tmp/vectors.deb

RUN set -e && \
    ARCH=$(dpkg --print-architecture) && \
    curl -fsSL -o /tmp/vchord.deb \
    "https://github.com/tensorchord/VectorChord/releases/download/${VCHORD_VERSION}/postgresql-${PG_VERSION}-vchord_${VCHORD_VERSION}-1_${ARCH}.deb" && \
    dpkg -i /tmp/vchord.deb && \
    rm -f /tmp/vchord.deb

CMD ["postgres", "-c" ,"shared_preload_libraries=vectors.so,vchord.so", "-c", "search_path=\"$user\", public, vectors", "-c", "logging_collector=on"]
