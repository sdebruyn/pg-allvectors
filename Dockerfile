ARG PG_VERSION=16
ARG DEBIAN_VERSION=bookworm
FROM postgres:${PG_VERSION}-${DEBIAN_VERSION}
ARG PG_VERSION=16
ARG VECTORS_VERSION=0.4.0
ARG VCHORD_VERSION=0.4.1

RUN --mount=source=./pgvector,target=/tmp/pgvector_mount cp -r /tmp/pgvector_mount /tmp/pgvector && \
    apt-get update && \
    apt-mark hold locales && \
    apt-get install -y --no-install-recommends curl ca-certificates build-essential postgresql-server-dev-$PG_VERSION && \
    cd /tmp/pgvector && \
    make clean && \
    make OPTFLAGS="" && \
    make install && \
    apt-get remove -y build-essential postgresql-server-dev-$PG_VERSION && \
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
