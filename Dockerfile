FROM golang:1.10

ENV APPPATH $GOPATH/src/github.com/percona/mongodb_exporter
ENV RELEASE_TAG 0.6.1
WORKDIR $APPPATH

RUN git clone "https://github.com/percona/mongodb_exporter" "$APPPATH" \
    && git checkout 'checkout', 'tags/${RELEASE_TAG}' \
    $$ make \
    && rm -rf "$GOPATH"