ARG PG_VERSION=16
ARG DEBIAN_VERSION=bookworm
FROM postgres:${PG_VERSION}-${DEBIAN_VERSION}
ARG PG_VERSION=16
ARG VECTORS_VERSION=0.4.0

RUN curl -Lso /tmp/vectors.deb \
    "https://github.com/tensorchord/pgvecto.rs/releases/download/v${VECTORS_VERSION}/vectors-pg${PG_VERSION}_${VECTORS_VERSION}_$(dpkg --print-architecture).deb" \
    && apt-get install -y /tmp/vectors.deb && rm -f /tmp/vectors.deb

RUN --mount=source=./pgvector,target=/tmp/pgvector apt-get update && \
    apt-mark hold locales && \
    apt-get install -y --no-install-recommends build-essential postgresql-server-dev-$PG_VERSION && \
    cd /tmp/pgvector && \
    make clean && \
    make OPTFLAGS="" && \
    make install && \
    apt-get remove -y build-essential postgresql-server-dev-$PG_VERSION && \
    apt-get autoremove -y && \
    apt-mark unhold locales && \
    rm -rf /var/lib/apt/lists/*
