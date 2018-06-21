FROM golang:1.10

ENV APPPATH $GOPATH/src/github.com/percona/mongodb_exporter
ENV RELEASE_TAG 0.6.1
WORKDIR $APPPATH

RUN git clone "https://github.com/percona/mongodb_exporter" "$APPPATH" \
    && git checkout tags/$RELEASE_TAG \
    && make format build \
    && sha256sum mongodb-exporter > mongodb-exporter.sha256 \
    && cp mongodb-exporter /workspace \
    && cp mongodb-exporter.sha256 /workspace \
    && rm -rf "$GOPATH"
