FROM debian:jessie

# install curl
RUN apt-get update && apt-get install -qy curl

# install go runtime
RUN curl -s https://storage.googleapis.com/golang/go1.2.2.linux-amd64.tar.gz | tar -C /usr/local -xz
RUN wget https://releases.hashicorp.com/envconsul/0.6.1/envconsul_0.6.1_linux_amd64.zip | unzip 

# prepare go environment
ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV TEST "Dies ist ein Test."
ENV PATH $PATH:/usr/local/go/bin:/go/bin

# add the current build context
ADD . /go/src/github.com/svenmalvik/helloworld

# compile the binary
RUN cd /go/src/github.com/svenmalvik/helloworld && go install -v .

EXPOSE 80

ENTRYPOINT ["/go/bin/helloworld"]
