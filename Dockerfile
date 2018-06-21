FROM golang:1.10

ENV APPPATH $GOPATH/src/github.com/percona/mongodb_exporter
ENV RELEASE_TAG 0.6.1
WORKDIR $APPPATH

RUN git clone "https://github.com/percona/mongodb_exporter" "$APPPATH" \
    && git checkout tags/$RELEASE_TAG \
    && make init build

RUN sha256sum mongodb_exporter > mongodb_exporter.sha256 \

FROM gcr.io/cloud-builders/gsutil:latest

RUN cp mongodb_exporter gs://mongodb-exporter/mongodb_exporter_${RELEASE_TAG} \
  && cp mongodb_exporter.sha256 gs://mongodb-exporter/mongodb_exporter_${_RELEASE_TAG}.sha256
