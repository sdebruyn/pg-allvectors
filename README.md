# Docker image for migrating between pgvector, pgvecto.rs, and VectorChord

This image builds upon the default `postgres` image and includes the following extra extensions:

* [pgvector](https://github.com/pgvector/pgvector)
* [pgvecto.rs](https://github.com/tensorchord/pgvecto.rs)
* [VectorChord](https://github.com/tensorchord/VectorChord)

Since migrations from one to the other typically require at least 2 of the above to be installed, this image includes all 3.

[![Docker builds](https://github.com/sdebruyn/pg-allvectors/actions/workflows/build.yml/badge.svg)](https://github.com/sdebruyn/pg-allvectors/actions/workflows/build.yml)

## Usage

Just replace your Postgres image with any of the images available [here](https://github.com/sdebruyn/pg-allvectors/pkgs/container/pg-allvectors/versions?filters%5Bversion_type%5D=tagged).

## Versions

The versions of Debian, Postgres, pgvector, pgvecto.rs, and VectorChord are mentioned in the tag. Pick the combination that suits your needs.

Feel free to open an issue if you need a different version of Postgres or any of the extensions.
