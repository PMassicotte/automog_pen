# This is the SHA of a multi-arch manifest, so it'll use the native
# container on amd64 / arm64.
ARG BASE=ghcr.io/r-lib/rig/ubuntu-22.04-release@sha256:1dc2de2cf32dd10945a4ed3714ae35e73b01e1ea47f458c3e9dc82eef016a3e2

# -------------------------------------------------------------------------
# build stage has stuff needed for everything, e.g. R, hard dependencies
# -------------------------------------------------------------------------
FROM --platform=linux/amd64 ${BASE} AS build

COPY ./DESCRIPTION .
RUN R -q -e 'pak::pkg_install("deps::.", lib = .Library); pak::pak_cleanup(force = TRUE)' && \
    apt-get clean && \
    rm -rf DESCRIPTION /tmp/*

