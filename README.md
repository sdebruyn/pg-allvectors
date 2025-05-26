# Docker image for migrating between pgvector, pgvecto.rs, and VectorChord

This image builds upon the default `postgres` image and includes the following extra extensions:

* [pgvector](https://github.com/pgvector/pgvector)
* [pgvecto.rs](https://github.com/tensorchord/pgvecto.rs)
* [VectorChord](https://github.com/tensorchord/VectorChord)

Since migrations from one to the other typically require at least 2 of the above to be installed, this image includes all 3.

[![Docker builds](https://github.com/sdebruyn/pg-allvectors/actions/workflows/build.yml/badge.svg)](https://github.com/sdebruyn/pg-allvectors/actions/workflows/build.yml)

## Usage

Just replace your Postgres image with one of the following:

* `ghcr.io/sdebruyn/pg-allvectors:17-bookworm`
* `ghcr.io/sdebruyn/pg-allvectors:16-bookworm`
* `ghcr.io/sdebruyn/pg-allvectors:15-bookworm`
* `ghcr.io/sdebruyn/pg-allvectors:14-bookworm`

## Versions

Pick the Postgres version from the list above that matches your needs. The `bookworm` tag refers to the Debian Bookworm base image.

The following versions of the extensions are installed:

* pgvector: 0.8.0
* pgvecto.rs: 0.4.0
* VectorChord: 0.4.1

Feel free to open an issue if you need a different version of Postgres or any of the extensions.
