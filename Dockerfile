FROM golang:1.10

ENV WORKDIR /go/src/github.com/percona/mongodb_exporter
ENV RELEASE_TAG 0.6.1
WORKDIR $WORKDIR

RUN git clone "https://github.com/percona/mongodb_exporter" "$WORKDIR" \
    && git checkout tags/$RELEASE_TAG \
    && make init build \
    && sha256sum mongodb_exporter > mongodb_exporter.sha256

FROM gcr.io/cloud-builders/gsutil:latest

ENV WORKDIR /go/src/github.com/percona/mongodb_exporter

COPY --from=0 $WORKDIR/mongodb_exporter /mongodb_exporter
COPY --from=0 $WORKDIR/mongodb_exporter.sha256 /mongodb_exporter.sha256
