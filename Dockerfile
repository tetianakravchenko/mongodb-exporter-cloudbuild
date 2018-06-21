FROM golang:1.10

ENV APPPATH $GOPATH/src/github.com/percona/mongodb_exporter
ENV RELEASE_TAG 0.6.1
WORKDIR $APPPATH

RUN git clone "https://github.com/percona/mongodb_exporter" "$APPPATH" \
    && git checkout tags/$RELEASE_TAG \
    && make init build

RUN sha256sum mongodb_exporter > mongodb_exporter.sha256 \
    && cp mongodb_exporter /workspace \
    && cp mongodb_exporter.sha256 /workspace
