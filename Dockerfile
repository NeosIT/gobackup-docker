FROM golang:alpine AS build-env
RUN apk --no-cache add build-base git dep openssh-client

ENV GOBACKUP_VERSION 0.11.0
ENV INTERPOLATOR_VERSION 0.9.0

RUN git clone https://github.com/NeosIT/gobackup.git ${GOPATH}/src/gobackup
RUN cd ${GOPATH}/src/gobackup \
    && git checkout ${GOBACKUP_VERSION} \
    && dep ensure -v \
    && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o gobackup \
    && strip gobackup

RUN git clone https://github.com/NeosIT/interpolator.git ${GOPATH}/src/interpolator \
    && cd ${GOPATH}/src/interpolator \
    && git checkout ${INTERPOLATOR_VERSION} \
    && dep ensure -v \
    && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o interpolator \
    && strip interpolator

# Alpine doesn't work, archives aren't created. Probably due to musl libc
FROM fedora:31
WORKDIR /usr/local/bin

COPY mongodb.repo /etc/yum.repos.d

RUN dnf install https://download.postgresql.org/pub/repos/yum/reporpms/F-31-x86_64/pgdg-fedora-repo-latest.noarch.rpm -y \
    && dnf install postgresql12 mariadb redis mongodb-org-tools cronie procps-ng vim htop strace --refresh -y \
    && dnf clean all

COPY --from=build-env /go/src/gobackup/gobackup .
COPY --from=build-env /go/src/interpolator/interpolator .

RUN mkdir /etc/gobackup
COPY entrypoint.sh .

CMD ["perform"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]