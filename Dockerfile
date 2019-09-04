FROM golang:alpine AS build-env
RUN apk --no-cache add build-base git dep

# Build gobackup
ADD gobackup/ ${GOPATH}/src/gobackup
RUN cd ${GOPATH}/src/gobackup \
    && dep ensure -v \
    && go build -o gobackup \
    && strip gobackup

# Build interpolator
ADD interpolator/ ${GOPATH}/src/interpolator
RUN cd ${GOPATH}/src/interpolator \
    && dep ensure -v \
    && go build -o interpolator \
    && strip interpolator

FROM alpine
WORKDIR /usr/local/bin

COPY --from=build-env /go/src/gobackup/gobackup .
COPY --from=build-env /go/src/interpolator/interpolator .

RUN mkdir /etc/gobackup
COPY entrypoint.sh .

CMD ["perform"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]