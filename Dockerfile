FROM golang:1.12.1

# RUN apt update && apt install -y gettext-base

RUN cd /tmp && \
    wget https://github.com/quantumew/mustache-cli/releases/download/v0.2/mustache-amd64.tar.gz && \
    tar xzf mustache-amd64.tar.gz && \
    mv mustache/linux/mustache /usr/local/bin/

RUN cd /usr/local/bin && \
    wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 && \
    chmod +x /usr/local/bin/jq-linux64 && \
    ln -s /usr/local/bin/jq-linux64 /usr/local/bin/jq

RUN mkdir -p /server-conf/ && \
  mkdir -p /go/src/github.com/fullstorydev/hauser/

# ADD . /go/src/github.com/fullstorydev/hauser/

WORKDIR /go/src/github.com/fullstorydev/hauser/
RUN git clone https://github.com/fullstorydev/hauser.git .
RUN go build -o /usr/local/bin/hauser .
COPY boot.sh /go/src/github.com/fullstorydev/hauser/

COPY config.toml.mustache /server-conf/

ENTRYPOINT ["./boot.sh"]
