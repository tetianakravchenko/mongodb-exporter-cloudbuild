FROM golang:1.10

ENV APPPATH $GOPATH/src/github.com/percona/mongodb_exporter
ENV RELEASE_TAG 0.6.1
WORKDIR $APPPATH

RUN git clone "https://github.com/percona/mongodb_exporter" "$APPPATH" \
    && git checkout tags/$RELEASE_TAG \
    && make init build

RUN sha256sum mongodb_exporter > mongodb_exporter.sha256

FROM gcr.io/cloud-builders/gsutil:latest

COPY --from=0 /go/src/github.com/percona/mongodb_exporter/mongodb_exporter /workspace/mongodb_exporter
COPY --from=0 /go/src/github.com/percona/mongodb_exporter/mongodb_exporter.sha256 /workspace/mongodb_exporter.sha256
